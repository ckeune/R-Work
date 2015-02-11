
library(googleVis)


datelist <- data.frame(as.Date('2014-10-01'))
names(datelist) <- 'Date'

for(i in 1:100){
  newdate <- data.frame(as.Date(datelist[1,] + i))
  names(newdate) <- 'Date'
  datelist<- rbind(datelist,newdate)
}


emeamotion <- read.delim("~/emeamotion.txt")

emeamotion$date <- as.Date(emeamotion$date )
Motion=gvisMotionChart(emeamotion, 
                       idvar="advertiser",
                       yvar="freq",
                       xvar="imps",
                       timevar="date")


plot(Motion)
merger <- merge(x = emeamotion, y = emeamotion$date, by = NULL)

popall <- sqldf ("select advertiser, date, imps, users, totalaud ,precentaud
                 from emeamotion t1
                 full join emeamotion t2 on t1.date = t2.date
                 ")




