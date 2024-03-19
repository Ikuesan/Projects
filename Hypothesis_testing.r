#hypothesis testing (two-tail test)
> H0: mean weight = 3.5
> HA: mean weight not equal to 3.5 
> #Test statistics
> cats_avg_weight <- 3.5
> sample_size <- 73
> sample_mean <- 3.97
> sample_sd <- 2.21
> alpha = 0.05
> sample_se <- sample_sd/sqrt(sample_size)
> T = (sample_mean-cats_avg_weight)/sample_se
> T
[1] 1.817051
> pt(T,df=sample_size-1)
[1] 0.9633146
> sample_mean+c(-1,1)*qt(0.975,sample_size-1)*sample_se
[1] 3.454369 4.485631
> #Conclusion
> #since p value is greater than alpha, we fail to reject the null hypothesis
> #Another way we can draw our conclusion is using the lower and upper bounds (3.454369 4.485631). Since the true mean lies within the bounds, we fail to reject the null hypothesis
 
> #hypothesis testing 2
> t.test(x=quakes_mag_data_set,mu=4.3,alternative="greater")

	One Sample t-test

data:  quakes_mag_data_set
t = 25.155, df = 999, p-value < 2.2e-16
alternative hypothesis: true mean is greater than 4.3
95 percent confidence interval:
 4.59943     Inf
sample estimates:
mean of x 
   4.6204 

#since the p value is less than alpha (0.01), we reject the null hypothesis

H0: Mean difference = 0
HA: Mean difference > 0

#subsetting the dataframe 
pre_weight <- anorexia[["Prewt"]]
> pre_weight
 [1] 80.7 89.4 91.8 74.0 78.1 88.3 87.3 75.1 80.6 78.4 77.6 88.7 81.3 78.1 70.5 77.3
[17] 85.2 86.0 84.1 79.7 85.5 84.4 79.6 77.5 72.3 89.0 80.5 84.9 81.5 82.6 79.9 88.7
[33] 94.9 76.3 81.0 80.5 85.0 89.2 81.3 76.5 70.0 80.4 83.3 83.0 87.7 84.2 86.4 76.5
[49] 80.2 87.8 83.3 79.7 84.5 80.8 87.4 83.8 83.3 86.0 82.5 86.7 79.6 76.9 94.2 73.4
[65] 80.5 81.6 82.1 77.6 83.5 89.9 86.0 87.3
> post_weight <- anorexia[["Postwt"]]
> post_weight
 [1]  80.2  80.1  86.4  86.3  76.1  78.1  75.1  86.7  73.5  84.6  77.4  79.5  89.6
[14]  81.4  81.8  77.3  84.2  75.4  79.5  73.0  88.3  84.7  81.4  81.2  88.2  78.8
[27]  82.2  85.6  81.4  81.9  76.4 103.6  98.4  93.4  73.4  82.1  96.7  95.3  82.4
[40]  72.5  90.9  71.3  85.4  81.6  89.1  83.9  82.7  75.7  82.6 100.4  85.2  83.6
[53]  84.6  96.2  86.7  95.2  94.3  91.5  91.9 100.3  76.7  76.8 101.6  94.9  75.2
[66]  77.8  95.5  90.7  92.5  93.8  91.7  98.0

#performing a Paired sample t-test
> t.test(x=pre_weight,y=post_weight,alternative = "greater",conf.level = 0.95,paired=TRUE)

	Paired t-test

data:  pre_weight and post_weight
t = -2.9376, df = 71, p-value = 0.9978
alternative hypothesis: true mean difference is greater than 0
95 percent confidence interval:
 -4.331953       Inf
sample estimates:
mean difference 
      -2.763889 

> #conclusion 
> #Since the p value (0.9978) is greater than alpha (0.05), we fail to reject or do not reject the null hypothesis

#hypothesis test for first treatment group "Cont"
#subsetting the anorexia dataframe for "Cont" group
> Cont_group <- subset(anorexia,Treat=="Cont")
> Cont_group
   Treat Prewt Postwt
1   Cont  80.7   80.2
2   Cont  89.4   80.1
3   Cont  91.8   86.4
4   Cont  74.0   86.3
5   Cont  78.1   76.1
6   Cont  88.3   78.1
7   Cont  87.3   75.1
8   Cont  75.1   86.7
9   Cont  80.6   73.5
10  Cont  78.4   84.6
11  Cont  77.6   77.4
12  Cont  88.7   79.5
13  Cont  81.3   89.6
14  Cont  78.1   81.4
15  Cont  70.5   81.8
16  Cont  77.3   77.3
17  Cont  85.2   84.2
18  Cont  86.0   75.4
19  Cont  84.1   79.5
20  Cont  79.7   73.0
21  Cont  85.5   88.3
22  Cont  84.4   84.7
23  Cont  79.6   81.4
24  Cont  77.5   81.2
25  Cont  72.3   88.2
26  Cont  89.0   78.8
> #subsetting the "Cont" group for pre weight and post weight
> pre_wt_Cont <- Cont_group[["Prewt"]]
> post_wt_Cont <- Cont_group[["Postwt"]]
> pre_wt_Cont
 [1] 80.7 89.4 91.8 74.0 78.1 88.3 87.3 75.1 80.6 78.4 77.6 88.7 81.3 78.1 70.5 77.3
[17] 85.2 86.0 84.1 79.7 85.5 84.4 79.6 77.5 72.3 89.0
> post_wt_Cont
 [1] 80.2 80.1 86.4 86.3 76.1 78.1 75.1 86.7 73.5 84.6 77.4 79.5 89.6 81.4 81.8 77.3
[17] 84.2 75.4 79.5 73.0 88.3 84.7 81.4 81.2 88.2 78.8

#performing t-test
> t.test(x=pre_wt_Cont,y=post_wt_Cont,alternative="greater",conf.level = 0.95,paired=TRUE)

	Paired t-test

data:  pre_wt_Cont and post_wt_Cont
t = 0.28723, df = 25, p-value = 0.3882
alternative hypothesis: true mean difference is greater than 0
95 percent confidence interval:
 -2.226168       Inf
sample estimates:
mean difference 
           0.45 
#Conclusion 
# Since p value (0.3882) is greater than alpha (0.05), we fail to reject the null hypothesis

#hypothesis test for second treatment group "CBT"
#subsetting 
> CBT_group <- subset(anorexia,Treat=="CBT")
> CBT_group
   Treat Prewt Postwt
27   CBT  80.5   82.2
28   CBT  84.9   85.6
29   CBT  81.5   81.4
30   CBT  82.6   81.9
31   CBT  79.9   76.4
32   CBT  88.7  103.6
33   CBT  94.9   98.4
34   CBT  76.3   93.4
35   CBT  81.0   73.4
36   CBT  80.5   82.1
37   CBT  85.0   96.7
38   CBT  89.2   95.3
39   CBT  81.3   82.4
40   CBT  76.5   72.5
41   CBT  70.0   90.9
42   CBT  80.4   71.3
43   CBT  83.3   85.4
44   CBT  83.0   81.6
45   CBT  87.7   89.1
46   CBT  84.2   83.9
47   CBT  86.4   82.7
48   CBT  76.5   75.7
49   CBT  80.2   82.6
50   CBT  87.8  100.4
51   CBT  83.3   85.2
52   CBT  79.7   83.6
53   CBT  84.5   84.6
54   CBT  80.8   96.2
55   CBT  87.4   86.7

> pre_wt_CBT <- CBT_group[["Prewt"]]
> pre_wt_CBT
 [1] 80.5 84.9 81.5 82.6 79.9 88.7 94.9 76.3 81.0 80.5 85.0 89.2 81.3 76.5 70.0 80.4
[17] 83.3 83.0 87.7 84.2 86.4 76.5 80.2 87.8 83.3 79.7 84.5 80.8 87.4

> post_wt_CBT <- CBT_group[["Postwt"]]
> post_wt_CBT
 [1]  82.2  85.6  81.4  81.9  76.4 103.6  98.4  93.4  73.4  82.1  96.7  95.3  82.4
[14]  72.5  90.9  71.3  85.4  81.6  89.1  83.9  82.7  75.7  82.6 100.4  85.2  83.6
[27]  84.6  96.2  86.7

#performing t-test for second treatment group
> t.test(x=pre_wt_CBT,y=post_wt_CBT,alternative="greater",conf.level = 0.95,paired=TRUE)

	Paired t-test

data:  pre_wt_CBT and post_wt_CBT
t = -2.2156, df = 28, p-value = 0.9825
alternative hypothesis: true mean difference is greater than 0
95 percent confidence interval:
 -5.315595       Inf
sample estimates:
mean difference 
      -3.006897 
#Conclusion
#Since p value (0.9825) is greater than alpha (0.05), we fail to reject the null hypothesis H0

#hypothesis test for third treatment group "FT"
#subsetting
> FT_group <- subset(anorexia,Treat=="FT")
> FT_group
   Treat Prewt Postwt
56    FT  83.8   95.2
57    FT  83.3   94.3
58    FT  86.0   91.5
59    FT  82.5   91.9
60    FT  86.7  100.3
61    FT  79.6   76.7
62    FT  76.9   76.8
63    FT  94.2  101.6
64    FT  73.4   94.9
65    FT  80.5   75.2
66    FT  81.6   77.8
67    FT  82.1   95.5
68    FT  77.6   90.7
69    FT  83.5   92.5
70    FT  89.9   93.8
71    FT  86.0   91.7
72    FT  87.3   98.0

> pre_wt_FT <- FT_group[["Prewt"]]
> post_wt_FT <- FT_group[["Postwt"]]
> pre_wt_FT
 [1] 83.8 83.3 86.0 82.5 86.7 79.6 76.9 94.2 73.4 80.5 81.6 82.1 77.6 83.5 89.9 86.0
[17] 87.3
> post_wt_FT
 [1]  95.2  94.3  91.5  91.9 100.3  76.7  76.8 101.6  94.9  75.2  77.8  95.5  90.7
[14]  92.5  93.8  91.7  98.0

#performing t-test for the third treatment group
> t.test(x=pre_wt_FT,y=post_wt_FT,alternative="greater",conf.level = 0.95,paired=TRUE)

	Paired t-test

data:  pre_wt_FT and post_wt_FT
t = -4.1849, df = 16, p-value = 0.9996
alternative hypothesis: true mean difference is greater than 0
95 percent confidence interval:
 -10.29544       Inf
sample estimates:
mean difference 
      -7.264706 
#Since p value (0.9996) is greater than alpha (0.05), we fail to reject the null hypothesis H0

#hypothesis testing
H0: mean yield of plants from control group - mean yield of plants given treatment 1 = 0
HA: mean yield of plants from control group - mean yield of plants given treatment 1 < 0
#checking for equal variance
 #loading in the dataset
 data(PlantGrowth)
> PlantGrowth
   weight group
1    4.17  ctrl
2    5.58  ctrl
3    5.18  ctrl
4    6.11  ctrl
5    4.50  ctrl
6    4.61  ctrl
7    5.17  ctrl
8    4.53  ctrl
9    5.33  ctrl
10   5.14  ctrl
11   4.81  trt1
12   4.17  trt1
13   4.41  trt1
14   3.59  trt1
15   5.87  trt1
16   3.83  trt1
17   6.03  trt1
18   4.89  trt1
19   4.32  trt1
20   4.69  trt1
21   6.31  trt2
22   5.12  trt2
23   5.54  trt2
24   5.50  trt2
25   5.37  trt2
26   5.29  trt2
27   4.92  trt2
28   6.15  trt2
29   5.80  trt2
30   5.26  trt2
> Plant_ctrl_group <- subset(PlantGrowth,group=="ctrl")
> Plant_ctrl_group
   weight group
1    4.17  ctrl
2    5.58  ctrl
3    5.18  ctrl
4    6.11  ctrl
5    4.50  ctrl
6    4.61  ctrl
7    5.17  ctrl
8    4.53  ctrl
9    5.33  ctrl
10   5.14  ctrl
> Plant_trt1_group <- subset(PlantGrowth,group=="trt1")
> Plant_trt1_group
   weight group
11   4.81  trt1
12   4.17  trt1
13   4.41  trt1
14   3.59  trt1
15   5.87  trt1
16   3.83  trt1
17   6.03  trt1
18   4.89  trt1
19   4.32  trt1
20   4.69  trt1
> control_group<-Plant_ctrl_group[["weight"]]
> control_group
 [1] 4.17 5.58 5.18 6.11 4.50 4.61 5.17 4.53 5.33 5.14
> trt1_group <- Plant_trt1_group[["weight"]]
> trt1_group
 [1] 4.81 4.17 4.41 3.59 5.87 3.83 6.03 4.89 4.32 4.69
> var(control_group)
[1] 0.3399956
> var(trt1_group)
[1] 0.6299211
#The variance of the two populations Control group and Treatment group 1 are not equal and hence we cannot perform a pooled estimate two sample test but instead a Welch's test is more appropriate
> t.test(x=control_group,y=trt1_group,alternative="less",conf.level = 0.95)

	Welch Two Sample t-test

data:  control_group and trt1_group
t = 1.1913, df = 16.524, p-value = 0.8748
alternative hypothesis: true difference in means is less than 0
95 percent confidence interval:
      -Inf 0.9136743
sample estimates:
mean of x mean of y 
    5.032     4.661 
#conclusion 
#since the p value (0.8748) is greater than alpha (0.05), we fail to reject the null hypothesis

#hypothesis testing of one proportion 
H0: pie = 0.9
HA: pie < 0.9

#To check whether it would be valid to carry out the test using normal distribution
> p_hat <- 71/89
> p_hat
[1] 0.7977528
> 89*p_hat
[1] 71
> 89*(1-p_hat)
[1] 18
#the above values are greater than 5 and so it is valid to carry out the test using normal distribution
> p_se <- sqrt(p_hat*(1-p_hat)/89)
> p_se
[1] 0.04257753

> successes <- 71
> total_trials <- 89
> exp_prop <- 0.9
> prop.test(successes,total_trials,p=exp_prop,alternative="less",correct=FALSE)
       
       1-sample proportions test without continuity correction

data:  successes out of total_trials, null probability exp_prop
X-squared = 10.338, df = 1, p-value = 0.0006515
alternative hypothesis: true p is less than 0.9
95 percent confidence interval:
 0.0000000 0.8585183
sample estimates:
        p 
0.7977528 
#conclusion
#since the p value is less than alpha (0.1), we reject the null hypothesis

> p_hat+c(-1,1)*qnorm(0.95)*p_se
[1] 0.7277190 0.8677866


#hypothesis testing for two proportions
> H0: pie2 - pie1 = 0
> H1: pie2 - pie1 
> x1 <- 97
> n1 <- 445
> x2 <- 90
> n2 <- 419
> prop.test(x=c(x2,x1),n=c(n2,n1),alternative="greater",correct=FALSE)

	2-sample test for equality of proportions without continuity correction

data:  c(x2, x1) out of c(n2, n1)
X-squared = 0.012871, df = 1, p-value = 0.5452
alternative hypothesis: greater
95 percent confidence interval:
 -0.04928303  1.00000000
sample estimates:
   prop 1    prop 2 
0.2147971 0.2179775
#since the p value (0.5452) is greater than alpha (0.05), we fail to reject the null hypothesis
#confidence interval 
> (p_hat2-p_hat1)+ c(-1,1)*qnorm(0.95)*sqrt((p_hat1*(1-p_hat1)/n1)+(p_hat2*(1-p_hat2)/n2))
[1] -0.04928303  0.04292224

