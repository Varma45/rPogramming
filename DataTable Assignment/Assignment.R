library(ggplot2)
library(factoextra)
library(plotly)

#Reading Input data ---> DataTable.csv file from a local directoy
DataTable <- read.csv("D://dc++//workspace 2//DataTable.csv",header = T,sep = ",")

#Date is in factor variable and others are in int variables so converting them
DataTable$Date <- as.Date(DataTable$Date, format = "%m/%d/%y")
DataTable$Sessions <- as.numeric(DataTable$Sessions)
DataTable$Page.Views <- as.numeric(DataTable$Page.Views)
DataTable$Avg..Session.Duration <- as.numeric(DataTable$Avg..Session.Duration)

#line plot to check variations of sessions with respect to date 
ggplot(DataTable,aes(x=Date,y=Sessions,group=1))+geom_line()+theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Checking whether gender has any effecct on sessions with respect to date 
ggplot(DataTable,aes(x=Date,y=Sessions))+geom_point(aes(col=Gender))+geom_smooth(aes(col=Gender))+theme(axis.text.x = element_text(angle = 90, hjust = 1))

 # distance <- dist(DataTable[,c(1:12)])
  #Hierarchical <- hclust(distance,method = "average")
#  plot(Hierarchical)

#clusterCut <- cutree(Hierarchical,2)
#table(clusterCut,DataTable$Country)


#how bounce rate is dependent varies for device category with respect to source media
ggplot(data = DataTable,aes(x = DataTable$Device.Category,y=DataTable$Bounce.Rate))+geom_bar(aes(fill=Source.Medium),stat = "identity")

#Shows that organic/google searches has highest bounce rate and direct visit has less bounce rate



#  distance2 <- dist(DataTable[,c[8,12]],method = "euclidean")
#  referal <- hclust(distance2,method = "ward")
#  plot(referal)
#  referalcut <-  cutree(referal,3)
#  rect.hclust(referal,3,border="red")
#  table(referalcut,DataTable$Source.Medium)


ggplot(DataTable,aes(Sessions,Bounce.Rate))+geom_point(aes(col=Source.Medium))
#to differentiate no of clusters by viewing it


#using elbow method to get no of clusters 
#elbow method maynnot always give the correct no of clusters 'Beware!!'

mydata <- scale(DataTable[,c(8,12)])
wss[1] <- (nrow(mydata)-1)*sum(apply(mydata,2,var)) 
#apply(x,1,...)means rows
#apply(x,2,...)means columns
#sum up the variance of each row and mutiply (nrow(mydata)-1)

for (i in 2:15) {
  wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
}
#calculate the SSE of each clustering

plot(x = 1:15, y = wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares",
     main="Assessing the Optimal Number of Clusters with the Elbow Method",pch=20)


#set.seed(50)
#kmeans clustering performed on sessions and bounce rate to have clusters of Sourcemedia
Kcluster <- kmeans(scale(DataTable[,c(8,12)]), 3, nstart = 1)
table(Kcluster$cluster,DataTable$Source.Medium)
#visualizing the clusters
fviz_cluster(Kcluster,data=(DataTable[,c(8,12)]),geom="point")




ggplot(DataTable,aes(Sessions,Bounce.Rate))+geom_point(aes(col=Gender))
#no clustering for Gender
ggplot(DataTable,aes(Sessions,Page.Views))+geom_point(aes(col=Gender))
#no clustering

ggplot(DataTable,aes(Sessions,Page.Views))+geom_point(aes(col=Customer.Type))+geom_smooth(aes(col=Customer.Type))
#no clustering
ggplot(DataTable,aes(Sessions,Bounce.Rate))+geom_point(aes(col=Customer.Type))+geom_smooth(aes(col=Customer.Type))



ggplot(DataTable,aes(Sessions,Bounce.Rate))+geom_point(aes(col=Country))+geom_smooth(aes(col=Country))


#catgorical Age and their interests
#Making integeral age to categorical age
AgeCategory <- cut(DataTable$Age,breaks = c(18,25,32,39,46,53,60,67,74,81),right = F)

newDataTable <- data.frame(DataTable,AgeCategory)
ggplot(data = newDataTable,aes(AgeCategory,Sessions))+geom_bar(stat="identity",aes(fill=Gender))
ggplot(data = newDataTable,aes(AgeCategory,Sessions))+geom_bar(stat="identity",aes(fill=Gender))+facet_grid(.~Gender)
ggplot(data = newDataTable,aes(AgeCategory,Sessions))+geom_bar(stat="identity",aes(fill=Customer.Type))
ggplot(data = newDataTable,aes(AgeCategory,Sessions))+geom_bar(stat="identity",aes(fill=Customer.Type))+facet_grid(.~Customer.Type)

