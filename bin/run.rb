require_relative '../config/environment'
require 'pry'

def welcome
    logo = "
     ____  _____  ______        _          ___               _          
    |_   \\|_   _||_   _ \\      / \\       .'   `.            (_)         
      |   \\ | |    | |_) |    / _ \\     /  .-.  \\  __   _   __   ____   
      | |\\ \\| |    |  __'.   / ___ \\    | |   | | [  | | | [  | [_   ]  
     _| |_\\   |_  _| |__) |_/ /   \\ \\_  \\  `-'  \\_ | \\_/ |, | |  .' /_  
    |_____|\\____||_______/|____| |____|  `.___.\\__|'.__.'_/[___][_____] "
    puts logo
    $score_out_of_ten = 0
    puts "===================================================================================================="
    puts "Welcome top the NBA Quiz!!!!"
end
def get_input
    puts "1. Login"
    puts "2. Create Account"
    puts "3. Delete Account"
    puts "Please enter 1, 2, or 3."
    input = gets.chomp.to_i
    if input == 1
        login
    elsif input == 2
        create_account
    elsif input == 3
        delete_account
    else 
        get_input
    end
end
def login
    puts "Please enter your name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        current = User.find_by(name: name)
        $logged_in = current.id
    else
        puts "That user does not exist"
        create_account
    end
end
def create_account
    puts "To create an account, please enter your name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        puts "Sorry that name is taken."
        create_account
    else
        User.create(name: name)
        puts "Thanks for creating an account."
        current = User.find_by(name: name)
        $logged_in = current.id
    end
end
def delete_account
    puts "Enter your account name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        User.find_by(name: name).destroy
        puts "Your account has been deleted. We hope to see you again!"
        get_input
    else
        puts "That user does not exist."
        get_input
    end
end
def log
    puts "==================================================="
    puts "Use control + c to exit game at any time."
    puts "Instructions: Enter the answer you think is correct."
    puts "==================================================="
end
def question1
    question = Question.find(1)
    puts question.question
    puts answers1[0].answer
    puts answers1[1].answer
    puts answers1[2].answer
    puts answers1[3].answer
    puts "==================================================="
    input = gets.chomp.to_s
end
def answers1
    Answer.where("question_id = '1'")
end
def run
    welcome
    get_input
    log
    question1
end

run
