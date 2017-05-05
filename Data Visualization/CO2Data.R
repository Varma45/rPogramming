library(ggplot2)

#Scatter plot

qplot(conc,uptake,data = CO2,geom = "point",color=Treatment,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),color=Treatment,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),method='lm',color=Treatment,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),color=Treatment,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("line"),color=Treatment,shape=Treatment,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(uptake,data = CO2,geom = "density",colour=Treatment)
qplot(uptake,data = CO2,geom = "density",colour=Plant)
qplot(conc,uptake,data = CO2,geom = "point",color=Plant,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),color=Plant,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),method='lm',color=Plant,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("point","smooth"),color=Plant,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")
qplot(conc,uptake,data = CO2,geom = c("line"),color=Plant,shape=Plant,xlab = "Concentration of Co2",main="Co2 uptakein Green Plants")

CatData <- table(CO2$Treatment,CO2$Plant,CO2$Type)
mosaicplot(CatData,color =CO2$Plant)
   
