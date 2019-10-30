import sys
def write_file(path):
    with open(path, "w") as f:
        header = input("Input header: ") + '\n'
        f.write(header)

        for i in range(int(1e6)):
            f.write("{}\n".format(i))


if __name__ == "__main__":
    if len(sys.argv) == 2:
        write_file(sys.argv[1])