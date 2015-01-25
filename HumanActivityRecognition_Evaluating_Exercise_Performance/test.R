sdata <- read.csv('pml-training.csv')

library(caret)

# Lets take only 1 percent of the data for building the algorithm
insmall <- createDataPartition(y = sdata$classe,
                               p = 0.99, list = FALSE)
smdata <- sdata[-insmall,]


# your goal will be to use data from accelerometers on the 
# belt, forearm, arm, and dumbell of 6 participants
# First only extract accelerator data
names <- names(smdata)
acc <- grep('acc', names)
acc <- c(acc, grep('classe', names))
smacc <- smdata[acc]
head(smacc)

namesacc <- names(smacc)
varacc <- grep('var', namesacc)
smacc <- smacc[-varacc]
head(smacc)


# A linear model?
# It says wrong model type for classification
#modFit2 <- train(classe ~ ., data = smacc, method ='lm')
#summary(modFit$finalModel)

# Let's try bagging? (random forest)
# maybe I should do it differently for different exercise?

system.time(train(classe ~., data = smacc, method ='rf', prox = TRUE))
modFit <- train(classe ~., data = smacc, method ='rf', prox = TRUE)
modFit
modFit$finalModel

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
# accuracy: 61% note terrible....
sum(smtest$predRight)/194.

# After experiment:
# PCA doesn't really help.

