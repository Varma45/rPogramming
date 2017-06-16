library(R.matlab)
library(ggplot2)
library(HMM)
library(hsmm)
library(mhsmm)
Drilldata <- readMat("dbhole.mat")



for (i in 1:length(Drilldata))
{
  Drilldata[[i]] <- as.data.frame(Drilldata[[i]])
}


x <- data.frame(x)
for(j in 1:21)
{
  x <- rbind(x,Drilldata[[j]])
}
 
 
 init <- c(1, 0, 0, 0)
 p <- matrix(c(0,1,0,0,
               0,0,1,0,
               0,0,0,1,
               1,0,0,0),4,byrow = T)
 
 B  <- list(mu = list(c(1, 2,3), c(2, 3,4)))
 d <- list(shape = c(0.55,0.25,0.20,0.01),scale=c(1,1,1,1),type = "gamma")
 model <- hsmmspec(init, p, parms.emis = B, sojourn = d,
                   dens.emis = dmvnorm.hsmm)
 
 train <- simulate(model,nsim=100,seed=123,rand.emis=rmvnorm.hsmm)
 