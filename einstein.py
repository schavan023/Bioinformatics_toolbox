# E = mc2 problem set
def cal_energy(mass, speed_light):
    return mass*speed_light**2

def main():
    speed_light = 300000000
    mass= int(input("Enter value for mass m:"))
    energy = cal_energy(mass,speed_light)
    print(f"{energy}")


main()

