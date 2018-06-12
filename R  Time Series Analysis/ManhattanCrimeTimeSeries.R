## load crime data
## thank you: http://ucanalytics.com/blogs/step-by-step-graphic-guide-to-forecasting-through-arima-modeling-in-r-manufacturing-case-study-example/
crimedata <- read.csv(file = "##put path to file here", header = TRUE, sep=",")

## clean up the data so that the only 2 columns are "complaint date" and "borough name"
crimedata <- crimedata[c("CMPLNT_FR_DT", "BORO_NM")]
## clean up data for the rows that only contain Manhattan 
crimedata_manhattan <- crimedata[crimedata$BORO_NM %in% c("MANHATTAN"), ]
## export the dataframe to csv
##write.csv(crimedata_manhattan, file = "")

## Used pivot table in Excel in order to process the data further
## Added up the number of crimes per day for Manhattan since Januaray 01, 2006 until December 31st, 2016
## Noticed that there were Date values that were incomplete/incorrect 
## Excel made it very easy to delete those values 
## Made the data into a time-series-dataframe-compatible format by fixing the Dates to 
##    "(last digit of year)-(Month abbreviation)" format.
##     for example: January, 2006 => 6-Jan
## After aggregating the number of crimes per day in Manhattan, we noticed that there wasn't much data from 2011 to 2014.
## We deleted the data that we had for those years to allow for more accurate time series analysis - (we used data only from 2006 to 2010)

manhattan <- read.csv(file = "##put path to the final.csv file after download", header = TRUE, sep = ",")
manhattan <- ts(manhattan[,2],start = c(2006,1), frequency = 12)
plot(manhattan, xlab = 'Years', ylim=c(0,12000), ylab = 'number of crimes in Manhattan')

#1st order differencing
plot(diff(manhattan), ylab = 'Differenced Number of Crimes in Manhattan')
#Make data stationary on variance
plot(log10(manhattan),ylab = 'Log (Number of crimes)')
#Make data stationary on both mean and variance
plot(diff(log10(manhattan)), ylab='Differenced Log(Number of crimes)')

#Plot ACF and PACF
par(mfrow=c(1,2))
acf(ts(diff(log10(manhattan))),main = 'ACF Number of Crimes')
pacf(ts(diff(log10(manhattan))), main = 'PACF Number of Crimes')

## getting ARIMA summary based on dataset
require(forecast)
ARIMAfit = auto.arima(log10(manhattan), approximation=FALSE, trace=FALSE)
summary(ARIMAfit)

## plotting the future
par(mfrow = c(1,1))
## how far do we want to predict ahead
predicted = predict(ARIMAfit, n.ahead = 36)
predictedplot = plot(manhattan, type='l', xlim=c(2006, 2011), ylim = (0, 12000), xlab = 'Year', ylab = 'Number of Crimes')
lines(10^(predictedplot$predplot),col='blue')
lines(10^(predictedplot$predplot+2*predictedplot$se),col='orange')
lines(10^(predictedplot$predplot-2*predictedplot$se),col='orange')

## checking for residuals
par(mfrow=c(1,2))
acf(ts(ARIMAfit$residuals),main='ACF Residual')
pacf(ts(ARIMAfit$residuals),main='PACF Residual')