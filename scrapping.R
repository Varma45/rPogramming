library(rvest)

url <- "http://www.indiaonlinepages.com/population/state-wise-population-of-india.html"

download.file(url,destfile = "D:\\dc++\\workspace 2\\india.html")

reurl <- "D:\\dc++\\workspace 2\\india.html"

data_read <- read_html(reurl)

data_html <- html_nodes(data_read,'.fest-pg-div')

data <- html_text(data_html)

data <- gsub("\n","",data)
data <- gsub("\r","",data)
data <- gsub("          ","",data)

head(data)






