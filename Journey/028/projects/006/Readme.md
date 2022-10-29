(from: https://github.com/kyclark/tiny_python_projects/tree/master/05_howler)

# Howler

Write a program that uppercases the given text:

```
$ ./howler.py 'The quick brown fox jumps over the lazy dog.'
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.
```

If the text names a file, uppercase the contents of the file:

```
$ ./howler.py ../inputs/fox.txt
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.
```

If given no arguments, print a brief usage:

```
$ ./howler.py
usage: howler.py [-h] [-o str] str
howler.py: error: the following arguments are required: str
```
