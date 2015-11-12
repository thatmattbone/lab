import serial # if you have not already done so

RED_SOLID = 'n'
YELLOW_FADING = 'm'
GREEN_SOLID = 'l'

ser = serial.Serial('/dev/ttyACM0', 9600)

def red_solid():
    ser.write(RED_SOLID)

def yellow_fading():
    ser.write(YELLOW_FADING)

def green_solid():
    ser.write(GREEN_SOLID)

if __name__ == "__main__":
    pass
    #ser.write('n')
