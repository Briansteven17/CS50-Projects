import cs50
# TODO

number = cs50.get_string("Number: ")

number_size = len(number)
check_size = (13, 15, 16)

if ((number_size in check_size) == False):
    print("INVALID")
    exit()

sum_evens = 0

for i in range(0, int(len(number)), 2):
    new_even = int(number[i]) * 2
    if new_even < 10:
        sum_evens += new_even
    else:
        two_digits = str(new_even)
        new_even = int(two_digits[0]) + int(two_digits[1])
        sum_evens += new_even

total_sum = sum_evens

for i in range(1, int(len(number)), 2):
    new_odd = int(number[i])
    total_sum += new_odd

#last_digit = str(total_sum)
# if int(last_digit[len(last_digit) - 1]) != 0:
    # print("INVALID")
    # exit()

first_two = int(number[0:2])
check_mastercard = (51, 52, 53, 54, 55)
check_amex = (34, 37)
first_one = int(number[0])
check_visa = 4

if ((first_two in check_mastercard) == True):
    print("MASTERCARD")

elif ((first_two in check_amex) == True):
    print("AMEX")

elif (first_one == check_visa):
    print("VISA")

else:
    print("INVALID")
    exit()


# American express 15 digits, starts with 34 or 37
# Mastercard 16 digits, starts with 51, 52, 53, 54 or 55
# Visa 13 or 16 digits, starts with 4

