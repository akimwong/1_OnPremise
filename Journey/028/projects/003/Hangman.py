import random

def ahorcado():
    df = pd.read_excel('C:\\Users\\Carlos\\0_OnPremise\\FreeCode\\palabras.xlsx')
    palabras = df['palabras'].tolist()
    posicion = random.randrange (1, len(palabras))
    word = palabras[posicion-1]
    wordref = '------'
    intentos = 10

    def checkLetter(letter, word):
        if letter in word:
            position = ([pos for pos, char in enumerate(word) if char == letter])
            return position
        else:
            return []

    def completeWord(position, letter, wordref):
        # pos = position
        for x in position:
            wordref = wordref[:x] + letter + wordref[x+1:]
        return wordref
        
    for _ in range (10):
        
        if word != wordref:
            print (f'Te quedan {intentos} intentos')
            letter = input('Give me a letter: ')
            complete = checkLetter(letter, word)
            wordref = completeWord (complete,letter,wordref)
            intentos -= 1
            print (wordref)

        elif word == wordref:
            print('You are GREAT!!!')
            break
            
    if intentos == 0:
        print ('You are DEAD ... HAHAHA!!!')
        print (f'The word was {word}')
                           
ahorcado()
