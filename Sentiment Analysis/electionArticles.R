library(ggplot2)
library(tm)
library(wordcloud)

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
write.csv(DelhiTOI,file = "Delhi.csv")
write.csv(UpTOI,file = "UP.csv")


rm(location,M,TOIsplit,location2)

#sentiment Score function
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use 
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
   
    
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  

  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}


pos <- read.csv("C:\\Users\\Ravi Varma\\Documents\\positivewords.txt",header = F ,stringsAsFactors = F)
neg <- read.csv("C:\\Users\\Ravi Varma\\Documents\\negitiveWords.txt", header = F ,stringsAsFactors = F)
pos <- as.matrix(pos)
neg <- as.matrix(neg)

Delhi <- rbind(DelhiTOI,newDelhiNDTV)
Delhi$article <- as.character(Delhi$article)
DelhiSenti <- score.sentiment(Delhi$article,pos,neg,.progress = 'text')

UP <- rbind(allmix,UpTOI)
UP$article <- as.character(UP$article)
UPsenti <- score.sentiment(UP$article,pos,neg,.progress = 'text')
#frequency and word cloud

frequency.wordcloud <- function(sentences) 
{
  sentences <- paste(sentences)
  Sorce <- VectorSource(sentences)
  sentenceCorpus <- Corpus(Sorce)
  sentenceCorpus <- tm_map(sentenceCorpus,content_transformer(tolower))
  sentenceCorpus <- tm_map(sentenceCorpus,removePunctuation)
  sentenceCorpus <- tm_map(sentenceCorpus,stripWhitespace)
  sentenceCorpus <- tm_map(sentenceCorpus,removeWords,c(stopwords("english"),"also","party","said","will","election","elections","vote","votes","poll"))
  
  DTM <- DocumentTermMatrix(sentenceCorpus)
  DTM <- as.matrix(DTM)
  Word_freq <- colSums(DTM)
  Word_freq <- sort(Word_freq,decreasing = T)
  Word_freq <- data.frame(word = names(Word_freq), freq = Word_freq)
  wordcloud(Word_freq$word[1:80],Word_freq$freq[1:80],scale=c(3,0.3),max.words = 100,random.order = F,rot.per = .6,colors = palette())

  return(Word_freq)
}



fd <- frequency.wordcloud(Delhi$article)
fup <- frequency.wordcloud(UP$article)





















