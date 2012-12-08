
# Scaling

If this ends up working well, it is important the the design be scalable.
I want to be able to fill an entire garage or basement full of plants and be able to maintain them.

# Sharing Components

I think it is important that the pods remain separate.
If there is contamination or a pump failure, the damage will be isolated to a single pod rather than the entire room.

# Communication

If you have tens or hundreds of pods, communication with each pod is important.
If each pod could report a pump failure, or water shortage, or LED failure, it would make it easier to maintain a garden.

## Connection
The pods will be daisy chained using telephone or ethernet cables (whatever is cheaper).
Each pod will have 2 ports: An In port and an Out port.
The chain of pods will use a special "ping-pong" protocol to communicate.

There will be 1 master node that will be connected to the computer.
This will initiate all communications.

## Ping-Pong Protocol

This is a new protocol used to communicate with a chain of similar pods

     ----------       -------------       -----       -----
    | Computer |=====| Master Node |=====| Pod |=====| Pod |
     ----------       -------------       -----       -----

The Master node will send a data packet.
The header of the packet contains the pod number.
This number represents the distance (number of pods) between the target pod and the master pod.
Each time a pod receives a packet, it reads the header.  
If the header number == 1, the Pod analyses the data packet and prepares the desired response package.
If the header number is higher than 1, the number is decremented by 1 and the package is forwarded to the next pot in the chain.

This header-subtraction method will allow the number of pods to grow without limit.

The last pod will have a "Termination Bit" to let it know that its the last pod.
If a packet tries to go past the termination pod, it will return an error

### Structure

* 8 Bits - Pod Number
    * This number is used to select the pod.
    * THis is the distance from the Master node
* 8 Bits - Command
    * Ping
    * OK
    * Error - LED Failure
    * Error - Pump Failure
    * Error - Water Level Low
    * Error - Water Level High
    * Error - Misc
    * Start Pumps
    * Stop Pumps
    * Start LEDs
    * Stop LEDs

