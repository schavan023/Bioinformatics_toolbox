# shorten the input by removing vovwel
def main():
    user_text = input("Enter a string of text: ")
    result = shorten(user_text)
    print("Output without vowels:", result)

def shorten(word):
    vowels = "aeiouAEIOU"
    no_vowels_text = ''.join([char for char in word if char not in vowels])
    return no_vowels_text

if __name__ == "__main__":
    main()
