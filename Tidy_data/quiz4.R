#Q1
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', 
              "IdahoHousing.csv", method = "curl")
idahohousing <- read.csv("IdahoHousing.csv")

#Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
#What is the value of the 123 element of the resulting list?

head(idahohousing)
name <- names(idahohousing)
splitname <- strsplit(name,'wgtp')
splitname[123]


#Q2 &3: GDP of 190 countries
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ', 
              "GDP.csv", method = "curl")
gdp <- read.csv("GDP.csv",skip=4)
# X4 is gdp in millions of dollars
#Remove the commas from the GDP numbers in millions of dollars and average them. 
#What is the average? 

gdp$number <- gsub(",", "", gdp$X.4) 
gdp$number <- as.numeric(gdp$number)
mean(gdp$number[1:215], na.rm = TRUE)

head(gdp)
gdp$country <- as.character(gdp$X.3)
grep("^United",gdp$country)


# Q4: - I didn't finish this one 
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ', 
              "EDU.csv", method = "curl")
edu <- read.csv("EDU.csv")
names(gdp)
names(edu)

# Match the data based on the country shortcode. Of the countries for which the end 
# of the fiscal year is available, how many end in June? 


# Q5: stock data:
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

table(format(sampleTimes, "%Y") == "2012")
table((format(sampleTimes, "%Y") == "2012") & (weekdays(sampleTimes)== 'Monday'))
