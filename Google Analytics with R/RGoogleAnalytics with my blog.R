library(RGoogleAnalytics)

client.id <- "1051322968990-9ev0lcuntfmomn58k5rr72to5itf825j.apps.googleusercontent.com"
client.secret <- "_-nH4xSR2xcnUZgsNgBVJ-br"

token <- Auth(client.id,client.secret)

ValidateToken(token)

query.list <- Init(
  start.date = "2017-05-06",
  end.date = "2017-05-07",
  dimensions = c("ga:date","ga:source", "ga:medium","ga:browser","ga:sessionDurationBucket","ga:sessionCount"),
  metrics = c("ga:sessions","ga:users", "ga:bounces","ga:organicSearches","ga:sessionDuration","ga:pageviews","ga:newUsers"),
  max.results = 10000,
  #sort = "ga:Sessions",
  table.id = "ga:149790197"
  
)


ga.query <- QueryBuilder(query.list)
#takes a query request


ga.data <- GetReportData(ga.query,token)
#gets data from query request and a particular token

options(scipen = 999)
