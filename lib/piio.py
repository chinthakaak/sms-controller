__author__ = 'ka40215'
from random import randint
import serial
# import wiringpi2 as wpi

def read():
    # Comment this line for actual integration
    return __getDummyData()

    # Uncomment this line for actual integration
    #return __getSensorData()

def __getSensorData():
    ser = serial.Serial('/dev/ttyUSB4', 9600)
    output = ser.readline()
    output = output.strip()
    ser.close()
    return output

def __getDummyData():
    return `randint(0,10)`+','+`randint(0,10)`+','+`randint(0,10)`+','+`randint(0,10)`+','+`randint(0,10)`+','+`randint(0,10)`+','+`randint(1,3)`

def write(percentageRPM):
    dout=int((1023.0/100)*percentageRPM)

    # Comment this line for actual integration
    __setDummyPWM(dout)

    # Uncomment this line for actual integration
    #__setPWM(dout)


# def __setPWM(dout):
#     wpi.wiringPiSetupGpio()
#     wpi.pinMode(18,2)
#     wpi.pwmWrite(18,int(dout))

def __setDummyPWM(dout):
    print 'digital output in gpio : ', dout