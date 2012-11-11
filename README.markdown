# Indoor Garden

This goal of this is to create a very inexpensive aeroponic gardening system.

# Basic Concept
I decied to do a "Flood and Drain" method for feeding the plants.
THis is kind of a fusion of Aeroponics and Hydroponics.

Traditional Aeroponics was designed to work in space.
THerefore, it uses spray nossels to spray the roots with the nutrient solution.
This spraying method oxygenates the water and improves the growing rate.
Unfortunately, spray nossels require a high-pressure pump that is expensive.
It also has a higher failure rate.

Traditional Hydroponics trickle a constant stream of water over the roots.
This can use a low pressure pump and is cheap.  
However, many plants cant handle being constantly underwater.
It also does not provide the same levels of oxygen to the roots.

With the "Flood and Drain" method, i will floot the roots to submerge them.
THen i will drain the roots to expose them to Air.
This will let me grow the same types of plains Aeroponics does with higher oxygen levels while using a cheaper/more reliable low-power pump.

# Basic Design

## Container
The whole system will be contained inside 2 styrofoam coolers stacked to create a large cavity.
I chose these for many reasons.

First, they are cheap.
Styrofoam coolers are about $1 at a hardware store.  

Second, they are durable.
Styrofoam is based on petrolium so it will not break down in the presence of water.

Third, they are waterproof.
A styrofoam cooler will easily hold water without leaking.

Firth, They are highly reflective.
Any light hitting the walls of the cooler will be reflected back.
THis will minimize the amount of wasted light from the LEDs.

## Planter
The planter holds all of the plants in place.
In this case, it will also need to hold water.

My planter will be a ring of PVC piping.  Probably 4 to 6 in diameter.
THere will be large holes cut into the side of the ring.
In each hole, i will place a Solo cup with holes punched in it.
THis will hold each plan while allowing the roots get access to the solution.

4 or 5 small holes will be drilled into the other side of the ring.
These holes will let the water drain into the bottom of the container.
Rather than having 2 separate pumps (1 for draining and 1 for flooding), these holes will constantly drain.
In order to "Flood", we simply need a pump that can fill the ring faster than these holes can drain it.

The Water Level will be monitored using a water level sensor. 
More on that later.

## Pump
THe pump will be a low-power (~ 10 Gallons per minute) fountain pump.
There is a wide array of pumps on Amazon for as low as $7.

THis pump will set at the bottom of the container and will pump the solution into the planter ring during the flood phase.

## LEDs
The top of the container will be lined with ~50 LEDs.
THese LEDs will be mostly Red LEDs, some Orange LEDs, and a few Blue LEDs.
The exact ratio is TBD.

These colors were chosen to maximize photosynthesis.

## Nutrient Solution
The solution will sit at the bottom of the container.
This resovior will also be filled with fish.
These fish will eat various leftovers and other fish-food, break it down, and provie the plants with the nutrients they need.

I will be completely guessing when it comes to the amount of fish, type of fish, and fish diet.
There will be very experimental.
If it works out, it will be great since Aeroponic nutrient solution is expensive.  

## Water Level Sensor
Inside the ring will be a water level sensor.
THis sensor will let the MCU know when the ring is either full or empty.

There will be a hollow cylendar with a ping-pong ball in the middle.
The ping-pong ball will push a piston up with the water level.
There will be 2 gold-plated contacts on the top of the ring.  
When the piston touches these contacts, the circuit will be compelted and the MCU will know to switch modes. 

## Control
The Pump will be controlled uisng a simple 8bit Atmel MCU.
THis MCU will determine whether or not the pump is on.

It will use the Waterlevel sensor allong with a watchdog timer in order to toggle the pump relay.
 
