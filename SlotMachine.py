import random
from colorama import Fore
from colorama import Style


MAX_LINES = 3
MAX_BET = 100
MIN_BET = 1

ROWS = 3
COLS = 3

symbol_count = {
    "A": 2,
    "B": 4,
    "C": 6,
    "D": 8
}

symbol_value = {
    "A": 6,
    "B": 4,
    "C": 2,
    "D": 1
}

def check_winnings(columns, lines, bet, values):
    winnings = 0
    winning_lines = []
    for line in range(lines):
        symbol = columns[0][line]
        for column in columns:
            symbol_to_check = column[line]
            if symbol != symbol_to_check:
                break
        else:
            winnings += values[symbol] * bet
            winning_lines.append(line + 1)

    return winnings, winning_lines



def get_slot_machine_spin(rows, cols, symbols):
    all_symbols = []
    for symbol, symbol_count in symbols.items():
        for _ in range(symbol_count):
            all_symbols.append(symbol)

    columns = []
    for _ in range(cols):
        column = []
        current_symbols = all_symbols[:]
        for _ in range(rows):
            value = random.choice(current_symbols)
            current_symbols.remove(value)
            column.append(value)

        columns.append(column)

    return columns

def print_slot_machine(columns):
    for row in range(len(columns[0])):
        for i, column in enumerate(columns):
            if i != len(columns) - 1:
                print(column[row], end=" ¦ ")
            else:
                print(column[row], end="")
        print()

def deposit():
    while True:
        amount = input("How much do you want to deposit?: ")
        if amount.isdigit():
            amount = int(amount)
            if amount >= 0:
                break
            else:
                print("amount must be greater than £0!")
        else:
            print(f"Please enter a {Fore.RED}valid{Style.RESET_ALL} number: ")

    return amount


def get_number_of_lines():
    while True:
        lines = input("How many win lines? (1-" + str(MAX_LINES) + "): ")
        if lines.isdigit():
            lines = int(lines)
            if 1 <= lines <= MAX_LINES:
                break
            else:
                print("try entering something valid")
        else:
            print(f"Please enter a {Fore.RED}valid{Style.RESET_ALL} number: ")

    return lines


def get_bet():
    while True:
        amount = input("How much do you want to bet? (per line): ")
        if amount.isdigit():
            amount = int(amount)
            if MIN_BET <= amount <= MAX_BET:
                break
            else:
                print(f"amount must be between £{MIN_BET} - £{MAX_BET}.")
        else:
            print(f"Please enter a {Fore.RED}valid{Style.RESET_ALL} number: ")

    return amount
def spin(balance):
    lines = get_number_of_lines()
    while True:
        bet = get_bet()
        total_bet = bet * lines

        if total_bet > balance:
            print("dont be dumb, you dont have enough")
        else:
            break

    print(f"You are betting £{bet} on {lines} lines. Total bet is equal to: £{total_bet}")

    slots = get_slot_machine_spin(ROWS, COLS, symbol_count)
    print_slot_machine(slots)
    winnings, winning_lines = check_winnings(slots, lines, bet, symbol_value)
    print(f"you won {winnings}!")
    print(f"you won on lines:", *winning_lines)
    return winnings - total_bet

def main():
    balance = deposit()
    while True:
        print(f"current balance is £{Fore.GREEN}{balance}{Style.RESET_ALL}")
        answer = input("Press enter to play (q to quit)")
        if answer == "q":
            break
        balance += spin(balance)
    print(f"you left with {Fore.GREEN}£{balance}{Style.RESET_ALL}.")
main()
