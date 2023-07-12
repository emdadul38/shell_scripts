# Shell Scripts

Shell scripting is an integral part of process automation in Linux. Scripting helps you write a sequence of commands in a file and then execute them.

This saves you time because you don't have to write certain commands again and again. You can perform daily tasks efficiently and even schedule them for automatic execution.

## What is Shell
A Shell provides you with an interface to the Unix system. It gathers input from you and executes programs based on that input. When a program finishes executing, it displays that program's output.

Shell is an environment where we can run our commands, programs, and shell scripts. There are different flavors of a shell, just as there are different flavors of operating systems. Each flavor of shell has its own set of recognized commands and functions.

## How Do You Identify a Bash Script?

File extension of .sh.
By naming conventions, bash scripts end with a test.sh. However, bash scripts can run perfectly fine without the sh extension.

Write the command.
```
#! /usr/bin/bash
echo "Hello World"
```
Provide execution rights to the user, and Modify the file permissions and allow execution of the script by using the command bellow

```
chmod +x test.sh
```

Run the script 

```
./test.sh
```

## How to define variables

We can define a variable by using the syntax variable_name=value. To get the value of the variable, add $ before the variable.

```
#!/bin/bash
# A simple variable example
greeting=Hello
name=Emdad
echo $greeting $name
```

## How to read user input
Sometimes you'll need to gather user input and perform relevant operations.

In bash, we can take user input using the read command.
```
read variable_name
```
