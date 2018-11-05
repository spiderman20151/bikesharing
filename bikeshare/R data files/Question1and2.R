#########################################################################
# question 1: Data visuals: rider/month

attach(bikeExcel)

month <-  as.numeric( substr(`Start Time`,6,7))
table(month)
hist(month)
#plot(table(month),type="o", col="blue")
#spring <- subset(bikeExcel,month == "03" | month =="04"|month =="05")

# net change of bike for each station
star <- as.numeric(`Starting Station ID`)
end <- as.numeric(`Ending Station ID`)
starFreq <- table(star)
endFreq <- table(end)
net <- starFreq - endFreq
result <- sort(net)
top10 <- result[1:10 ]
View(top10)

resort <- sort(net, decreasing=TRUE)
last10 <- resort[1:10]
View(last10)

detach(bikeExcel)

#################################
# question 2: Which start/stop stations are most popular?

attach(bikeExcel) 

id <-  `Starting Station ID`
sorted <- sort(table(id), decreasing=TRUE)
top10 <- sorted[1:10]
top10

id <-  `Ending Station ID`
sorted <- sort(table(id), decreasing=TRUE)
top10 <- sorted[1:10]
top10

detach(bikeExcel)




