
# Circuits

Various circuits are contained in this folder.

# Proto 1
This circuit is a quick-and-dirty proof-of-concept.
It is not the cheapest option, but it is the easiest.

It uses a linear regulator to regulate the LED current.
This is not very power efficient, but it is easy

# Proto 2

This circuit powers the LEDs using an inverted buck converter.

## Buck
Normally, there cannot be direct feedback with this type of circuit.
However, I have added a "charge trap" at the ADC input.
When the switch is on, the trap is open and lets current charge the ADC input capacitor.
When the switch is off, the trap shuts and locks the voltage in the capacitor.
THis circuit allows us to switch the buck at a faster frequency than the ADC frequency.

THis allows us to use fewer/cheaper parts while maintaining a strong feedback algorithm.
A SImulation should be done for this system

## Charge Pump

Additionally, a voltage doubling charge pump will be needed.
This will provide a high enough voltage for the NFET to fully close.
We can likely use one of the GPIOs to pump charge.

## Capacitive Water Level Sensor
This circuit will sense the capacitance of our capacity water sensor.
My implementation uses 1 GPIO and has yet to be tested.

Here is my plan on how the circuit will work.
1. The GPIO acts as an output and charges the capacitor to 5V.  Since there is no series resistance, this should charge quickly.
2. The GPIO switches from and output to a high-z input. A software timer is started in the MCU.
3. At this point, the capacitor will still be charge to 5V and the voltage will begin to decay through the 1M pull down resistor.
4. After several microseconds, the capacitor voltage will be low enough for the GPIO input to register as a Low and trigger an interrupt.
5. In this interrupt routine, the software timer will be read.  Based on how long it took for the capacitor to decay, the capacitance (and water level) can be determined.

The charge and discharge times will not be absolute.
The humidity and temperature will vary day-to-day which will change the permeability of the air.

I think the best way to treat this is by looking at change in capacitance.  As
the capacitor charges, the software will see the decay timer tick longer.  Once
the time stops increasing, we know the entire sensor is submerged and the pump
can be turned off. The same method can be used when the water is draining. 


