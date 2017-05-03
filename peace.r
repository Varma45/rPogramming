library(rvest)

download.file(url = "https://en.wikipedia.org/wiki/List_of_Nobel_Peace_Prize_laureates",destfile = "D://dc++//workspace 2//Peace.html")
peace <- "D://dc++//workspace 2//Peace.html"

markpeace <- read_html(peace)
peaceh <- html_nodes(markpeace,'.wikitable')
peacetab <- html_table(peaceh, header = T,fill = T )

