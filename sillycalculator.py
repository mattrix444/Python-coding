import re
from operator import add, sub, mul, truediv




def operators():
    patt = re.compile("(\*|\+|-|/)")
    num_patt = re.compile("\d{,10}")

    nums = input("type a number: ")
    while not re.fullmatch(num_patt, nums):
        print("literally so stupid, type a number idiot")
        nums = input("type a number: ")

    nums2 = input("type another number if you have enough brain capacity...: ")
    while not re.fullmatch(num_patt, nums2):
        print("so moronically dumb, try actually typing a number")
        nums2 = input("type a number: ")

    quizin = input("what ya wanna do to the numbers?: ")
    while not re.fullmatch(patt, quizin):
        print("try not being so low intelligence all your life, use an operator(+,-,*,/)")
        quizin = input("what ya wanna do to the numbers?: ")

    if quizin == "+":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {add(int(nums), int(nums2))}")
    elif quizin == "-":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {sub(int(nums), int(nums2))}")
    elif quizin == "*":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {mul(int(nums), int(nums2))}")
    else:
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {truediv(int(nums), int(nums2))}")

    print("\nif you got this far without typing something stupid then you might have more than 2 braincells, "
          "well done. If not then id suggest asking a child to teach you abc and 123 :)")


operators()
