library(rvest)

download.file(url = "https://en.wikipedia.org/wiki/Web_scraping",destfile = "D://dc++//workspace 2//rtext.html")

rlink  <- read_html("D://dc++//workspace 2//rtext.html")
nodes <- html_nodes(rlink,'p')
nodes
html_text(nodes)[1:6]

