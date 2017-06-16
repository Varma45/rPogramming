library(ggplot2)
library(tm)
library(wordcloud)
library(stringr)
library(plyr)
library(sentimentr)
library(sentiment)
library(SentimentAnalysis)

#cleaning Articles
Articles <- read.csv("election_articles(ndtv).csv",header = F,fill = T)
Articles <- as.data.frame(Articles)
Articles$V1 <- as.character(Articles$V1)
Articles$V2 <- as.character(Articles$V2)
Articles$V3 <- as.character(Articles$V3)

colnames(Articles) <- Articles[2,]
Articles <- Articles[-1:-2,]

Articles <- Articles[,-2]
M <- strsplit(Articles[,2],"Â")
location <- matrix()
for(i in 1:length(M)){
  location[i] <- M[[i]][1]
  Articles$articles[i] <- M[[i]][2] 
}

Articles <- cbind(Articles,location)
Articles$location <- tolower(Articles$location)
newDelhiNDTV <- subset(Articles, location == "new delhi:") 
allmix <- subset(Articles, location!= "new delhi:")
colnames(newDelhiNDTV) <- c("Headline","article","location")
colnames(allmix) <- c("Headline","article","location")
write.csv(newDelhiNDTV,file = "newDelhiNDTV.csv")
write.csv(allmix,file = "allmix.csv")
# cleaning TOI news
TOI <- read.csv("TOI.csv",header = F,fill = T)
TOI$V1 <- as.character(TOI$V1)
TOI$V2 <- as.character(TOI$V2)
TOI$V3 <- as.character(TOI$V3)
colnames(TOI) <- TOI[1,]
TOI <- TOI[-1,]


location2 <- gsub("http://timesofindia.indiatimes.com/elections/","",TOI[,2])
location2 <- gsub("assembly-elections/","",location2)
location2 <- strsplit(location2,"/")

Loc <- matrix()

for(i in 1:length(location2)){
  Loc[i] <- location2[[i]][1]
  
}


TOI <- cbind(TOI,Loc)

TOIsplit <- split(TOI,f = TOI$Loc)

DelhiTOI <- TOIsplit$`delhi-mcd`
UpTOI <- TOIsplit$`uttar-pradesh`
DelhiTOI <- DelhiTOI[,-2]
UpTOI <- UpTOI[,-2]
colnames(DelhiTOI) <- c("Headline","article","location")
colnames(UpTOI) <- c("Headline","article","location")
write.csv(DelhiTOI,file = "DelhiTOI.csv")
write.csv(UpTOI,file = "UPTOI.csv")


Delhi <- rbind(DelhiTOI,newDelhiNDTV)




which.article <- function(articles,bjp.words,sp.words,cong.words,bsp.words,.progress='none'){
  
  require(plyr)
  require(stringr)
  parties <- list()
  parties <- laply(articles,function(article,bjp.words,sp.words,cong.words,bsp.words){
    
    dummy <- article
    dummy <- gsub("[[:punct:]]","",dummy)
    dummy <- gsub("[[:cntrl:]]","",dummy)
    dummy <- gsub("\\d+","",dummy)
    dummy <- tolower(dummy)
    
    word.list <- strsplit(dummy," ")
    word.list <- unlist(word.list)
    
    bjp.matches <- match(word.list, bjp.words)
    bsp.matches <- match(word.list, bsp.words)
    sp.matches <- match(word.list, sp.words)
    cong.matches <- match(word.list, cong.words)
    
    bjp.score <- sum(!is.na(bjp.matches))
    bsp.score <- sum(!is.na(bsp.matches))
    sp.score <- sum(!is.na(sp.matches))
    cong.score <- sum(!is.na(cong.matches))
    
    if((bjp.score>0)&(bsp.score==0)&(sp.score==0)&(cong.score==0)){
      party <- paste("bjp",article,sep = "_*_")
    }else if ((bjp.score==0)&(bsp.score>0)&(sp.score==0)&(cong.score==0)){
      party <- paste("bsp",article,sep = "_*_")
      
    }else if ((bjp.score==0)&(bsp.score==0)&(sp.score>0)&(cong.score==0)){
      party <- paste("sp",article,sep = "_*_")
    }else if ((bjp.score==0)&(bsp.score==0)&(sp.score==0)&(cong.score>0)){
      party <- paste("cong",article,sep = "_*_")
    }else if ((bjp.score==0)&(bsp.score==0)&(sp.score==0)&(cong.score==0)){
      party <- paste("none",article,sep = "_*_")
    }else {
      party <- paste("comp",article,sep = "_*_")
    }
    
    return(party)
    
  },bjp.words,sp.words,cong.words,bsp.words)
  
  parties.df <- data.frame(parties,articles,stringsAsFactors = F)
  return(parties.df)
  
  
}

bjpwords <- data.matrix(c("bjp","modi","narendra","namo","yogi","adityanath","amit","shah"))
spwords <- data.matrix(c("sp","akhilesh","yadav","mulayam","samajwadi"))
congwords <- data.matrix(c("congress","cong","inc","rahul","gandhi"))
bspwords <- data.matrix(c("bsp","bahujan","samaj","mayawati"))

#classificarion for delhi
DELHIbelong <- which.article(Delhi$article,bjp.words = bjpwords,sp.words = spwords,cong.words = congwords,bsp.words = bspwords,.progress = 'text')


party <- strsplit(DELHIbelong$parties,"_*_")
for(i in 1:length(DELHIbelong$parties)){
  DELHIbelong$parties[i] <- party[[i]][1]
}

DELHIbelong <- split(DELHIbelong,f=DELHIbelong$parties)

delBJP <- DELHIbelong$bjp
delBSP <- DELHIbelong$bsp
delSP <- DELHIbelong$sp
delCONG <- DELHIbelong$cong
delNONE <- DELHIbelong$none
delCOMPARISION <- DELHIbelong$comp



#classsification for UP

UP <- rbind(UpTOI,allmix)

UPbelong <- which.article(UP$article,bjp.words = bjpwords,sp.words = spwords,cong.words = congwords,bsp.words = bspwords,.progress = 'text')


party <- strsplit(UPbelong$parties,"_*_")
for(i in 1:length(UPbelong$parties)){
  UPbelong$parties[i] <- party[[i]][1]
}

UPbelong <- split(UPbelong,f=UPbelong$parties)

upBJP <- UPbelong$bjp
upBSP <- UPbelong$bsp
upSP <- UPbelong$sp
upCONG <- UPbelong$cong
upNONE <- UPbelong$none
upCOMPARISION <- UPbelong$comp

rm(Articles,TOI,allmix,DelhiTOI,newDelhiNDTV,UpTOI,M,location,location2,Loc,i)




