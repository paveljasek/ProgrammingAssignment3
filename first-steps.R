
# first steps with assignment 3 -------------------------------------------

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
str(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])