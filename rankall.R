
# Ranking hospitals in all states -----------------------------------------


rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- unique(data$State) #check against the actual data
  
  ## Check that state and outcome are valid
  if (!(outcome %in% c("pneumonia", "heart attack", "heart failure"))) {
    stop("invalid outcome")
  }
  if (!(num %in% c("best", "worst")) && !is.numeric(num)) {
    stop("invalid num")
  }
  
  ## For each state, find the hospital of the given rank
  results <- data.frame(states)
  for (state in states)  {
    #message("state: ", state)
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
      value <- data.state.ordered[1,1]
    } else if (num == "worst") {
      value <- tail(data.state.ordered, n=1)$Hospital.Name
    } else if (is.numeric(num)) {
      value <- data.state.ordered[num,1]
    }
    results[results$states==state,2] <- value
  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name)
  results <- results[order(results[1]),c(2,1)]
  names(results) <- c("hospital", "state")
  
  results
}