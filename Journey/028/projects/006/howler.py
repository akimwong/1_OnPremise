"""
Author : Me>
Date   : today
Purpose: MyHowler
"""

import argparse

# --------------------------------------------------
def get_args():
    """insert the argument arguments"""

    parser = argparse.ArgumentParser(
        description='Howler',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('phrase',
                        metavar='str',
                        help='A positional argument')

    return parser.parse_args()


# --------------------------------------------------
def main():
    """ My solution """

    args = get_args()
    text = args.phrase
    if text[-4:] == '.txt':
        with open(text, 'r') as file:
            internalText = file.read().replace('\n', '')
            print(internalText.upper())
    else:
        print(text.upper())

'''
solution of the book

import argparse
import os
import sys

# --------------------------------------------------
def get_args():
    """ sol1 """

    parser = argparse.ArgumentParser(
        description='Howler (upper-cases input)',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('text',
                        metavar='text',
                        type=str,
                        help='Input string or file')

    parser.add_argument('-o',
                        '--outfile',
                        help='Output filename',
                        metavar='str',
                        type=str,
                        default='')

    args = parser.parse_args()

    ## os.path.isfile(path) returns True if specified path is an existing regular file, otherwise returns False.

    if os.path.isfile(args.text):
        args.text = open(args.text).read().rstrip()

    return args


# --------------------------------------------------
def main():
    """Make a jazz noise here"""

    args = get_args()
    out_fh = open(args.outfile, 'wt') if args.outfile else sys.stdout
    out_fh.write(args.text.upper() + '\n')
    out_fh.close()
'''

# --------------------------------------------------

if __name__ == '__main__':
    main()
