library(rvest)
library(ggplot2)
library(tidyr)
library(scatterplot3d)
library(corrgram)

NBA <- read.csv("http://datasets.flowingdata.com/ppg2008.csv",sep=",")



NBAlong <- 
  NBA %>% gather(key = Metrics, value = Performance, G:PF)
## Joining all the metrics into a single var]

ggplot(data = NBAlong,aes(x=Metrics,y=Name))+geom_tile(aes(fill=Performance))+ggtitle("NBA PLAYERS AND THEIR PERFORMANCE MEASURES")


scatterplot3d(NBA$G,NBA$MIN,NBA$PTS,axis = T,grid = T,box=T,zlab = "points",ylab = "Time Played",xlab = "G")

corrgram(NBA)

