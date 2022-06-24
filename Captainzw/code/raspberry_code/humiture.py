#!/usr/bin/env python
import adafruit_dht
import os
import time
Sensor = 11
humiture = 17
cmd='pkill -f libgpiod'
os.system(cmd)
dht_device=adafruit_dht.DHT11(humiture)
def getres():
	res=['52','27']
	try:
		try:
			humidity= dht_device.humidity
			temperature=dht_device.temperature
			res=[humidity,temperature]
			print ('Temp={0:0.1f}*C  Humidity={1:0.1f}%'.format(temperature, humidity))
		except RuntimeError as err:
			res=['52','27']
			print (err)
		except RuntimeError as err:
			res=['52','27']
			dht_device.exit()
			raise error
	except:
		dht_device.exit()
		res=['52','27']
	return res