#calculating standard error from sd and sample size
> standard_dev <- 11.3
> sample_size <- 6
> standard_error <- standard_dev/sqrt(sample_size)
> standard_error
[1] 4.613206


> #calculating z-scores for 45 and 55
> z_45 <- (45-sample_mean)/standard_error
> z_55 <- (55-sample_mean)/standard_error

> #calculating the probabilities individually
> prob_45 <- pnorm(z_45)
> prob_55 <- pnorm(z_55)

> #calculating the probability between 45 and 55
> prob_between_45_and_55 <- prob_45 - prob-55
Error: object 'prob' not found
> prob_between_45_and_55 <- prob_55 - prob_45
> prob_between_45_and_55
[1] 0.197651

> total_score <- 65
> average_score <- total_score/2
> z_score <- (average_score-sample_mean)/(standard_dev/sqrt(sample_size))
> prob_F_grade <- pnorm(z_score)
> prob_F_grade
[1] 0.03114587


> mean_time <- 14.22
> sd <- 2.9
> n <- 34
> standard_error <- sd/sqrt(n)
> standard_error
[1] 0.4973459
> #calculating the confidence interval
> mean_time +c(-1,1)*qnorm(0.95)*standard_error
[1] 13.40194 15.03806
> #We can say with 90% confidence that the true mean time lies between 13.40194 and 15.03806


> #since we are making use of "s" instead of "sigma x (s.d)", we use the t distribution
> mean_time +c(-1,1)*qt(p=0.95,df=33)*standard_error
[1] 13.37831 15.06169
 > #We can say with 90% confidence that the true mean time lies between 13.37831 and 15.06169


> p_hat <- 37/400
> p_hat
[1] 0.0925
> p.se <- sqrt(p_hat*(1-p_hat)/400)
> p.se
[1] 0.01448652
> p_hat+c(-1,1)*qnorm(0.995)*p.se
[1] 0.05518519 0.12981481
> #we can say with 99% confidence that the true proportion of left-handed only citizens lies between 0.05518519 and 0.12981481


> left_handed <- 37
> ambidextrous <- 11
> total <- left_handed + ambidextrous
> n <- 400
> p_hat <- total/n
> p_hat+c(-1,1)*qnorm(0.995)*std_error
[1] 0.07814773 0.16185227
> #we can say with 99% confidence that the true proportion of citizens who are either left-handed or ambidexterous lies between 0.07814773 and 0.16185227
