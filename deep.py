# In deep.py, implement a program that prompts the user for the answer to the Great Question of Life, the Universe and Everything, outputting Yes if the user inputs 42 or (case-insensitively) forty-two or forty two. Otherwise output No.
def main():
    user_answer = input("What is the answer to the Great Question of Life, the Universe, and Everything?").strip().lower()
    if user_answer == "42" or user_answer == "forty-two" or user_answer == "forty two":
	    print("Yes")
    else:
        print("No")

main()
