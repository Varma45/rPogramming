library(googleAnalyticsR)

ga_auth()


ga_dat <- google_analytics_4(viewId = "149790197",
                             date_range = c(Sys.Date()-7,Sys.Date()-1),
                             metrics = c("users","sessions","pageviews","sessionDuration","bounces","organicsearches"),
                             dimensions = c("date","source","medium","browser","sessionDurationBucket"),
                             anti_sample = TRUE)

