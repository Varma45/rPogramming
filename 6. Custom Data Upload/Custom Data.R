library(httr)
set_config(use_proxy(url="http://10.3.100.207",port=8080))
#proxy


library(googleAnalyticsR)
ga_auth()
#Authenticate account



#create a file as a data frame or csv and upload it to google analytics account
File.upload <- data.frame(
  browser= c("chrome","mozilla","edge"),
  sessionCount=c("10"," 7" , "5"), 
  language=c("en-in","en-us","sanskrit - :P"), 
  networkDomain=c("IIT Kharagpur","Boston University","Unkown"),
  operatingSystem = c("windows","mac","windows")
)


#Get all the details of the custom data table which should be already created in Google analytics account
#if Custom data table was not already created go ahead and create a table in data import section of google Analytics
#executing the following block of code will give the details of which we require id of the table
customDataSource <- ga_custom_datasource(
  accountId = "98677966",  #Account Id obtained from google analytics
  webPropertyId = "UA-98677966-1"   #Web property Id obtained from google analytics
)



#now upload the file in google analytics through R
ga.upload <- ga_custom_upload_file(accountId = "98677966",
                                webPropertyId = "UA-98677966-1",
                                customDataSourceId = customDataSource$id[2], # select required table id from id menu of the data frame given by ga_custom_datasource function
                                File.upload #specify file name to be uploaded 
                                )




#view status of the update
ga_custom_upload(upload_object = ga.upload)
