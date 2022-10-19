install.packages("readxl")
library("readxl")

HangMan <- function() {
  words <- as.vector(read_excel('6letter500words.xlsx'))
  word  <- sample(words$words,1)
  print(word)
  wordref <- '------'
  tryNum  <- 10
  
  checkLetter <- function (letter, word) {
    if (grepl(letter, word, fixed=TRUE)) {
      position <- unlist(gregexpr(pattern=letter,word))
      return (position)
    } else {
      return (0)
    }
  }
  
  completeWord <- function (position,letter,wordref) {
    for (i in position) {
      substr(wordref,i,i) <- letter
    }
    return (wordref)
  }
  
  for (i in 1:10) {
    if (word != wordref) {
      print(paste('You have',tryNum,'attempt(s)'))
      letter   <- readline(prompt='Give me a letter: ')
      complete <- checkLetter(letter, word)
      wordref  <- completeWord (complete,letter,wordref)
      tryNum   <- tryNum - 1
      print (wordref)
    } else if (word == wordref) {
      print('You are GREAT!!!')
      break
    }
    if (word == wordref) {
      print('Wow! That was your last try!')
    }
  }
  
  if (tryNum == 0 & word != wordref) {
    print ('You are DEAD ... HAHAHA!!!')
    print (paste('The word was', word))
  }
}

HangMan()
