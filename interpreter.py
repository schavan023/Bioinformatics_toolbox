"""
Python already supports math, whereby you can write code to add, subtract, multiply, or divide values and even variables. But let’s write a program that enables users to do math, even without knowing Python.

In a file called interpreter.py, implement a program that prompts the user for an arithmetic expression and then calculates and outputs the result as a floating-point value formatted to one decimal place. Assume that the user’s input will be formatted as x y z, with one space between x and y and one space between y and z, wherein:

x is an integer
y is +, -, *, or /
z is an integer
For instance, if the user inputs 1 + 1, your program should output 2.0. Assume that, if y is /, then z will not be 0.
"""
# Create the interpreter math problem set.
def evaluate_expression(expression):
    x, y, z = expression.split()
    x = int(x)
    z = int(z)

    # Evaluate the expression using only conditionals and print the result immediately
    if y == '+':
        print(f"{x + z:.1f}")
    elif y == '-':
        print(f"{x - z:.1f}")
    elif y == '*':
        print(f"{x * z:.1f}")
    elif y == '/':
        print(f"{x / z:.1f}")
    else:
        print("Invalid operator")

def main():
    # Get the input from the user
    expression = input("Enter an arithmetic expression (x y z): ")
    # Call the function to evaluate the expression
    evaluate_expression(expression)

# Call the main function to start the program
main()
