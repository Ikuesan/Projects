
#creating a sequence from 5 to -11 with a decreasing step 0.3
sequence <- seq(from=5, to=-11, by=-0.3)
> sequence
 [1]   5.0   4.7   4.4   4.1   3.8   3.5   3.2   2.9   2.6   2.3   2.0   1.7   1.4
[14]   1.1   0.8   0.5   0.2  -0.1  -0.4  -0.7  -1.0  -1.3  -1.6  -1.9  -2.2  -2.5
[27]  -2.8  -3.1  -3.4  -3.7  -4.0  -4.3  -4.6  -4.9  -5.2  -5.5  -5.8  -6.1  -6.4
[40]  -6.7  -7.0  -7.3  -7.6  -7.9  -8.2  -8.5  -8.8  -9.1  -9.4  -9.7 -10.0 -10.3
[53] -10.6 -10.9


#sorting a sequence
sequence_sorted <- sort(sequence, decreasing = FALSE)
sequence_sorted
 [1] -10.9 -10.6 -10.3 -10.0  -9.7  -9.4  -9.1  -8.8  -8.5  -8.2  -7.9  -7.6  -7.3
[14]  -7.0  -6.7  -6.4  -6.1  -5.8  -5.5  -5.2  -4.9  -4.6  -4.3  -4.0  -3.7  -3.4
[27]  -3.1  -2.8  -2.5  -2.2  -1.9  -1.6  -1.3  -1.0  -0.7  -0.4  -0.1   0.2   0.5
[40]   0.8   1.1   1.4   1.7   2.0   2.3   2.6   2.9   3.2   3.5   3.8   4.1   4.4
[53]   4.7   5.0


#creating a vector with repition
vec <- rep(x=c(-1,3,-5,7,-9),times=2, each=10)
sort(vec, decreasing = TRUE)
  [1]  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  3  3  3  3  3  3
 [27]  3  3  3  3  3  3  3  3  3  3  3  3  3  3 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
 [53] -1 -1 -1 -1 -1 -1 -1 -1 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5
 [79] -5 -5 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9 -9


my_vect <- c(seq(from=6, to=12), rep(x=5.3, times=3), -3, seq(from=102, to=length(x=vec), length.out = 9))
 my_vect
 [1]   6.00   7.00   8.00   9.00  10.00  11.00  12.00   5.30   5.30   5.30  -3.00
[12] 102.00 101.75 101.50 101.25 101.00 100.75 100.50 100.25 100.00


 length(x=my_vect)
[1] 20


vect <- c(seq(from=3, to=6, length.out = 5), rep(c(2,-5.1,-33), times=2), 7, ((7/42)+2))
> vect
 [1]   3.000000   3.750000   4.500000   5.250000   6.000000   2.000000  -5.100000
 [8] -33.000000   2.000000  -5.100000 -33.000000   7.000000   2.166667


#subsetting a vector
extract_vect1 <- vect[1]
> extract_vect1
[1] 3
> extract_vect2 <- vect[13]
> extract_vect2
[1] 2.166667


> extract_vec3 <-  vect[2:12]
> extract_vec3
[1]   3.75   4.50   5.25   6.00   2.00  -5.10 -33.00   2.00  -5.10 -33.00   7.00


> reconstruct_vect <- c(extract_vect1, extract_vec3, extract_vect2)
> reconstruct_vect
 [1]   3.000000   3.750000   4.500000   5.250000   6.000000   2.000000  -5.100000
 [8] -33.000000   2.000000  -5.100000 -33.000000   7.000000   2.166667


> vect <- sort(x=vect, decreasing = FALSE)
> vect
 [1] -33.000000 -33.000000  -5.100000  -5.100000   2.000000   2.000000   2.166667   3.000000   3.750000
[10]   4.500000   5.250000   6.000000   7.000000


> vect[13:1]
 [1]   7.000000   6.000000   5.250000   4.500000   3.750000   3.000000   2.166667   2.000000   2.000000
[10]  -5.100000  -5.100000 -33.000000 -33.000000
> sort(x=vect, decreasing=TRUE)
 [1]   7.000000   6.000000   5.250000   4.500000   3.750000   3.000000   2.166667   2.000000   2.000000
[10]  -5.100000  -5.100000 -33.000000 -33.000000


vector <- c(rep(extract_vec3[3], times=3), rep(extract_vec3[6], times=4), rep(extract_vec3[11]))
> vector
[1]  5.25  5.25  5.25 -5.10 -5.10 -5.10 -5.10  7.00


 new_vect <- vect
> new_vect[1] <- 99
> new_vect[5:7] <- c(98, 97, 96)
> new_vect[13] <- 95
> new_vect
 [1]  99.00 -33.00  -5.10  -5.10  98.00  97.00  96.00   3.00   3.75   4.50   5.25   6.00  95.00


#Farenheit to Celsius conversion  
#45 degrees Farenheit to degree Celsius
 Celsius <- ((5/9)*(45-32))
> Celsius
[1] 7.222222
#77 degrees Farenheit to degree Celsius 
 Celsius <- ((5/9)*(77-32))
> Celsius
[1] 25
#20 degrees Farenheit to degree Celsius
 Celsius <- ((5/9)*(20-32))
> Celsius
[1] -6.666667
#19 degrees Farenheit to degree Celsius
Celsius <- ((5/9)*(19-32))
> Celsius
[1] -7.222222
#101 degrees Farenheit to degree Celsius
Celsius <- ((5/9)*(101-32))
> Celsius
[1] 38.33333
#120 degrees Farenheit to degree Celsius
 Celsius <- ((5/9)*(120-32))
> Celsius
[1] 48.88889
#212 degrees Farenheit to degree Celsius
Celsius <- ((5/9)*(212-32))
> Celsius
[1] 100


> foo <- c(2,4,6)
> vector_1 <- c(rep(foo),(2*foo))
> vector_1
[1]  2  4  6  4  8 12


> vector_1[2]<- -0.1
> vector_1
[1]  2.0 -0.1  6.0  4.0  8.0 12.0
> vector_1[3]<- -100
> vector_1
[1]    2.0   -0.1 -100.0    4.0    8.0   12.0
> vector_1[4]<- -0.1
> vector_1[5]<- -100
> vector_1
[1]    2.0   -0.1 -100.0   -0.1 -100.0   12.0