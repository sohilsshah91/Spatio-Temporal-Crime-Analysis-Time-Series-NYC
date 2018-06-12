pop65 <- read.csv(file = "##put path to borough-populationaged65.csv after downloading from here", header = TRUE, sep=",")
totalpop <- read.csv(file = "##put path to borough-population.csv after downloading from here", header = TRUE, sep=",")

pop65$short_name <- NULL
pop65$long_name <- NULL

totalpop$short_name <- NULL
totalpop$long_name<-NULL
library(dplyr)
x <- c("Bronx", "Manhattan", "Queens", "Brooklyn", "Staten Island")
pop65 <- pop65 %>%
  + slice(match(x, Borough))

totalpop <- totalpop %>%
  + slice(match(x, Borough))

pop65$X2000 <- NULL
pop65$X2005 <- NULL
totalpop$X2000 <- NULL
totalpop$X2005 <- NULL

colnames(pop65)[2] <- "2006"
colnames(pop65)[3] <- "2007"
colnames(pop65)[4] <- "2008"
colnames(pop65)[5] <- "2009"
colnames(pop65)[6] <- "2010"
colnames(pop65)[7] <- "2011"
colnames(pop65)[8] <- "2012"
colnames(pop65)[9] <- "2013"
colnames(pop65)[10] <- "2014"
colnames(pop65)[11] <- "2015"
colnames(pop65)[12] <- "2016"

colnames(totalpop)[2] <- "2006"
colnames(totalpop)[3] <- "2007"
colnames(totalpop)[4] <- "2008"
colnames(totalpop)[5] <- "2009"
colnames(totalpop)[6] <- "2010"
colnames(totalpop)[7] <- "2011"
colnames(totalpop)[8] <- "2012"
colnames(totalpop)[9] <- "2013"
colnames(totalpop)[10] <- "2014"
colnames(totalpop)[11] <- "2015"
colnames(totalpop)[12] <- "2016"

library("reshape2")
pop65melted <- melt(pop65, id.vars="Borough", value.name = "perc_65plus", variable.name="Year")
totalpopmelted <- melt(totalpop, id.vars="Borough", value.name = "total_pop", variable.name="Year")
mergedtotalpopandper65 <- cbind(pop65melted, totalpopmelted)[order(c(seq_along(pop65melted), seq_along(totalpopmelted)))]
mergedtotalpopandper65$Borough.1 <-NULL
mergedtotalpopandper65$Year.1 <- NULL
mergedtotalpopandper65$total65pop <- with(mergedtotalpopandper65, perc_65plus * total_pop)
mergedtotalpopandper65$perc_65plus <- NULL
mergedtotalpopandper65$total_pop <- NULL

## manually input total number of crimes per borough into Excel 
## this file is available in this folder

total_num_crime <- read.csv(file = "put file path to numberofcrimes_borough.csv here", header = TRUE, sep=",")
totalnumcrime_melted <- melt(total_num_crime, id.vars="Borough", value.name = "total_crime", variable.name="Year")
pop65_numcrime <- cbind(mergedtotalpopandper65, totalnumcrime_melted)[order(c(seq_along(mergedtotalpopandper65), seq_along(totalnumcrime_melted)))]
pop65_numcrime$Borough.1 <- NULL
pop65_numcrime$Year.1 <- NULL
pop65_numcrime$Borough <- as.factor(pop65_numcrime$Borough)

##plot with ggplot
library(ggplot2)
ggplot(pop65_numcrime, aes(x=total65pop, y=total_crime, shape=Borough, color=Borough)) + geom_point() + geom_smooth(method=lm)

#seperate by boroughs
justmanh <- pop65_numcrime[pop65_numcrime$Borough %in% c("Manhattan"), ]
justbronx <- pop65_numcrime[pop65_numcrime$Borough %in% c("Bronx"), ]
justbrooklyn <- pop65_numcrime[pop65_numcrime$Borough %in% c("Brooklyn"), ]
juststaten <- pop65_numcrime[pop65_numcrime$Borough %in% c("Staten Island"), ]
justqueens <- pop65_numcrime[pop65_numcrime$Borough %in% c("Queens"), ]

justmanhcor <- cor.test(justmanh$total65pop, justmanh$total_crime, method = "pearson")
justbronxcor <- cor.test(justbronx$total65pop, justbronx$total_crime, method = "pearson")
justbrooklyncor <- cor.test(justbrooklyn$total65pop, justbrooklyn$total_crime, method = "pearson")
justqueenscor <- cor.test(justqueens$total65pop, justqueens$total_crime, method = "pearson")
juststatencor <- cor.test(juststaten$total65pop, juststaten$total_crime, method = "pearson")

justmanhcor
justbronxcor
justbrooklyncor
justqueenscor
juststatencor

ggplot(juststaten, aes(x=Year, y=total_crime, group=1, color = "red")) + geom_line() + geom_point(size=1) + ggtitle("Staten Island 2006 - 2016")
ggplot(juststaten, aes(x=Year, y=total65pop)) + geom_line(aes(group=1), colour = "blue") + geom_point(size=1, colour = "blue") + ggtitle("Staten Island 2006 - 2016")

ggplot(justbrooklyn, aes(x=Year, y=total65pop)) + geom_line(aes(group=1), colour = "blue") + geom_point(size=1, colour = "blue") + ggtitle("Brooklyn 2006 - 2016")
ggplot(justbrooklyn, aes(x=Year, y=total_crime, group=1, color = "red")) + geom_line() + geom_point(size=1) + ggtitle("Brooklyn 2006 - 2016")

ggplot(justqueens, aes(x=Year, y=total65pop)) + geom_line(aes(group=1), colour = "blue") + geom_point(size=1, colour = "blue") + ggtitle("Queens 2006 - 2016")
ggplot(justqueens, aes(x=Year, y=total_crime, group=1, color = "red")) + geom_line() + geom_point(size=1) + ggtitle("Queens 2006 - 2016")

ggplot(justbronx, aes(x=Year, y=total65pop)) + geom_line(aes(group=1), colour = "blue") + geom_point(size=1, colour = "blue") + ggtitle("Bronx 2006 - 2016")
ggplot(justbronx, aes(x=Year, y=total_crime, group=1, color = "red")) + geom_line() + geom_point(size=1) + ggtitle("Bronx 2006 - 2016")

ggplot(justmanh, aes(x=Year, y=total65pop)) + geom_line(aes(group=1), colour = "blue") + geom_point(size=1, colour = "blue") + ggtitle("Manhattan 2006 - 2016")
ggplot(justmanh, aes(x=Year, y=total_crime, group=1, color = "red")) + geom_line() + geom_point(size=1) + ggtitle("Manhattan 2006 - 2016")