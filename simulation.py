#!/usr/bin/env python

## THis is a python script that will simulate my LED buck converter

# Globals
time_step = 100e-9
time_start =  0.0 ## Time when recording starts
time_stop =  5 ## Time when recording stops
num_save_points = 1000
v_source=170
v_led = 2 ## Forward voltage of LED
i_led = 0.02 ## Target Current of LEDs
num_led = 50
L = 1e-3
C = 47e-6

# Simulation Data will be stored here
data = []

print L,C,time_step

# Set initial conditions
old = {"time":0.0,"v_in":170.0,"v_out":0.0,"i_l":0.0,"i_c":0.0,"i_out":0.0}
new = {}

## Calculate the number of cycles between saves
max_count = ((time_stop-time_start)/num_save_points)/time_step
print max_count
count = 0
rising = True

while old["time"] < time_stop:
	if(old["time"] > time_start and count > max_count):
		data.append(old)
		count = 0
##		print old["time"],old["v_out"],old["i_out"]
	new["time"] = old["time"] + time_step
	new["v_in"] = old["v_in"]
	new["i_l"] = old["i_l"] + (((old["v_in"]-old["v_out"])*time_step)/L)
	new["v_out"] = old["v_out"] + ((old["i_c"]*time_step)/C)
	new["i_out"] = new["v_out"]/(5000)	
	new["i_c"] = new["i_l"]-new["i_out"]

	if old["v_out"] > new["v_out"]: # Curve is falling
		if rising: ## If the last pulse was rising
			print "Max Reached at ", new["v_out"]
		rising = False
	else:
		rising = True
		

	old = new.copy()
	count += 1

print data
print len(data)

