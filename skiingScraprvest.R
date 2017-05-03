library(rvest)
#start rvest


url <- "https://data.fis-ski.com/dynamic/results.html?sector=CC&raceid=22395"
#specify url from which we have to collect the data

download.file(url,destfile = "D://dc++//workspace 2//skiing.HTML")
#since we are using in a proxy server we have to download the webpage as HTML
rurl <- "D://dc++//workspace 2//skiing.HTML"

htmlData <- read_html(rurl)
#read the HTML data from the HTML file 

#html_nodes(htmlData,xpath = '//*[@id="main"]/div[2]/div/div[2]/table')


skiing <- html_table(html_nodes(htmlData,'.footable'),header=TRUE,fill = T)
#from nodes detect css class of table of table using inspection and use '.firstword' of table
#specify header value, fill value etc

skiing



