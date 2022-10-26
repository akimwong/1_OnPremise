
"""
Author : 
Date   : today
"""

import argparse


def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Picnic Game',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)


    '''
    nargs stands for Number Of Arguments
    3: 3 values, can be any number you want
    ?: a single value, which can be optional
    *: a flexible number of values, which will be gathered into a list
    +: like *, but requiring at least one value 
    '''
    parser.add_argument('food',
                        help='A named picnic food for argument(s)',
                        metavar='str',
                        type=str,
                        nargs='+')

    '''
    The store_true option automatically creates a default value of False.
    Likewise, store_false will default to True when the command-line argument is not present.
    '''
    parser.add_argument('-s',
                        '--sorted',
                        help='Is used if you want to show the products sorted',
                        action='store_true')    
    return parser.parse_args()


def main():
    """Format the items"""

    args = get_args()
    foodList = args.food
    lenFoodList = len(foodList)  

    if args.sorted:
        foodList.sort()

    food = ''
    if lenFoodList == 1:
        food == foodList
    elif lenFoodList == 2:
        food = (f'{foodList[-2]} and {foodList[-1]}')
    elif lenFoodList > 2:
        for i in range (lenFoodList-2):
            food = food + (f'{foodList[i]}, ')
        food = food + (f'{foodList[-2]} and {foodList[-1]}')

    print(f"You are bringing {food}")

'''
<<<<< SOLUTION OF THE WRITER >>>>>

def main():
"""Make a jazz noise here"""

args = get_args()
items = args.item
num = len(items)

if args.sorted:
    items.sort()

# The join() method takes all items in an iterable and joins them into one string.
# A string must be specified as the separator.

bringing = ''
if num == 1:
    bringing = items[0]
elif num == 2:
    bringing = ' and '.join(items)
else:
    items[-1] = 'and ' + items[-1]
    bringing = ', '.join(items)

print('You are bringing {}.'.format(bringing))
'''
    
    
# --------------------------------------------------
if __name__ == '__main__':
    main()
