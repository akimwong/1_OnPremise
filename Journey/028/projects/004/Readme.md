(from https://github.com/kyclark/tiny_python_projects/tree/master/03_picnic)

# Picnic

Write a program that will correctly format the items we're taking on our picnic.
For one item, it should print the one item:

```
$ python picnic.py sandwiches
You are bringing sandwiches.
```

For two items, place "and" in between:

```
$ python picnic.py sandwiches chips
You are bringing sandwiches and chips.
```

For three or more items, use commas and "and":

```
$ python picnic.py sandwiches chips cake
You are bringing sandwiches, chips, and cake.
```

If the `--sorted` flag is present, the items should first be sorted:

```
$ python picnic.py sandwiches chips cake --sorted
You are bringing cake, chips, and sandwiches.
```

If no items are given, print a brief usage:

```
