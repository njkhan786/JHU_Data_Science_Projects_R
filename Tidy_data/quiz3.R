# Getting and Cleaning data HW3
#
# Practice merging and organizing SQL-like dataset with GDP and educational data from 190 countries.

####################################################################################
#Q1
#Create a logical vector that identifies the households on greater than 10 acres who
#sold more than $10,000 worth of agriculture products. Assign that logical vector to
#the variable agricultureLogical. Apply the which() function like this to identify the
#rows of the data frame where the logical vector is TRUE. which(agricultureLogical)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', 
              "q1data.csv", method = "curl")
q1data <- read.csv("q1data.csv")

#What are the first 3 values that result?
agricultureLogical <- (q1data$AGS == '6') & (q1data$ACR == "3")
which(agricultureLogical)


# Q2:
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', 
              "q2data.jpg", method = "curl")
#install.packages("jpeg")
library(jpeg)
q2data <- readJPEG("q2data.jpg",native=TRUE)
quantile(q2data,c(0.3,0.8))


# Q3: Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ',
              "DomesticProduct.csv", method = "curl")

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ', 
              "EduData.csv", method = "curl")

#SET empty strings as NAs, or we will be matching lots of empty strings
DomPro <- read.csv("DomesticProduct.csv",na.strings = "")
EduData <- read.csv("EduData.csv",na.strings = "")

# Let's only keep useful columns
DomPro=DomPro[5:330,]

# Note that we need to change var to char before matching!!!!!!!
nDomPro <- data.frame(DomPro$X)
nDomPro$GDPrank <- DomPro$Gross.domestic.product.2012
nDomPro$DomPro.X <- as.character(nDomPro$DomPro.X)
nEduData<- data.frame(EduData$CountryCode) 
nEduData$IncomeGroup <- EduData$Income.Group
nEduData$EduData.CountryCode <- as.character(nEduData$EduData.CountryCode)

head(nDomPro)
head(nEduData)

# Since everything is matched by country name, let's just exlude data with no country names
nnDomPro <- nDomPro[!is.na(nDomPro$DomPro.X ),]
nnEduData <- nEduData[!is.na(nEduData$EduData.CountryCode),]

table(nnDomPro$DomPro.X %in% nnEduData$EduData.CountryCode)

stateDomPro <- unique(nnDomPro$DomPro.X) 
stateEduData <- unique(nnEduData$EduData.CountryCode)

table(nnDomPro$DomPro.X %in% stateEduData)
table(nnEduData$EduData.CountryCode %in% stateDomPro)
# number matched
#FALSE  TRUE 
#       224 

newq3<- merge(nnDomPro, nnEduData, by.x="DomPro.X", by.y="EduData.CountryCode", all = TRUE)
str(newq3)

nnewq3 <- newq3[!is.na(newq3$GDPrank),]
# The dats is originally factor, we have to change it to char first
# then numeric to get the sorting right.

nnewq3$GDP <- as.character(nnewq3$GDPrank)
nnewq3$GDP <- as.numeric(nnewq3$GDP)
library(plyr)
ordered<-arrange(nnewq3, desc(GDP))
head(ordered$GDPrank, n=15)
head(ordered$DomPro.X, n=15)
# KNA

# Q4: What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
str(nnewq3)
ddply(nnewq3, .(IncomeGroup), summarize, mean=round(mean(GDP),2))


