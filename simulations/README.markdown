
# Simulations

This section will run simulations on our circuits to see how they will work.
Most of these simulations are for the power electronics (Bucks and BOosts).

## Language
My simulations will be done using Fortran 95.
Fortran is light weight computer language used a lot fo numerical simulations.

In general, it should run a lot faster than Python or other similar scripting language.

## Simulation Topology

These simulations will use a state machine method.
We will solve the 1st order equations first based on the previous data point.
We will thens olve the rest of the equations based on the curretn data point.

For example, the equation for an inductor is `V = L di/dt`.
So to calculate the inductor current we will use this equation:

    I(new) = I(old) + (V(old)/L)*time_step

A similar equation will be used for the capacitor.

All of the other circuits, LED, Diodes, Resistors and not time-variant so we will just solve them using the latest data.

## Future Improvements

### LED Model
Currently, the LED is modeled as a 15 ohm resistor.
We will want to change this to the exponential diode equation, eventually.
THere is a function for the LED so this should be easy to fix

### Voltage Source
CUrrently, the input voltage source is an ideal voltage source.
THe problem with this is current can flow backwads into the current source.
Since we will be using a diode bridge, this is not possible.

I think the best way to model this is by an ideal souce, a diode, and a capacitor.  
This will allow the inductor to enter DCM mode without crazy voltage spikes.

We can just use an ideal diode for these (perhaps with a 1.4V VF to mimic the 2 didoe in the bridge)

### Diode Switch
Currently, the high side switch is an ideal diode.  Lets make it a real diode.
