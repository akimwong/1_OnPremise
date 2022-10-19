import pandas as pd
import random

def HangMan():
    df = pd.read_excel('C:\\Users\\Carlos\\0_OnPremise\\FreeCode\\6letters500words.xlsx')
    words = df['palabras'].tolist()
    position = random.randrange (1, len(words))
    word = words[position-1]
    wordref = '------'
    tryNum = 10
    # print(word)

    def checkLetter(letter, word):
        ''' This function checks if a letter is inside a word and return the index (including if it appears many times)'''
        if letter in word:
            position = ([pos for pos, char in enumerate(word) if char == letter])
            return position
        else:
            return []

    def completeWord(position, letter, wordref):
        '''Given a letter and an index, this function replace characters in a word according that index'''
        for x in position:
            wordref = wordref[:x] + letter + wordref[x+1:]
        return wordref
        
    for _ in range (10):
        
        if word != wordref:
            print (f'You have {tryNum} attempt(s)')
            letter = input('Give me a letter: ')
            complete = checkLetter(letter, word)
            wordref = completeWord (complete,letter,wordref)
            tryNum -= 1
            print (wordref)

    # Comment if you guess the word before the last opportunity
        elif word == wordref:
            print('You are GREAT!!!')
            break
    
    # Comment if you guess the letter in your last opportunity
    if (tryNum == 0 and wordref == word):
        print('Wow! That was your last try!')    
    
    # Comment if you don't guess the word in your opportunities    
    if (tryNum == 0 and wordref != word):
        print ('You are DEAD ... HAHAHA!!!')
        print (f'The word was {word}')
                           
HangMan()
                           
ahorcado()
