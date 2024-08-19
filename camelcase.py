#In a file called camel.py, implement a program that prompts the user for the name of a variable in camel case and outputs the corresponding name in snake case. Assume that the user’s input will indeed be in camel case.
def camel_to_snake(name):
    snake_case = ""
    for char in name:
        if char.isupper():
            snake_case += '_' + char.lower()
        else:
            snake_case += char
    return snake_case

def main():
    camel_case_name = input("camel case: ")
    snake_case_name = camel_to_snake(camel_case_name)
    print("The snake case version is:", snake_case_name)

main()
