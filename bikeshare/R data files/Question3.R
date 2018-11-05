#########################################################################
# question 3: What is the average distance traveled?
# Data process: remove location with 0s, remove speed > 5m/s (i.e. average bike speed)

# function to compute distance
computeDist <- function(lat1,lat2,long1,long2 ){
  radius <- 6371e3 
  q1 <- lat1*pi/180
  q2 <- lat2*pi/180
  delto <- (lat2-lat1)*pi/180
  yy <- (long2-long1)*pi/180
  a <- sin(delto/2) * sin(delto/2) + cos(q1) * cos(q2) * sin(yy/2) * sin(yy/2);
  c <-  2 * atan2(sqrt(a), sqrt(1-a));
  dist <- radius * c
  return(dist)
}

attach(bikeExcel)

# remove bad data
trip <- subset(bikeExcel, `Starting Station Latitude`!=0)
trip <- subset(trip, `Ending Station Latitude`!=0)
trip <- subset(trip, `Starting Station Longitude` !=0)
trip <- subset(trip, `Ending Station Longitude` !=0)

# compute distance and add to table trip
lat1 <- trip$`Starting Station Latitude`
lat2 <- trip$`Ending Station Latitude`      
long1 <- trip$`Starting Station Longitude`
long2 <- trip$`Ending Station Longitude`

distance <- computeDist(lat1,lat2,long1,long2)
trip <- cbind(trip, distance)

# calculate duration and add to table trip
time1Str <- trip$`Start Time`
time2Str <- trip$`End Time`
time1 <- ISOdatetime(substr(time1Str,1,4),substr(time1Str,6,7),substr(time1Str,9,10),substr(time1Str,12,13),substr(time1Str,15,16),substr(time1Str,18,19),tz="")
time2 <- ISOdatetime(substr(time2Str,1,4),substr(time2Str,6,7),substr(time2Str,9,10),substr(time2Str,12,13),substr(time2Str,15,16),substr(time2Str,18,19),tz="") 
period <- as.numeric(difftime(time2,time1,tz,units="secs"))
#period <- as.numeric(trip$Duration)
trip <- cbind(trip, period)

# calculate speed and add to table trip
speed <- trip$distance/trip$period
trip <- cbind(trip,speed)
nrow(trip)

# remove bad data if speed > 5m/s
trip <- subset(trip, trip$speed<=5)
nrow(trip)

# select catagory:  "Staff Annual" "Monthly Pass" "Flex Pass" "Walk-up"
type <- "Walk-up"
oneway <- subset(trip, trip$`Trip Route Category`=="One Way")
#oneway <- subset(oneway, oneway$`Passholder Type`==type)

# computer oneway average distance
averageOne <- sum(oneway$distance)/nrow(oneway)
print("oneway trip average: ")  # and other passes
averageOne

# calculate oneway speed, used to estimate roundtrip speed:2.1m/s
rate <-  (oneway$distance/oneway$period)      
speedOneway <- mean(rate)
print("Oneway average speed is ")
speedOneway 

# round trip
round <- subset(trip, trip$`Trip Route Category`=="Round Trip")
#round <- subset(round, round$`Passholder Type`==type)

roundDist <- 2.1 * round$period
averageRound <- sum(roundDist)/nrow(round)
print("average round trip average: ") 
averageRound

averageAll <- (sum(roundDist) + sum(oneway$distance))/(nrow(round)+nrow(oneway))
print("average all trip with roundtrip speed of 2.1 m/s:  ") 
averageAll

detach(bikeExcel)
