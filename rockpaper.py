import random
from time import sleep

PLAYER_SCORE = 0
CPU_SCORE = 0



def game():
    global PLAYER_SCORE
    global CPU_SCORE
    
    choices = ["rock", "paper", "scissors"]
    player_choice = input("rock, paper or scissor? ")
    
    while player_choice not in choices:
        print("maybe choose a correct option; if you have enough braincells obviously\n")
        player_choice = input("rock, paper or scissor? ")
        
    print(f"cpu chooses...\n")
    cpu_choice = random.choice(choices)
    sleep(2)
    print(f"{cpu_choice}\n")
    sleep(1)

    if player_choice == cpu_choice:
        print("its a draw")
    
    elif player_choice == "rock":
        if cpu_choice == "paper":
            print("haha you lose\n")
            CPU_SCORE += 1
        elif cpu_choice == "scissors":
            print("lucky guess, you win\n")
            PLAYER_SCORE +=1
            
    elif player_choice == "paper":
        if cpu_choice == "scissors":
            print("haha you lose\n")
            CPU_SCORE += 1
        elif cpu_choice == "rock":
            print("lucky guess, you win\n")
            PLAYER_SCORE +=1
            
    elif player_choice == "scissors":
        if cpu_choice == "rock":
            print("haha you lose\n")
            CPU_SCORE += 1
            
        elif cpu_choice == "paper":
            print("lucky guess, you win\n")
            PLAYER_SCORE +=1
    again()
            
def again():
    print(f"score is currently: You: {PLAYER_SCORE} - cpu: {CPU_SCORE}")
    
    play_again = input("play again? ")
    while play_again != "yes":
        
        if play_again.lower() == "no":
            print("ok see ya")
            exit()
        else:
            print('feeling a little dumb? (it\'s "yes" or "no"...)')
            play_again = input("play again? ")
    game()
    
    
game()
    
    


