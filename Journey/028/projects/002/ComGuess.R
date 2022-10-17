CompGuess <- function() {
  print('Give me a range of numbers...')
  rangeInf <- as.integer(readline(prompt='Inferior number: '))
  rangeSup <- as.integer(readline(prompt='Superior number: '))
  yourNumb <- as.integer(readline(prompt='Tell me a number inside that range: '))
  compuTry <- 0
  compNumb <- sample(rangeInf:rangeSup, 1)
  print(paste('Computer number is:',compNumb))
  
  checkNum <- function() {
    compare <- as.integer(readline(paste(prompt='Is computer number lower than your number? (press 1)','\n', 
                                         sep='','Is computer number higher than your number? (press 2): ')))
    if (compare == 1) {
      return (TRUE)
    } else {
      return (FALSE)
    }
  }
  
  while (yourNumb!=compNumb){
    compuTry <- compuTry+1
    print(paste('Attempt number:',compuTry))
    check <- checkNum ()
    
    if (check == TRUE){
      rangeInf <- compNumb
      compNumb <- sample(rangeInf:rangeSup, 1)
      #print(paste('The NEW range inferior is:',rangeInf))
      #print(paste('The range superior is:',rangeSup))
      print(paste('The NEW COMPUTER NUMBER is:',compNumb))
    } else if (check == FALSE){
      rangeSup <- compNumb
      compNumb <- sample(rangeInf:rangeSup, 1)
      #print(paste('The range inferior is:',rangeInf))      
      #print(paste('The NEW range superior is:',rangeSup))
      print(paste('The NEW COMPUTER NUMBER is:',compNumb))
    }
  }
  
  if (yourNumb==compNumb){
    print(paste(prompt='Congratulations!!! The computer guessed the number on trial number', compuTry))
  }
}

ComGuess()
