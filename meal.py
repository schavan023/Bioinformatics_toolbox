# Meal Time reminder program.
def main():
    time = input("Enter the time in 24-hour format (e.g., 7:30 or 13:15): ")
    hours = convert(time)

    if 7.0 <= hours <= 8.0:
        print("breakfast time")
    elif 12.0 <= hours <= 13.0:
        print("lunch time")
    elif 18.0 <= hours <= 19.0:
        print("dinner time")

def convert(time):

    hours, minutes = time.split(":")


    hours = int(hours)
    minutes = int(minutes)

    
    return hours + minutes / 60.0

if __name__ == "__main__":
    main()

