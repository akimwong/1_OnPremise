youGuess <- function() {
  print('Give me a range of numbers...')
  rangeInf <- as.integer(readline(prompt='Inferior number: '))
  rangeSup <- as.integer(readline(prompt='Superior number: '))
  compuNum <- sample(rangeInf:rangeSup, 1)  # '1' is the number of samples
  # print(compuNum)
  compareNum <- function(compuNum) {
    yourNum <- as.integer(readline(prompt='Give me a number: '))
    
    if (yourNum < compuNum) {
      print ('Ups! Computer number is greater than your number')
      
    } else if (yourNum == compuNum) {
      print ('Perfect! Computer number is the same as your number')
      print ('End of Game')
      playAgain <- readline(prompt='Play again? (y/n): ')
      if (playAgain == 'y'){
        youGuess()
      } else {
        return (FALSE)
      }
      
    } else {
        print ('Ups! Computer number is lower than your number')
    }
  }
  for (i in 1:10) {
    loop = TRUE
    loop = compareNum(compuNum)
    if (loop == FALSE) {
      print('Thank you, Bye!')
      break
    }
  }
  if (loop != FALSE) {
    print('Sorry, no more opportunities')
  }
}

youGuess()
