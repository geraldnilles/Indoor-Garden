
# Water Level Sensor

# Possible Solutions

## Lever Switch
This solution is currently used by your toilet.  
When the tank is full, it pushes up a hollow ball and closes a valve.
THis would be similar to that, except it will close a circuit.

Whiile this solution is coneptually simple, it is fairly difficult to build by hand.
You will need a lever that pivots.and connects 2 metal contacts.

Also, this solution only tells you when the tank is full.  THat is it.


## Floating Ball Switch
With this soluton, a ball will be in a tube.  The ball will be covered ina conductive material.  When the ball reaches the top or bottom of the container, it will close the switch.

This adds another data point "Completely Empty" which give the MCU more visibility.

However, it is also mechanically difficult.  Asside from building the tube, you will also have to worry about the contuctive ball corroding.


## Capacitive Sensor
Place 2 parallel strips of metal vertially in the container.
THe capacitance between the 2 metal strips will be measured using the MCU.
As the water level rises, the relative permiability of the material between the plates will increase from 1 (air) to 80 (water).i
This will change the capacitance of the parallel plate and will be detectable by the MCU.
This change in capacitance should be detectable

If two 3cm by 8cm plates are used and ar separated by 0.5cm, the air capacitance will be about 5pF and the water capacitnce will be about 400pF.
Considering the MCU pins are about 5pF, this amount of capacitance should be detectable. 

### Pros and Cons

Pros
* Easy to implement
* Reliable (no moving parts)
* Linear sensor (not binary)
Cons
* Difficult concept
* Relatively Complex MCU code
* Not sure how permiability will change as nutrients are added to the water.

### Detection Algorithm

This sensor could potentially use 1 GPIO and 1 Resistor.

First, the GPIO will output high (5V) and charge the capacitor.
Next, it will change to a high-z Input and count how many clock cycles are required before the input switches from 1 to 0.

The exernal resistor will be used as a more accurate pull down resistance.  
It will probably be aroudn 1MOhm

### Capacitor Design
C = Er * E0 * A / d

If the plates are 3cm by 10cm and separated by 0.5cm, the capacitor will be about 5.3 pF.

Holding the parallel plates close without touching may be difficult.  
I am thinkikng about using plastic screws and spacers to mainain the distance.

