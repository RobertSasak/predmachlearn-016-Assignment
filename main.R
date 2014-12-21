set.seed(1)
library(caret)
training <- read.csv('pml-training.csv')
testing <- read.csv('pml-testing.csv')

filterNA <-testing[,colSums(is.na(testing)) != nrow(testing)]

importantColumns <- names(filterNA)
importantColumns <- append(importantColumns, "classe")

trainingFiltered <- training[, names(training) %in% importantColumns]

trainingFiltered <- na.omit(trainingFiltered)

trainingSample <- trainingFiltered[sample(1:nrow(trainingFiltered), 2000, replace=FALSE),]

trainingFit <- train(classe ~ ., data = trainingSample, method = "rf", prox=TRUE)
trainingFit

predict(trainingFit, newdata=testing)