

#creating a list from a sequence of numbers, matrices,character and factor vectors
> my_list <- list(seq(from=-4,to=4,length.out = 20), matrix(data=c(F,T,T,T,F,T,T,F,F),nrow=3, ncol=3,byrow=FALSE),c("don","quixote"),factor(c("LOW","MED","LOW","MED","MED","HIGH")))
> my_list
[[1]]
 [1] -4.0000000 -3.5789474 -3.1578947 -2.7368421 -2.3157895 -1.8947368 -1.4736842 -1.0526316 -0.6315789
[10] -0.2105263  0.2105263  0.6315789  1.0526316  1.4736842  1.8947368  2.3157895  2.7368421  3.1578947
[19]  3.5789474  4.0000000

[[2]]
      [,1]  [,2]  [,3]
[1,] FALSE  TRUE  TRUE
[2,]  TRUE FALSE FALSE
[3,]  TRUE  TRUE FALSE

[[3]]
[1] "don"     "quixote"

[[4]]
[1] LOW  MED  LOW  MED  MED  HIGH
Levels: HIGH LOW MED


#subsetting a list
> my_list[[2]][c(2,1), c(2,3)]
      [,1]  [,2]
[1,] FALSE FALSE
[2,]  TRUE  TRUE


#giving labels to the elements in the list
> names(my_list) <- c("sequence", "matrix", "char_vec", "factor_vector")
> my_list
$sequence
 [1] -4.0000000 -3.5789474 -3.1578947 -2.7368421 -2.3157895 -1.8947368 -1.4736842 -1.0526316 -0.6315789
[10] -0.2105263  0.2105263  0.6315789  1.0526316  1.4736842  1.8947368  2.3157895  2.7368421  3.1578947
[19]  3.5789474  4.0000000

$matrix
      [,1]  [,2]  [,3]
[1,] FALSE  TRUE  TRUE
[2,]  TRUE FALSE FALSE
[3,]  TRUE  TRUE FALSE

$char_vec
[1] "don"     "quixote"

$factor_vector
[1] LOW  MED  LOW  MED  MED  HIGH
Levels: HIGH LOW MED

#Changing string "don" to "Don"
> my_list$char_vec <- sub("don", "Don", my_list$char_vec)
> my_list
$sequence
 [1] -4.0000000 -3.5789474 -3.1578947 -2.7368421 -2.3157895 -1.8947368 -1.4736842 -1.0526316 -0.6315789
[10] -0.2105263  0.2105263  0.6315789  1.0526316  1.4736842  1.8947368  2.3157895  2.7368421  3.1578947
[19]  3.5789474  4.0000000

$matrix
      [,1]  [,2]  [,3]
[1,] FALSE  TRUE  TRUE
[2,]  TRUE FALSE FALSE
[3,]  TRUE  TRUE FALSE

$char_vec
[1] "Don"     "quixote"

$factor_vector
[1] LOW  MED  LOW  MED  MED  HIGH
Levels: HIGH LOW MED

#Changing string "quixote" to "Quixote"
> my_list$char_vec <- sub("quixote", "Quixote", my_list$char_vec)
> mmy_list
Error: object 'mmy_list' not found
> my_list
$sequence
 [1] -4.0000000 -3.5789474 -3.1578947 -2.7368421 -2.3157895 -1.8947368 -1.4736842 -1.0526316 -0.6315789
[10] -0.2105263  0.2105263  0.6315789  1.0526316  1.4736842  1.8947368  2.3157895  2.7368421  3.1578947
[19]  3.5789474  4.0000000

$matrix
      [,1]  [,2]  [,3]
[1,] FALSE  TRUE  TRUE
[2,]  TRUE FALSE FALSE
[3,]  TRUE  TRUE FALSE

$char_vec
[1] "Don"     "Quixote"

$factor_vector
[1] LOW  MED  LOW  MED  MED  HIGH
Levels: HIGH LOW MED

#Concatination
> cat("Windmills! ATTACK! -\\", my_list$char_vec[1], my_list$char_vec[2], "-/")
> Windmills! ATTACK! -\ Don Quixote -/

> cat("Windmills! ATTACK! \n-\\", my_list$char_vec[1], my_list$char_vec[2], "-/")
> Windmills! ATTACK! 
-\ Don Quixote -/

> cat("Windmills! ATTACK! \n\t-\\", my_list$char_vec[1], my_list$char_vec[2], "-/")
> Windmills! ATTACK! 
	-\ Don Quixote -/


#creating a dataframe
> dframe <- data.frame(person=c("Stan","Francine","Steve","Roger","Hayley","Klaus"),sex=factor(c("M","F","M","M","F","M"),levels = c("F","M")), funny=factor(c("High","Med","Low","High","Med","Med"),levels = c("Low","Med","High")))
> dframe
    person sex funny
1     Stan   M  High
2 Francine   F   Med
3    Steve   M   Low
4    Roger   M  High
5   Hayley   F   Med
6    Klaus   M   Med

#checking to confirm the assigned levels to columns "sex" and "funny"
> dframe$sex
[1] M F M M F M
Levels: F M
> dframe$funny
[1] High Med  Low  High Med  Med 
Levels: Low Med High


#creating a new variable "age"
> age <- c(41,41,15,1600,21,60)

#using column on dframe and new variable "age"
> dframe <- cbind(dframe, age)
> dframe
    person sex funny  age
1     Stan   M  High   41
2 Francine   F   Med   41
3    Steve   M   Low   15
4    Roger   M  High 1600
5   Hayley   F   Med   21
6    Klaus   M   Med   60
