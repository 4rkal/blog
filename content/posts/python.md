---
title: "Python for Complete Beginners"
date: 2023-03-06T20:52:42+03:00
tags:
- python
- forbeginners
---
Why you should use Python. Going over the basics of Python.

In this course/article I will be talking about why someone should use Python. Later on, I will be tackling the basics of Python. But let's start by explaining what coding is.

# What is coding?
Coding means writing instructions for computers and a finished set of instructions is known as a program. Computer programs control everything from smartphones to space rockets.

# What is Python?
Python is a text-based computer language which means it’s made up of words and symbols (such as * and = ). Its language elements and object-oriented approach are meant to assist programmers in writing clear, logical code for both small and large-scale projects.

# Why Python?
Python is one of the most popular computer languages and it’s very concise — that is, you don't need to type much in order to create programs that do a lot.

# Advantages of python
1. Simple to read, learn, and write

Python is a high-level programming language with a syntax that is similar to English. This makes the code easier to read and comprehend.

Python is really simple to pick up and understand, which is why many people suggest it to newcomers. When compared to other prominent languages like C/C++ and Java, you require fewer lines of code to accomplish the same purpose.

2. Improved Productivity

Python is an extremely useful programming language. Python’s simplicity allows developers to concentrate on solving the problem.

They don’t need to spend a lot of time learning the programming language’s syntax or behaviour. You write less code and accomplish more.

3. Free and Open-Source

Python comes under the OSI-approved open-source license. As a result, it is both free to use and distribute. You can get the source code, change it, and even share your own Python version.

4. Portability

In many languages like C/C++, you need to change your code to run the program on different platforms. With Python, however, this is not the case. You only have to write it once and it may be used wherever.

# Downloading Python
**On Linux**
You probably already know how to install it but I'm gonna show it anyways.

Open your terminal and type python or python3; if it does not work then run: (depending on your distro)
`sudo apt install python3`

**Windows 10**
1 . First check if you already have Python installed. Go to the ‘Start’ menu and click on the ‘All programs’. If you see the word “Python” it means that you already have it installed. If you don't already have it installed go to https://python.org, download the correct version for your computer and then install it.

2. Python comes in different versions. This course uses version 3 and upwards. I recommend always installing the latest version.

# What is an IDE?
IDE stands for the integrated development environment (IDE) and is software for building applications that combine common developer tools into a single Graphical User Interface (GUI).

The IDE that we will be using in this series is called VS Code.

# Downloading VS Code
Go to https://code.visualstudio.com/ and download the version that you want. Vs Code is available for Windows, Mac, and Linux. Follow the instructions on the website for installation.

# Starting in Python
It's traditional in the programming world to make the computer say ‘Hello World’ with your very first piece of code. In Python, this is very simple.

1. Open Vs Code and click on File > New File and name your file helloworld.py. The .py tells the computer that this is a Python program.
2. In your project, in VS Code type :
`print("Hello World!")`
3. Save your project and click on the run button at the top of your screen
4. If you have done everything correctly you should see a Hello World message in your terminal.

If it didn't work you should get a red error message something like this:

`SyntaxError: invalid syntax`

If that happens make sure that you have copied it exactly like above.

# Playing With numbers in Python

Python makes it easy to do maths. You just type in a question and get the answer

**Adding Up**

Open an empty project and type:

`print(2+2)`

You should see the answer:
`4`

**Subtracting(and more)**
If you want to subtract, use the ‘-’ symbol like this:

`print(2 - 2)`

To multiply use the ‘*’ symbol:

`print(2 * 2)`

To divide, use the ‘/’ symbol

`print(2 / 2)`

# Variables
A variable is like a labelled box that stores information. You can change this information but the label stays the same.

# Creating a variable:
To tell the computer what you want your variable to be, you use the = sign. This is called assigning a value to a variable. It’s very simple, here's an example using fish.

1. Open a new VS Code project and type:
`fish = 5`

Imagine a cat gets hungry and eats two fish. To create another variable for the amount eaten, write the following:

`fishEaten = 2`

Press enter and then type:

`print(fish - fishEaten)`

Save and run your code and you should get the answer:
`3`

# Input in Python
You can use the input() function to ask for information from the user.

1. Open a new VS Code project and type:

`name = input("What is your name? ")`

2. Run the program and you should get the following message:

`What is your name? `
3. Now let's try printing your name.

Add the following to your program:

`print(name)`

You have successfully created an input field!

This can be very useful in creating decision games.

# Making Decisions
To write a program that allows you to make decisions the computer needs to react differently to different answers. For this, you need conditions to compare pieces of information, and conditionals to create different paths through the program.

# What are Conditions?
A condition is a bit of code that compares two pieces of information. Conditions use operators to make these comparisons. For example, the operator == checks if two pieces of information are the same.

1. Open a new Vs Code project and type:
```
age = 10
if age == 12:
 print("True")
else:
 print("False")
```

2. Save and run and you should get False

That is because ‘age’ is set to 10 and not 12

# What are conditionals
To use a condition in your code you need a command called a condition. Conditionals use conditions. Conditions show if something is True or False.

# IF
One important condition is known as an if statement which tests whether a condition is true. If it is, the computer will follow the instructions after the if statement. If not, the computer will just skip it. In Python, if is a keyword. Dont use it as a variable name because the computer will think that it's an if statement and get confused.

# Implementing the if condition
1. Create a new VS Code project and type the following:

`user_reply = ("Do you like python? (Type yes or no) ")`

2. Then we will implement the if condition by typing the following:

```
if user_reply == "yes"
   print("Python likes you to ! ")
```

# ELIF
elif is short for else if. If the conditions of the if code isn’t met it “sweeps up” whatever is left.

3. Now type the following:
```
elif user_reply == "maybe":
  print("Make up your mind!")
```

# ELSE
When conditions for the if and elif code arent met, else goes into action and “sweeps up” whatever is left.

Let's implement that:
4. Now type the following:
```
else:
  print("Well python doesn't like you either")
```
The complete code should look something like this:

```
user_reply = ("Do you like python? (Type yes or no) ")
if user_reply == "yes"
   print("Python likes you to ! ")
elif user_reply == "maybe":
  print("Make up your mind!")
else:
  print("Well python doesn't like you either")
```

**Don't forget to press the tab after if statements.**

# Randomness in python
In python we can use the random function in order to generate random numbers. This can be extremely useful in a variety of things.

The first thing we will have to do is import the random function

`import random`

After that we can print out a random number with the following

`print(random.randint(1,10))`

This will output a random number from 1–10

randint stands for random integer.

Here is the full code.

```
import random
print(random.randint(1,10))
```

# Loops in python
There are two types of loops in python

1. While loop
2. For loop

While loops only stop when something changes. If it doesn't change they could go on forever.

With for loops on the other hand you can define exactly when you want them to stop

The most popular example of a while loop is

`while True:`

Which will run forever eg

```
while True:
    print("hi")
```

This will run forever.

With while loops on the other hand you can define exactly how many times you want the loop to run.

```
for x in range(0,10):
   print("Hi")
```
This will print Hi exactly 10 times

# Guessing game
Now lets combine what learned from above and from our previous articles to create a game

The computer will select a random number from 1–10 and you will have to guess it.

The first thing we will have to do is

`import random`

After that we will create a variable called number

`number = random.randint(1,10)`

After that we will create another variable called your_guess

`your_guess = int(input("Im thinking of a number from 1 to 10, can you guess which one?"))`

We are using int as you will have to enter a number

Now we will create a while loop that will keep the game running until you guess the number

`while your_guess != number:`

The code so far is

```
import random
number = random.randint(1,10)
your_guess = int(input("Im thinking of a number from 1 to 10, can you guess which one?"))
while your_guess != number:
    if your_guess < number:
        print("Your number was too low")
    else:
        print("You number was to high")
```
And the following

`print("GG you found it")`

You code should now look like this

```
import random
number = random.randint(1,10)
your_guess = int(input("Im thinking of a number from 1 to 10, can you guess which one?"))
while your_guess != number:
    if your_guess < number:
        print("Your number was too low")
    else:
        print("You number was to high")
    your_guess = int(input("Please try again... "))
print("GG you found it")
```
**Thats it for now**

Stay tuned for more

**If you enjoyed this article please consider supporting me**

Monero:
`8AztDJtwb7iKaqP4KXRG39VibAacCY1mMfH3bNsVjhYMYbohtT5LKoTSRP6vJGtjeBSPEpFdHZx3ZL3iVowYdkqeQwPAG2o`
