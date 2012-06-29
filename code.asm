.DEF Reader = R17		; This Register will be used for reading the
.DEF PORTA = 0x00		; This is the PortA Register
.DEF Counter = 0x00		; This is the Timer0 Counter Register

SwitchOn:
OUT PORTA, Zeroes		; Clear Counter
SBI PORTA, 3			; Set the Switch Bit
OnLoop:
IN Reader, PORTA		; Read PORTA
ANDI Reader, 0b00100000		; Mask only the LED input Bit 
CPI Reader, 0b00100000		; Compare Register with LED On Mask
BREQ SwOnLEDHi			; If LED current is High, jump to high routine
RJMP SwOnLEDLo			; If LED current is low, jump to low routine

SwitchOff:
OUT PORTA, Zeroes		; Clear Counter
CBI PORTA, 3			; Clear the Switch Bit

OffLoop:
IN Reader, PORTA		; Read PORTA
ANDI Reader, 0b0010000		; Mask only the LED input bit
CPI Reader, 0b0010000		; Compare to LED Current Mask
BREQ SwOffLEDHi			; If LED Current is High, jump to High routine
JMP SwOffLEDLo			; if LED current is low, jump to Low Routin

SwOnLEDHi:
IN Reader, Counter 		; Read Counter Register
CPI Reader, MIN_ON_TIME		; Compare to Minimum Switch On Time
BRGE SwitchOff			; If Greater, Turn the Switch off
JMP OnLoop			; Else Continue with the On Loop

SwOnLEDLo:
IN Reader, Counter		; Read Counter Register
CPI Reader, MAX_ON_TIME		; Compare to Maximum Switch On Time
BRGE SwitchOff			; If Greater, Turn the switch off
JMP OnLoop			; Else Continue with the On Loop

SwOffLEDHi:
IN Reader, Counter		; Reader Counter
CPI Reader, MAX_OFF_TIME	; Compare with Maximum Off Time
BRGE SwitchOn			; If Greater, Turn switch On
JMP OffLoop			; Else, Stay in Off mode

SwOffLEDLo:
IN Reader, Counter		; Read Counter
CPI Reader, MIN_OFF_TIME	; Compare with Minimum Off Time
BRGE SwitchOn			; If Greater, Turn switch On
JMP OffLoop			; Else, Stay in Off mode

Can i edit this?

