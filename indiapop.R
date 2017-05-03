library(rvest)


l <- "http://www.indiaonlinepages.com/population/state-wise-population-of-india.html"

download.file(l,destfile = "D://dc++//workspace 2//state2.HTML")
dl<- "D://dc++//workspace 2//state2.HTML"

read_l <- read_html(dl)

ind <- html_table(html_nodes(read_l,'.fest-dates'),header=F,fill=T)
toplot <- ind[[1]][2:3]
x <- (toplot[-2:-1,][1])
y <- (toplot[-2:-1,][2])
y <- y[-1,][1]
toplot[-2:-1,][1]
class(toplot[-2:-1,][2])
y$X3 <- (gsub(",","",y$X3))
y$X3 <- as.numeric(y$X3)
str(x)
str(y)
state <- data.frame(y,x)
#barplot(height = y,width=1)
y$X3
state <- state[-36,]
barplot(height = state$X3,width = 1)
mean((state$X3))

