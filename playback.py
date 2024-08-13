#In a file called playback.py, implement a program in Python that prompts the user for input and then outputs that same input, replacing each space with ... (i.e., three periods).
# Receive user input.
user_input = input ("Enter your text here:")
# Add the ... for each space
print(user_input.replace(" ", "..."))
