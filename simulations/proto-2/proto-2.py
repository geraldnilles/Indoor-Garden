#!/usr/bin/env python

## THis is a python script that will simulate my LED buck converter

# Globals
time_step = 100e-9
time_start =  5 ## Time when recording starts
time_stop =  time_start + time_step*100 ## Time when recording stops
num_save_points = 1000
v_source=170
v_led = 2 ## Forward voltage of LED
i_led = 0.02 ## Target Current of LEDs
num_led = 50
L = 1e-4
C = 47e-6
R_sense = 10
f_sw = 50e3
duty = 0.1
f_adc = 10e3

# Simulation Data will be stored here
data = []

####
## Functions
####

# Returns the LED current given its voltage
def ILED(v):
    if v < 1:
        return 0
    else:
        return (v-1)/(10)

# Returns the MOSFET state given the time
def switch_on(t):
    # Caclulate the period
    period = 1.0/f_sw
    # Calculate how far into the period using the mod operator
    cycle_t = t%period
    # Represent that cycle_t as a percentage of the period
    d = cycle_t/period
    if d < duty:
        return True
    else: 
        return False


# Set initial conditions
old = { "time":0.0,
        "v_in":v_source,
        "v_c":0,
        "v_out":0.0,
        "v_sense":0,
        "i_l":0.0,
        "i_c":0.0,
        "i_d":0.0,
        "i_sense":0.0,
        "v_gs":0}

count = 0
while old["time"] < time_stop:
    if old["time"] >= time_start and len(data) < num_save_points:
        data.append(old.copy())

    new = {}
    new["time"] = old["time"] + time_step

    if switch_on(new["time"]): # MOSFET Closed
        new["v_gs"] = 5
        # Do Cap and Inductor Equations first... they use previous data
        new["i_l"] = old["i_l"] + (((old["v_in"]-old["v_out"])*time_step)/L)*time_step
        new["v_c"] = old["v_c"] + (old["i_c"]/C)*time_step
        # Do R and D equations next... the use current data
        new["v_in"] = old["v_in"]
        new["i_sense"]=new["i_l"]
        new["v_sense"]=new["i_sense"]*R_sense
        new["v_out"] = new["v_sense"] + new["v_c"]
        new["i_d"] = ILED(new["v_c"]/num_led)
        new["i_c"] = new["i_l"]-new["i_d"]
        
    else: # MOSFET Open
        new["v_gs"] = 0
        # Cap and Inductor Equations first... they use previous data
        new["i_l"] = old["i_l"] + (((old["v_in"]-old["v_out"])*time_step)/L)*time_step
        new["v_c"] = old["v_c"]+(old["i_c"]/C)*time_step
        # Do R and D equations next... the use current data
        new["v_in"] = old["v_in"]
        new["i_sense"]=0
        new["v_sense"]=0
        new["v_out"] = new["v_in"]+new["v_c"]
        new["i_d"] = ILED(new["v_c"]/num_led)
        new["i_c"] = new["i_l"]-new["i_d"]

    old = new

    count += 1
    if count == 100000:
        print new["time"],new["i_d"]
        count = 0;


# Print Vout and I_l  Max/Min/Avg
vout = {}
il = {}
for p in data:
    
