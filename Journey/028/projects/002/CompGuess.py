import random

def pythonAdivina():
    numero1 = int(input('ingresa número inferior: '))
    numero2 = int(input('ingresa número superior: '))
    tuNumero = int(input('indica un número dentro de ese rango: '))
    intento = 0
    numeroPy = random.randrange (numero1, numero2)
    print(f'El PyNumber es: {numeroPy}')
    
    def checkNumber (numeroPy, tuNumero):
        compara = input('Is PyNumber lower than your number?  (press 1) \nIs PyNumber bigger than your number? (press 2) ')
        if compara == '1':
            return 1
        else:
            return 2
    
    while tuNumero != numeroPy:
        intento += 1
        print(f'Intento: {intento}')
        check = checkNumber (numeroPy, tuNumero)
        if check == 1:
            numero1= numeroPy
            numeroPy = random.randrange (numero1, numero2)
            print(f'El nuevo número es: {numeroPy}')
        elif check == 2:
            numero2= numeroPy
            numeroPy = random.randrange (numero1, numero2)
            print(f'El nuevo número es: {numeroPy}')
            
    if tuNumero == numeroPy:
        print(f'Congratulations!!! \nThe computer identify the secret number in the intent number {intento}')
        
pythonAdivina()
