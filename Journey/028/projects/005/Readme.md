from: https://github.com/kyclark/tiny_python_projects/blob/master/04_jump_the_five/README.md

# Jump the Five

Write a program that will encode any number in a given string using an algorightm to "jump the five" on a standard US telephone keypad such that "1" becomes "9," "4" becomes "6," etc. 
The "5" and the "0" will swap with each other.
Here is the entire substitution table:

```
1 => 9
2 => 8
3 => 7
4 => 6
5 => 0
6 => 4
7 => 3
8 => 2
9 => 1
0 => 5
```

Encode only the numbers and leave all other text alone:

```
$ ./jump.py 867-5309
243-0751
```

If given no arguments, present a brief usage:

```
$ ./jump.py
usage: jump.py [-h] str
jump.py: error: the following arguments are required: str
```
