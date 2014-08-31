
# Ranking hospitals by outcome in a state ---------------------------------


rankhospital <- function(state, outcome, num = "best") {
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
  if (!(num %in% c("best", "worst")) && !is.numeric(num)) {
    stop("invalid num")
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (outcome == "pneumonia") {
    data.state <- data[data$State == state,c(2,23)]
  } else if (outcome == "heart attack") {
    data.state <- data[data$State == state,c(2,11)]
  } else if (outcome == "heart failure") {
    data.state <- data[data$State == state,c(2,17)]
  }
  data.state[, 2] <- suppressWarnings(as.numeric(data.state[, 2]))
  data.state <- data.state[complete.cases(data.state),] # remove NAs
  #data.state[,3] <- order(data.state[2])
  data.state.ordered <- data.state[order(data.state[2], data.state[1]),] #order by lowest 30-day death rate
  
  if (num == "best") {
    data.state.ordered[1,1]
  } else if (num == "worst") {
    tail(data.state.ordered, n=1)$Hospital.Name
  } else if (is.numeric(num)) {
    data.state.ordered[num,1]
  }
}