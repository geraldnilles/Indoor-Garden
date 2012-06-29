.DEF Reader = R17		; This Register will be used for reading the
.DEF PORTA = 0x00		; This is the PortA Register
.DEF Counter = 0x00		; This is the Timer0 Counter Register

SwitchOn:
OUT Counter, 0x00		; Clear Counter
SBI PORTA, 3			; Set the Switch Bit

OnLoop:
IN Reader, PORTA		; Read PORTA
ANDI Reader, 0b00100000		; Mask only the LED input Bit 
CPI Reader, 0b00100000		; Compare Register with LED On Mask
BREQ SwitchOff			; If LED current is High, Turn Switch Off
IN Reader, Counter  ; Read in Counter
CPI Reader, 123     ; Compare counter with maximum on time
BRGT SwitchOff      ; If counter has expired, turn switch off
JMP OnLoop          ; Otherwise, continue in loop

SwitchOff:
OUT Counter, 0x00		; Clear Counter
CBI PORTA, 3			; Clear the Switch Bit

OffLoop:
IN Reader, Counter  ; read In Counter
BRLT OffLoop        ;  If counter has not been reached, stay in this loop

OffLoop2:
IN Reader, PORTA		; Read PORTA
ANDI Reader, 0b0010000		; Mask only the LED input bit
CPI Reader, 0b0010000		; Compare to LED Current Mask
BREQ OffLoop2			; If LED Current is High, stay in this loop
JMP SwitchOn			; if LED current is low, turn the switch On

