
# first steps with assignment 3 -------------------------------------------

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
str(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


states <- unique(outcome$State)
"MD" %in% states
!("MD" %in% states)
"BB" %in% states
if (states["MD"]) {
  message("jo")
}

names(outcome)


# try out best.R ----------------------------------------------------------

source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")


# try out rankhospital.R --------------------------------------------------

source("rankhospital.R")

rankhospital("TX", "heart failure", 4)
#[1] "DETAR HOSPITAL NAVARRO"

rankhospital("MD", "heart attack", "worst")
#[1] "HARFORD MEMORIAL HOSPITAL"

rankhospital("MN", "heart attack", 5000)
#[1] NA

# submitting --------------------------------------------------------------

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
submit()
