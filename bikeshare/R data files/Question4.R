#########################################################################
# question 4: How many riders include bike sharing as a regular part of their commute?
# "Regular Riders":  != walk-up

attach(bikeExcel)

regular <- `Passholder Type`!="Walk-up"
riderregular <- sum(regular == TRUE)
walk <- `Passholder Type`=="Walk-up"
riderwalk <- sum(walk == TRUE)
flex <- `Passholder Type`=="Flex Pass"
riderflex <- sum(flex == TRUE)
month <- `Passholder Type`=="Monthly Pass"
ridermonth <- sum(month == TRUE)
staff <- `Passholder Type`=="Staff Annual"
riderstaff <- sum(staff == TRUE)

# add month to rider data
month <- substr(bikeExcel$`Start Time`, 6,7)

# for regular riders below
rider <- cbind(regular, month)
riderAll <- nrow(rider)

riderSpring <- subset(rider, rider$month == "03" | rider$month == "04" | rider$month == "05")
rider01spr <- nrow(riderSpring)
riderSummer <- subset(rider, rider$month == "06" | rider$month == "07" | rider$month == "08")
rider02sum <- nrow(riderSummer)
riderFall <- subset(rider, rider$month == "09" | rider$month == "10" | rider$month == "11")
rider03fall <- nrow(riderFall)
riderWinter <- subset(rider, rider$month == "12" | rider$month == "01" | rider$month == "02")
rider04winter <- nrow(riderWinter)


detach(bikeExcel)
