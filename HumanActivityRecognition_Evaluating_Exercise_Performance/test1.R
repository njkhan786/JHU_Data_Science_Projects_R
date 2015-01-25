# OK, let's try the random forest on various size of the data set and see how long it takes....

# 1% of the data
# user  system elapsed 
# 13.774   0.379  14.150 
# 10% of the data
#user  system elapsed 
#363.419   3.857 367.261 
#system.time(train(classe ~., data = smacc, method ='rf', prox = TRUE))


# OK, let's try 10%
# Lets take only 1 percent of the data for building the algorithm
sdata <- read.csv('pml-training.csv')
library(caret)

insmall <- createDataPartition(y = sdata$classe,
                               p = 0.9, list = FALSE)
smdata <- sdata[-insmall,]

names <- names(smdata)
acc <- grep('acc', names)
acc <- c(acc, grep('classe', names))
smacc <- smdata[acc]
head(smacc)

namesacc <- names(smacc)
varacc <- grep('var', namesacc)
smacc <- smacc[-varacc]
head(smacc)

system.time(modFit <- train(classe ~., data = smacc, method ='rf', prox = TRUE))

#user  system elapsed 
#363.419   3.857 367.261 

##########################################
# Test:
# Testing the algorithm with some artificial test data
# select some test data randomly
test <- createDataPartition(y = sdata$classe,
                            p = 0.99, list = FALSE)
testdata <- sdata[-test,]
# clean in just as the small dataset
names <- names(testdata)
acc <- grep('acc', names)
acc <- c(acc, grep('classe', names))
smtest <- testdata[,acc]

namesacc <- names(smtest)
vartest <- grep('var', namesacc)
smtest <- smtest[-vartest]
head(smtest)


# Ok. test it.
pred <- predict(modFit, smtest)
smtest$predRight <- pred == smtest$classe
table(pred, smtest$classe)
# accuracy: 0.88% I guess this is good enough
sum(smtest$predRight)/194.
