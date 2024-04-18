from machine import Pin, Timer, ADC
import dht
 

adc = ADC(Pin(26))
adc2 = ADC(Pin(28))
adc3 = ADC(Pin(27))

sensor = dht.DHT22(Pin(22))

timer = Timer()

def blink(timer):
    try:
        sensor.measure()
    except:
        print(";(")
    temp = sensor.temperature()
    print("{}".format(temp))
    print(adc.read_u16())
    print(adc2.read_u16())
    print(adc3.read_u16())

timer.init(freq=2.5, mode=Timer.PERIODIC, callback=blink)