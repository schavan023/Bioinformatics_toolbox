# Coke dispensing problemset
def main():
    # Initialize the amount due.
    amount_due = 50

    # Continue accepting coins until the amount due is zero or less.
    while amount_due > 0:
        print(f"Amount Due: {amount_due}")

        # Prompt the user to insert a coin.
        coin = int(input("Insert coin: "))

        # Check if the coin is a valid denomination.
        if coin in [25, 10, 5]:
            amount_due -= coin

    # Calculate and output the change owed if any.
    change_owed = -amount_due
    print(f"Change Owed: {change_owed}")

if __name__ == "__main__":
    main()
