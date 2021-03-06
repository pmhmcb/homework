##(1) If we wanted to test for Type I error rates, how would we do that using a simulation? [n=100].
#How often would we expect to find statistically significant findings with an alpha of .05? 

set.seed(2345)
pvs <- numeric(100)
for (i in 1:100){
  y1 <- rnorm(100, 50, 10) 
  y2 <- rnorm(100, 50, 12) 
  treatment <- rep(c("control","treatment"),each = 100)
  res <- t.test(y1, y2)
  pvs[i] <- res$p.value 
}  
mean(pvs <= .05)

##We are likely to find statistically significant results 5% of the time.

##(2) If we wanted to see the power to detect a statistically significant correlation coefficient[n=50]
## how would we do that with a simulation [assume r = .30].

pvs <- numeric(1000)
corv <- numeric(1000)
library(gendata)
set.seed(2512)
for (i in 1:1000){
  d1 <- genmvnorm(cor=.3, k=2, n=50)
  res <- cor.test(d1$X1, d1$X2)
  res
  pvs[i] <- res$p.value
  corv[i] <- res$estimate
}
mean(pvs <= .05)

## a. What percent of the time are p-values statistically significant?
## The p values are statistically significant 58% of the time. 

## b. Draw a basic histogram of the correlation coefficient values.
hist(corv, breaks = 20)

## c. What is the mean of the 1,000 correlation coefficients?
mean(corv)
##The mean of the correlation coefficients is .30.

## d. If you had a correlation of .15 and n = 100, how much power would you have? 
pwr::pwr.r.test(r = .15, n = 100)
## With a r of .15 and n=100, power would equal .32 (moderate effect).

## e. What n would you need to have power of .80 with r = .15?
pwr::pwr.r.test(r = .15, power = .80)
## In order to have a power of .80, you would need roughly 346 participants (n).