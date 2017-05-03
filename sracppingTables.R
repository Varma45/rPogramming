library(rvest)

link <- "http://www.indiaonlinepages.com/population/state-wise-population-of-india.html"

download.file(link,destfile = "D://dc++//workspace 2//state.HTML")
dlink <- "D://dc++//workspace 2//state.HTML"

read_link <- read_html(dlink)

pop_html <- html_nodes(read_link,xpath = "/html/body/center[2]/table/tbody/tr/td[1]/center[2]/table/tbody")
pop_data <- html_table(pop_html)
head(pop_data)
pop_data

