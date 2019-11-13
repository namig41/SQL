#! /usr/bin/python3.6

import sys
import random

name = []
surname = []
group = []

def read_file(path):
    l = []
    with open(path) as f:
        l = list(f)
    return l

def get_elem(l):
    return l[random.randint(0, len(l) - 1)]

def write_file(path):
    with open(path, "w") as f:
        header = "id;name;surname;age;group\n"
        f.write(header)
        for i in range(int(5e5)):
            f.write("{};{};{};{}\n".format(i, get_elem(name)[:-2], get_elem(surname)[:-2], random.randint(9, 20)))

if __name__ == "__main__":
    name.extend(read_file('name'))
    surname.extend(read_file('surname'))
    write_file('BIG.csv')
