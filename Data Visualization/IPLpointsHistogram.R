library(ggplot2)
library(rvest)

download.file(url = "https://en.wikipedia.org/wiki/2017_Indian_Premier_League",destfile = "D://dc++//workspace 2//Data Visualization//ipl.html")
 ipl_nodes <- html_nodes(read_html("D://dc++//workspace 2//Data Visualization//ipl.html"),'.wikitable')
iplTable <- html_table(ipl_nodes[2])
 pointsTable <- iplTable[[1]]
 
 pointsTable$NRR <- as.numeric(pointsTable$NRR)
 names(pointsTable)[1] <- "Team"

qplot(Pld,Pts,data = pointsTable,geom = 'point')
qplot(Pld,Pts,data = pointsTable,geom = 'smooth')
qplot(Pld,Pts,data = pointsTable,geom = c('point','smooth'))
qplot(Pld,Pts,data = pointsTable,geom = c('point','smooth'),method = 'lm')
qplot(Pld,Pts,data = pointsTable,color = Team,geom = c('point','smooth'),method='lm')
qplot(Pld,Pts,data = pointsTable,geom = 'line',type='o')
qplot(Pld,Pts,data = pointsTable,geom = 'boxplot')
qplot(Pts,data = pointsTable,geom = 'bar',fill=Team)
qplot(Pts,data = pointsTable,geom = 'density')


 
 