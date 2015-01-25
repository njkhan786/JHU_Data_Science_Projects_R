# Would PCA inprove the prediction?
# Let's try it with 1% data

insmall <- createDataPartition(y = sdata$classe,
                               p = 0.99, list = FALSE)
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

# the distribution looks pretty linear, let's just take the 
# original values instead of taking a log

preProc <- preProcess(smacc[,-17], method ="pca", pcaComp=4)
trainPC <- predict(preProc, smacc[,-17])

modFit <- train(smacc$classe ~., data = trainPC, method ='rf', prox = TRUE)
#########################################
# Testing the model accuracy with PCA:

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
testPC <- predict(preProc, smtest[, -17])
pred <- predict(modFit, testPC)
smtest$predRight <- pred == smtest$classe
table(pred, smtest$classe)
# accuracy: only 39% wors then no PCA?
sum(smtest$predRight)/194.

# does not matter much.... let's just not do it.





########################################
# Test it with actual test data
# we can't do that since there are only 20 of them and we don't know the real class

# Prediction on the test set:

testdata <- read.csv('pml-testing.csv')
# clean in just as the small dataset
names <- names(testdata)
acc <- grep('acc', names)
acc <- c(acc, grep('classe', names))
smtest <- testdata[,acc]

namesacc <- names(smtest)
vartest <- grep('var', namesacc)
smtest <- smtest[-vartest]
head(smtest)


testPC <- predict(preProc, smtest[, -17])
pred <- predict(modFit, testPC)
