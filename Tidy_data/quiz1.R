# Question 1,2 - community data in csv form
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv' 
download.file(fileUrl, destfile ='community.csv', method = 'curl')
dateDownloaded <- date()

data<- read.csv('community.csv')
head(data,5)

#How many properties are worth $1,000,000 or more?
# Val - value  Val = 24 means the property worthes $1M or more
new <- data[data$VAL=='24',]
new <- new[!is.na(new$VAL),]
dim(new)

# Q3 - xlsx data
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx' 
download.file(fileUrl, destfile ='NaturalGas.xslx', method = 'curl')

library(xlsx)
dat <- read.xlsx('NaturalGas.xslx', sheetIndex=1,colIndex = 7:15, rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

# Q4 - XML data
xmlUrl <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml' 
library(XML)

# the xmlTreeParse package somehow can't deal with https so I changed the URL to http
doc<-xmlTreeParse(xmlUrl,useInternalNodes = T)

rootNode <- xmlRoot(doc)   
xmlName(rootNode)  
names(rootNode)   
#rootNode[[1]][[1]]
zcode <- xpathSApply(doc, "//zipcode", xmlValue) # to extract all the zipcode
table(zcode)


# Q5 - another set of community data
library(data.table)
fileUrl5 <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
DT <- fread(fileUrl5)
# Test which one is faster:

# Doesn't work as intented
mean(DT$pwgtp15,by=DT$SEX)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]


# works:

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
#> system.time(mean(DT[DT$SEX==1,]$pwgtp15))
#user  system elapsed 
#0.026   0.001   0.027 
#> system.time(mean(DT[DT$SEX==2,]$pwgtp15))
#user  system elapsed 
#0.027   0.000   0.028 



DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX])
#> system.time(DT[,mean(pwgtp15),by=SEX])
#user  system elapsed 
#0.002   0.000   0.002 

tapply(DT$pwgtp15,DT$SEX,mean)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
#> system.time(tapply(DT$pwgtp15,DT$SEX,mean))
#user  system elapsed 
#0.006   0.000   0.007 

sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#> system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#user  system elapsed 
#0.004   0.000   0.003 


