# In a file called extensions.py, implement a program that prompts the user for the name of a file and then outputs that file’s media type if the file’s name ends, case-insensitively, in any of these suffixes:
def main():
    input_file = input("Provide file name:" ).strip().lower()
    if input_file[-4:] == ".gif":
        print("image/gif")
    elif input_file[-4:] == ".jpg" or input_file[-5:] == ".jpeg":
        print("image/jpeg")
    elif input_file[-4:] == ".png":
        print("image/png")
    elif input_file[-4:] == ".pdf":
        print("application/pdf")
    elif input_file[-4:] == ".txt":
        print("text/plain")
    elif input_file[-4:] == ".zip":
        print("application/zip")
    else:
        print("application/octet-stream")
main()
