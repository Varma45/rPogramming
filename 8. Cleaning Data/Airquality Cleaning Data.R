library(ggplot2)


data("airquality")
Aq <- airquality

Miss <- is.na(airquality)
nMiss <- sum(Miss)

count <- 0
for(i in 1:nrow(Aq)) {
  for(j in 1:ncol(Aq)) {
    if(is.na(Aq[i,j])==TRUE){
      count <- count + 1
      break
    }
  }
}

print(count)
#count = 42 that is we have to delete 42 rows of data atleast to avoid missing values :/ 
#lets see where are the more no of missing values

apply(Aq,2,function(colVar) sum(is.na(colVar)))
#Ozone has 37 missing values


prcntOfMissing <- (count)/nrow(Aq) *100


if(prcntOfMissing<10){
  Aqcc = Aq[complete.cases(Aq),]
}

summary(Aq$Ozone)
ggplot(Aq,aes(Solar.R,Ozone))+geom_point()+geom_smooth(method = "lm")+facet_grid(.~Month)
ggplot(Aq,aes(Wind,Ozone))+geom_point()+geom_smooth(method = "lm")+facet_grid(.~Month)
ggplot(Aq,aes(Temp,Ozone))+geom_point()+geom_smooth(method = "lm")+facet_grid(.~Month)
ggplot(Aq,aes(Temp,Ozone))+geom_point()+geom_smooth(method = "lm")
#########################  Filling Missing Values ####################


###############Linear Regression for different Months ###########
Month <- list()

for( j in seq(1:5)){
  Month[[j]] <- subset(Aq,Month == j+4,select = c(Ozone,Temp,Month))
  MothOzone.lm <- lm(Ozone~Temp,Month[[j]])
  MonthCoeffs <- coefficients( MothOzone.lm)
  
  predictMonth <- data.frame()
  i = 1
  for(i in seq(1:nrow(Month[[j]]))){
    if(is.na(Month[[j]]$Ozone[i])==T){
      predictMonth[i,1] <- MonthCoeffs[1]+MonthCoeffs[2]*Month[[j]]$Temp[i]
    }else {
      predictMonth[i,1] = Month[[j]]$Ozone[i]
    }
  }
  
  
  
  Month[[j]] <- cbind(Month[[j]],predictMonth)



}

Aqcc <- data.frame()
for(k in seq(1:5)){
  Aqcc <- rbind(Aqcc,Month[[k]])
}

summary(Aqcc$V1)


ggplot(Aq,aes(Temp,Ozone))+geom_boxplot()+facet_grid(.~Month)
ggplot(Aqcc,aes(Temp,V1))+geom_boxplot(aes(group=1))+facet_grid(.~Month)

#######################  Knn Imputaion #########################
library(DMwR)
Predictknn <- knnImputation(Aq,meth = "weighAvg")


regr.eval(Aqcc$V1,Predictknn)

################# MIce #########################################
library(mice)

PredictMice <- complete(mice(Aq,method = "rf"))
regr.eval(Aqcc$V1,PredictMice)



