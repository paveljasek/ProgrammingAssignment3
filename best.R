
# Finding the best hospital in a state ------------------------------------

best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  states <- unique(data$State) #check against the actual data
  if ((state %in% states) == FALSE) {
    stop("invalid state")
  }
  if (!(outcome %in% c("pneumonia", "heart attack", "heart failure"))) {
    stop("invalid outcome")
  }
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  if (outcome == "pneumonia") {
    data.state <- data[data$State == state,c(2,23)]
  } else if (outcome == "heart attack") {
    data.state <- data[data$State == state,c(2,11)]
  } else if (outcome == "heart failure") {
    data.state <- data[data$State == state,c(2,17)]
  }
  data.state[, 2] <- suppressWarnings(as.numeric(data.state[, 2]))
  data.state.ordered <- data.state[order(data.state[2], na.last = NA),] #lowest 30-day death rate
  data.state.ordered[1,1]
}