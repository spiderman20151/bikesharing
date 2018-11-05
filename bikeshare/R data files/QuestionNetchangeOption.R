#########################################################################
# Net Changes of Bikes over the Course of a Day in the Most Popular Station
# Date used: thisday <- 2016/8/18, and 2016/8/17

attach(bikeExcel)

ID <- 3005    # popular ending
# ID = 3069   # popular starting

thisday <- "2016-08-18"
day1 <- subset(bikeExcel, substr(`Start Time`,1,10) == thisday )    

vectorin <- c()
vectorout <- c()
for(i in 1:23) {
  hourOut <- subset(day1, as.numeric(substr(day1$`Start Time`,12,13)) == i )
  hourin <- subset(day1, as.numeric(substr(day1$`End Time`,12,13)) == i)
  numIn <- subset(hourin, hourin$`Ending Station ID`==ID)
  numOut <- subset(hourOut, hourOut$`Starting Station ID`==ID) 
  y <- nrow(numIn)
  x <- nrow(numOut)
  vectorin <- c(vectorin, y)
  vectorout <- c(vectorout,x)
}
 
vectorin
vectorout

detach(bikeExcel)


