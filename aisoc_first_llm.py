import streamlit as st
from groq import Groq
from sentence_transformers import SentenceTransformer
from langchain.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
import faiss
import numpy as np
import tempfile
import os



def initialize_groq(api_key):
    return Groq(api_key = api_key)

def get_groq_response_with_memory(client, context, question, conversation_history,model_name="llama-3.1-8b-instant"):
    prompt = f"""
        Based on the following context, please answer the question in a concise manner:
        Context: {context}
        Question: {question}
        Answer: provide a clear, accurate answer based only on the information in the context.
        """
    try:
        response = client.chat.completions.create(
            model=model_name,
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": prompt}
            ],
            temperature = 0.0,
            max_tokens = 500,
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        return f"Error generating response: {str(e)}"
    
@st.cache_resource
def load_embedding_model():
    return SentenceTransformer('all-MiniLM-L6-v2')


class LocalVectorStore:
    def __init__(self, embedding_model):
        self.embedding_model = embedding_model
        self.chunks = []
        self.embeddings = None
        self.index = None

    def add_documents(self, documents):
        self.chunks = [doc.page_content for doc in documents]

        self.embeddings = self.embedding_model.encode(self.chunks)
        dimension = self.embeddings.shape[1]  # 384 for all-MiniLM-L6-v2

        self.index = faiss.IndexFlatL2(dimension)
        self.index.add(self.embeddings)

    def similarity_search(self, query, k=4):
        if self.index is None:
            return []
        
        query_embedding = self.embedding_model.encode([query])
        query_embedding = np.array(query_embedding).astype('float32')

        distances, indices = self.index.search(query_embedding, k)

        results = []
        for i in indices[0]:
            if i < len(self.chunks):
                results.append(self.chunks[i])

        return results
    

    # Document processing function
@st.cache_data
def load_and_split_pdf(uploaded_file):
    with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as tmp_file:
        tmp_file.write(uploaded_file.getvalue())
        tmp_path = tmp_file.name
        
    try:
        loader = PyPDFLoader(tmp_path)
        documents = loader.load()

        text_splitter = RecursiveCharacterTextSplitter(
                chunk_size=1000, 
                chunk_overlap=200,
                separators=["\n\n", "\n", " ", ""]
            )
        chunks = text_splitter.split_documents(documents)

        return chunks
    finally:
            os.unlink(tmp_path)

# conversation management
def manage_conversation_context(conversation_history, max_exchanges=10):
    if len(conversation_history) > max_exchanges:
        return conversation_history[-max_exchanges:]
    return conversation_history

# main processing pipeline
def process_document(uploaded_file, groq_client, embedding_model):
    st.write("Processing document...")

    with st.spinner("Reading PDF..."):
        chunks = load_and_split_pdf(uploaded_file)

    if not chunks:
        st.error("Could not extract any text from the PDF.")
        return

    st.success(f"Document loaded! Found {len(chunks)} chunks.")

    with st.spinner("Creating embeddings (running locally)..."):
            vector_store = LocalVectorStore(embedding_model)
            vector_store.add_documents(chunks)

    st.success("Documents ready for questions!")
            
    if "conversation_history" not in st.session_state:
        st.session_state.conversation_history = []

    st.session_state.vector_store = vector_store
    st.session_state.groq_client = groq_client
    st.session_state.ready = True
    

    if st.session_state.get("ready", False):
        st.header("Ask a question about the document")

        if st.session_state.conversation_history:
                st.info(f"Conversation memory: {len(st.session_state.conversation_history)} exchanges")

            #provide example questions
        st.write("**Try asking:**")
        col1, col2 = st.columns(2)
        with col1:
            if st.button("What is this document about?"):
                    st.session_state.question = "What is this document about?"
            with col2:
                if st.button("What are the key findings or conclusions?"):
                    st.session_state.question = "What are the key findings or conclusions?"
                if st.button("Can you elaborate on that?"):
                    st.session_state.question = "Can you elaborate on that?"

            #Clear conversation button
            if st.session_state.conversation_history:
                if st.button("Clear conversation"):
                    st.session_state.conversation_history = []
                    st.success("conversation history cleared!")
                    st.rerun()

            #Main question input
            question = st.text_input(
                "Ask a question about the document:",
                value=st.session_state.get("question", ""), 
                key="question_input",
                placeholder="Ask a question about the document... I remember our conversation"

            )
            #process question when user enters one
            if question:
                try:
                    with st.spinner("Thinking... (using conversation context + Groq's lightning-fast API)..."):
                        #find relevant chunks using similarity search
                        relevant_chunks = st.session_state.vector_store.similarity_search(question, k=4)

                        if not relevant_chunks:
                            st.warning("No relevant information found in the document. Try rephrasing your question")
                            return
                        
                        #Combine chunks into context
                        context = "\n\n".join(relevant_chunks)

                        #Get conversation history
                        conversation_history = manage_conversation_context(
                            st.session_state.conversation_history,
                            max_exchanges=10)

                        #Get response with conversation memory
                        answer = get_groq_response_with_memory(
                            st.session_state.groq_client,
                            context,
                            question,
                            conversation_history,
                            st.session_state.get("selected_model", "llama-3.1-8b-instant")
                        )

                        #store this question and answer in conversation history
                        st.session_state.conversation_history.append({
                            "question": question,
                            "answer": answer
                        })

                        #Display the answer
                        st.write("**Answer:**")
                        st.write(answer)

                        #show performance info
                        st.success("⚡ Powered by Groq's blazing-fast inference + conversation memory!")

                        #show conversation history
                        if len(st.session_state.conversation_history) > 1:
                            with st.expander("Conversation History"):
                                for i, (q, a) in enumerate(st.session_state.conversation_history[:-1]):
                                    st.write(f"**Q{i+1}:** {q}")
                                    display_answer = a[:200] + "..." if len(a) > 200 else a
                                    st.write(f"**A{i+1}:** {display_answer}")
                                    st.write("---")
                        
                        # Show source chunks for transparency and debugging
                        with st.expander("📚 View source chunks"):
                            for i, chunk in enumerate(relevant_chunks):
                                st.write(f"**Chunk {i+1}:**")
                                # Truncate long chunks for readability
                                display_chunk = chunk[:400] + "..." if len(chunk) > 400 else chunk
                                st.write(display_chunk)
                                st.write("---")
                        
                except Exception as e:
                    if "rate_limit" in str(e).lower():
                        st.error("Rate limit exceeded. Please try again later.")
                        st.info("Free tiers are generous but not unlimited. Consider upgrading for more capacity.")
                    elif "context_length" in str(e).lower():
                        st.error("📏 Conversation too long. Clearing older messages...")
                        st.session_state.conversation_history = st.session_state.conversation_history[-5:]
                        st.info("💡 Try asking your question again!")
                    else:
                        st.error(f"❌ Error: {str(e)}")
                        st.info("💡 Try simplifying your question or check your API key.")

# Main application
def main():
    st.set_page_config(
        page_title="Free Document Q&A with Memory", 
        page_icon="🆓",
        layout="wide"
    )
    st.title("🆓 Free Document Q&A with Conversation Memory")
    st.write("100% free APIs - Upload a PDF and have a conversation about it!")
    
    # Sidebar for configuration
    st.sidebar.header("🔧 Setup (Free!)")
    st.sidebar.write("Get your free Groq API key at: https://console.groq.com")
    
    # API key input
    groq_api_key = st.sidebar.text_input("Groq API Key", type="password")
    
    # Model selection dropdown
    model_options = {
        "llama-3.1-8b-instant": "Llama 3.1 8B (Fast & Smart) - 131k context",
        "llama-3.3-70b-versatile": "Llama 3.3 70B (Most Capable) - 131k context",
        "gemma2-9b-it": "Gemma2 9B (Balanced) - 8k context"
    }

    selected_model = st.sidebar.selectbox(
        "Choose Model:",
        options=list(model_options.keys()),
        format_func=lambda x: model_options[x],
        index=0  # Default to llama-3.1-8b-instant
    )
    
    # Conversation settings
    st.sidebar.header("💬 Conversation Settings")
    max_history = st.sidebar.slider(
        "Max conversation exchanges to remember:",
        min_value=3,
        max_value=20,
        value=10,
        help="Higher values provide more context but use more tokens"
    )
    # Show helpful info if no API key
    if not groq_api_key:
        st.warning("⚠️ Get your free Groq API key at https://console.groq.com")
        st.info("💡 No credit card required - just sign up and start building!")
        
        # Show demo info
        st.markdown("""
        ### 🎯 What You'll Build Today
        - **Document Q&A**: Upload any PDF and ask questions
        - **Conversation Memory**: Reference previous answers naturally
        - **100% Free**: No hidden costs or credit cards needed
        - **Lightning Fast**: Groq's inference is typically under 1 second
        - **Privacy First**: Documents processed locally, only relevant chunks sent to API
        """)
        st.stop()

    # Initialize clients
    groq_client = initialize_groq(groq_api_key)
    embedding_model = load_embedding_model()
    
    # Store selected model and settings in session state
    st.session_state.selected_model = selected_model
    st.session_state.max_history = max_history
    
    # File upload widget
    uploaded_file = st.file_uploader(
        "Choose a PDF file", 
        type="pdf",
        help="Upload any PDF document to start asking questions about it"
    )

    # Process uploaded file
    if uploaded_file is not None:
        process_document(uploaded_file, groq_client, embedding_model)
    else:
        # Show instructions when no file is uploaded
        st.markdown("""
        ### 🚀 Getting Started
        1. **Get your free Groq API key** at https://console.groq.com
        2. **Enter your API key** in the sidebar
        3. **Upload a PDF document** using the file uploader above
        4. **Start asking questions** - the AI remembers your conversation!
        
        ### 💡 Example Questions to Try
        - "What is this document about?"
        - "Who are the main authors?"
        - "Can you elaborate on that?" (references previous answer)
        - "How does it compare to what we discussed earlier?"
        """)

# Application entry point
if __name__ == "__main__":
    main()
