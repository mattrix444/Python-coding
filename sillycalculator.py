import re
from operator import add, sub, mul, truediv
import random


column1=["artless", "bawdy", "beslubbering", "bootless", "churlish", "cockered", "clouted", "craven", "currish", "dankish", "dissembling", "droning", "errant", "fawning", "fobbing", "forward", "frothy", "gleeking", "goatish", "gorbellied", "impertinent", "infectious", "jarring", "loggerheaded", "lumpish", "mammering", "mangled", "mewling", "paunchy", "pribbling", "puking", "puny", "qualling", "rank", "reeky", "roguish", "ruttish", "saucy", "spleeny", "spongy", "surly", "tottering", "unmuzzled", "vain", "venomed", "villainous", "warped", "wayward", "weedy", "yeast"]
column2=["base-court", "bat-fowling", "beef-witted", "beetle-headed", "boil-brained", "clapper-clawed", "clay-brained", "common-kissing", "crook-pated", "dismal-dreaming", "dizzy-eyed", "doghearted", "dread-bolted", "earth-vexing", "elf-skinned", "fat-kidneyed", "fen-sucked", "flap-mouthed", "fly-bitten", "folly-fallen", "fool-born", "full-gorged", "guts-griping", "half-faced", "hasty-witted", "hedge-born", "hell-hated", "idle-headed", "ill-breeding", "ill-nurtured", "knotty-pated", "milk-livered", "motley-minded", "onion-eyed", "plume-plucked", "pottle-deep", "pox-marked", "reeling-ripe", "rough-hewn", "rude-growing", "rump-fed", "shard-borne", "sheep-biting", "spur-galled", "swag-bellied", "tardy-gaited", "tickle-brained", "toad-spotted", "unchin-snouted", "weather-bitten"]
column3=["apple-john", "baggage", "barnacle", "bladder", "boar-pig", "bugbear", "bum-bailey", "canker-blossom", "clack-dish", "clotpole", "coxcomb", "codpiece", "death-token", "dewberry", "flap-dragon", "flax-wench", "flirt-gill", "foot-licker", "fustilarian", "giglet", "gudgeon", "haggard", "harpy", "hedge-pig", "horn-beast", "hugger-mugger", "joithead", "lewdster", "lout", "maggot-pie", "malt-worm", "mammet", "measle", "minnow", "miscreant", "moldwarp", "mumble-news", "nut-hook", "pigeon-egg", "pignut", "puttock", "pumpion", "ratsbane", "scut", "skainsmate", "strumpet", "varlot", "vassal", "whey-face", "wagtail"]
typenum = "type a number"
operator_insults = ["literally so stupid, type an operator(+,-,*,/)",
                    "Did you go to school? type an operator(+,-,*,/)",
                    "lacking brain matter i see, type an operator(+,-,*,/)",
                    "you stupid? try typing an operator(+,-,*,/)",
                    "are you pretending to be dense? type an operator(+,-,*,/)",
                    "actually dimmer than a  broken lightbulb, type an operator(+,-,*,/)",
                    "soo very braindead, type an operator(+,-,*,/)",
                    "feel a bit scatterbrained? type an operator(+,-,*,/)",
                    "a newborn baby has more intelligence, type an operator(+,-,*,/)"
                    ]


def operators():
    patt = re.compile("(\*|\+|-|/)")
    num_patt = re.compile("\d{,10}")

    nums = input("type a number: ")
    while not re.fullmatch(num_patt, nums) or nums == "":
        print(f"you {random.choice(column1)} {random.choice(column2)} {random.choice(column3)} {typenum}")
        nums = input("type a number: ")

    nums2 = input("type another number if you have enough brain capacity...: ")
    while not re.fullmatch(num_patt, nums2) or nums2 == "":
        print(f"you {random.choice(column1)} {random.choice(column2)} {random.choice(column3)} {typenum}")
        nums2 = input("type a number: ")

    quizin = input("what ya wanna do to the numbers?: ")
    while not re.fullmatch(patt, quizin) or quizin == "":
        print(f"{random.choice(operator_insults)}")
        quizin = input("what ya wanna do to the numbers?: ")

    if quizin == "+":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {add(int(nums), int(nums2))}")
    elif quizin == "-":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {sub(int(nums), int(nums2))}")
    elif quizin == "*":
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {mul(int(nums), int(nums2))}")
    else:
        print(f"\nyour calculation is {nums} {quizin} {nums2} which is {round(truediv(int(nums), int(nums2)), 2)}")

    print(f"\nif you got this far without typing something stupid then you might have more than 2 braincells, "
          f"well done. "
          f"If not then you are a {random.choice(column1)} {random.choice(column2)} {random.choice(column3)}")


operators()
