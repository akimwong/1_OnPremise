import argparse


# --------------------------------------------------
def get_args():
    """Pick the data"""

    parser = argparse.ArgumentParser(
        description='Jump the Five',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('data',
                        metavar='str',
                        help='The data you want to encode ("####-####")')

    return parser.parse_args()


# --------------------------------------------------

def main():
    """Encode the data"""

    args = get_args()
    data = args.data
    equival = {'1':'9','2':'8','3':'7','4':'6','5':'0','6':'4','7':'3',
               '8':'2','9':'1','0':'5'}
    newString = ''
    for i in data:
        if i in equival:
            newString = "".join((newString, equival[i]))
        else:
            newString = "".join((newString, i))
    print(newString)

'''
Solutions of the writer...    

SOLUTION 1:
def main():

   args = get_args()
   jumper = {'1': '9', '2': '8', '3': '7', '4': '6', '5': '0',
             '6': '4', '7': '3', '8': '2', '9': '1', '0': '5'}

   for char in args.text:
       print(jumper.get(char, char), end='')
   print()   

SOLUTION 2:
def main():

    args = get_args()
    jumper = {'1': '9', '2': '8', '3': '7', '4': '6', '5': '0',
              '6': '4', '7': '3', '8': '2', '9': '1', '0': '5'}

    new_text = ''
    for char in args.text:
        new_text += jumper.get(char, char)
    print(new_text)    

SOLUTION 3:
def main():

    args = get_args()
    jumper = {'1': '9', '2': '8', '3': '7', '4': '6', '5': '0',
              '6': '4', '7': '3', '8': '2', '9': '1', '0': '5'}

    new_text = []
    for char in args.text:
        new_text.append(jumper.get(char, char))
    print(''.join(new_text))

'''    
    
# --------------------------------------------------
if __name__ == '__main__':
    main()
