library(httr)
set_config(use_proxy(url ="http://10.3.100.207",port = 8080 ))

library(readxl)

url <- "http://eci.nic.in/ECI_Main/StatisticalReports/candidatewise/LA%202017.xls"
download.file(url,destfile = "elections.xls",mode = "wb")

elecData <- read_xls("elections.xls",sheet = 2)
colnames(elecData) <- elecData[2,] 
elecData <- elecData[-1:-2,]
colnames(elecData)[14] = c("Votes")

purl <- "http://eci.nic.in/ECI_Main/StatisticalReports/candidatewise/AE2012_8913.xls"
download.file(purl,destfile = "preElec.xls",mode = "wb")
preData1 <- read_xls("preElec.xls")
colnames(preData1)[14] = "Votes"
 # library(qpcR)
#  frame1 <- qpcR:::cbind.na(elecData,preData1)

elecsplit <- split(elecData,f=elecData$ST_NAME)
presplit <- split(preData1,f=preData1$ST_NAME)


Goa <- merge(elecsplit$Goa,presplit$Goa,all=T)
Goa <- Goa[order(Goa$CAND_NAME,Goa$DIST_NAME),]

Manipur <- merge(elecsplit$Manipur,presplit$Manipur,all=T)
Manipur <- Manipur[order(Manipur$CAND_NAME,Manipur$DIST_NAME),]

UP <-merge( elecsplit$`Uttar Pradesh`,presplit$`Uttar Pradesh`,all=T)
UP <- UP[order(UP$CAND_NAME,UP$DIST_NAME),]

UK <- merge(elecsplit$Uttarakhand,presplit$Uttarakhand,all=T)
UK <- UK[order(UK$CAND_NAME,UK$DIST_NAME),]


Punjab <- merge(elecsplit$Punjab,presplit$Punjab,all=T)
Punjab <- Punjab[order(Punjab$CAND_NAME,Punjab$DIST_NAME),]

rm("presplit","elecsplit")








