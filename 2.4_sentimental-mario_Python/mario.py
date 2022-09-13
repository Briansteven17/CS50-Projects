import cs50
# TODO


while True:
    size = cs50.get_int("Height: ")  # request for 'int' value
    if size > 0 and size < 9:  # if request value is between 0 and 8 break loop
        break

for i in range(size):
    i += 1
    print(" " * (size - i) + "#" * i, end="")  # print first half pyramid
    print("  ", end="")  # print double space between pyramids
    print("#" * (i))  # print another half of pyramid