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
        header = "id;name;surname;age;group;gpa\n"
        f.write(header)

       # for i in range(500):
       #     f.write("{};{};{};{};{};".format(i, get_elem(name)[:-2], get_elem(surname)[:-2], random.randint(9, 20), get_elem(group)))
       #     f.write("{}\n".format(round(random.uniform(2.0, 5.0), 2)))

        #for i in range(40):
        #    f.write("{};{};{};{};{}\n".format(i, get_elem(name)[:-2], get_elem(surname)[:-2], random.randint(25, 50), get_elem(group)))

        for i in range(500):
            f.write("{};{};{};{};{};".format(i, get_elem(name)[:-2], get_elem(surname)[:-2], random.randint(9, 20), get_elem(group)))
            f.write("{}\n".format(round(random.uniform(2.0, 5.0), 2)))

if __name__ == "__main__":
    name.extend(read_file('name'))
    surname.extend(read_file('surname'))

    
    for i in range(25):
        group.append("{}{}-{}-{}".format(chr(random.randint(65, 75)), 
                                chr(random.randint(65, 75)),
                                    random.randint(10, 15),
                                    random.randint(0, 8)))
    #for i in range(25):
    #    group.append("{} {}".format(random.randint(1, 11), chr(random.randint(65, 70))))

    write_file('data_teacher.csv')
