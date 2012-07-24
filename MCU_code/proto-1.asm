.DEF PORTA = 0x00 	; Set PORTA as the portA address
.DEF Counter = R17	; Assign Counter to R17
.DEF CountTo = R18	; Assign Count To Value to R18
.DEF OnTime = 60    ; 
.DEF OffTime = 250  ;

.CSEG               ; Code-Segment starts here
.ORG 0000           ; Address is zero
RJMP Start          ; The reset-vector on Address 0000
RETI               ; 0001: first Int-Vektor, INT0 service routine, SInce its not used, do the RETI command
...

Start:
SetCounter:		; This section will set up a 1 second time clock

; Select a 1 second clock
; Enable Counter Interrupt
; Start Counter

MainLoop:
LDI CountTo OnTime  ; Load the CountTo register with the On TIme
RCALL TurnOn         ; Turn On the GPIO
RCALL MySleep       ; Call Sleep Subroutine
LDI CountTo OffTime ; Load the CountTo Register with the Off Time
RCALL TurnOff        ; Turn Off the GPIO
RCALL MySleep       ; Call the sleep Subroutine
RJMP MainLoop       ; Return to the beginning

MySleep:
LDI Counter 0       ; Initialize the counter
CMP CountTo Counter ; Compare Counter and CountTo
BRGT -2             ; If the counter is less, jump back to the Compare function
RET                 ; Else, Return from the sleep function

; THis interrupt will be called every second
IntCOMPA:
IN R16,SREG         ; read status register
PUSH R16            ; and put on stack
INC Counter         ; Increment the Counter Register
POP R16             ; get previous flag register from stack
OUT SREG,R16        ; restore old status
RETI                ; and return from int


TurnOff:
SETI PORTA 0x00
RET

TurnOn:
SETI PORTA 0xFF
RET


