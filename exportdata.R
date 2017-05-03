library(RGoogleAnalytics)
#initialize RGoogleAnlaytics Package 

client.id <- "850321439371-kqvfhrscballn1d91s5mbnoe4gg71f50.apps.googleusercontent.com"
client.secret <- "_L6TR-iYwafKWiS8mDeHWzgh"
#these are given by GDev console 1.create a project 2. Enable Analytics Api 3.get credentials for other and get cleint Id and client secret

token <- Auth(client.id,client.secret)
#A token is associated with a particular client id and secret if we authorize the id and secret we will gt token

ValidateToken(token)
#check whther the generated token is valid or not
#if we validate the token we will be prompted to google analytics page for permissions 
#if you are using a proxy server "set_config(use_proxy(url="10.3.100.207",port=8080))"


query.list <- Init(
  start.date = "2017-03-25",
  end.date = "2017-03-30",
  metrics = "ga:transactions,ga:transactionRevenue",
  max.results = 10000,
  sort = "ga:date",
  table.id = "ga:90822334"
)
#list out all the queries required from google analytics website to get them 


ga.query <- QueryBuilder(query.list)

ga.data <- GetReportData(ga.query,token)
options(scipen = 999)




