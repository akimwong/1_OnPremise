import random

def adivina():
    print('Dame un rango de números... ')
    rangoInf = int(input('Dime el número inferior: '))
    rangoSup = int(input('Dime el número superior: '))
    numeroAl = random.randrange (rangoInf, rangoSup)
    
    def comparaNumero(numeroAl):
        tunumero = int(input('Dime un número: '))

        if tunumero < numeroAl:
            print ('Ups! El número aleatorio es mayor a tu número')

        elif tunumero == numeroAl:
            print ('Perfect! El número aleatorio es igual a tu número')
            print ('End of Game')

            play = input('Play again (y/n)? ')
            if play == 'y':
                adivina()
            else:
                return False
        else:
            print ('Ups! El número aleatorio es menor a tu número')

    for _ in range (15):
        loop = True
        loop = comparaNumero(numeroAl)
        if loop == False:
            break
    
adivina()
