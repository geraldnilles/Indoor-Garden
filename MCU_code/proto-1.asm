.DEF PORTA = 0x00 	; Set PORTA as the portA address
.DEF Counter = R17	; Assign Counter to R17
.DEF CountTo = R18	; Assign Count To Value to R18
.DEF OnTime = 60
.DEF OffTime = 255

SetCounter:		; This section will set up a 1 second time clock

; Select a 1 second clock
; Enable Counter Interrupt
; Start Counter

Loop:
SLEEP
RJMP Loop


Interrupt:		      ; THis interrupt will be called every second
CLEAR CountReg      ; Clear the HW Counter Register
ADD Counter 1       ; Add to slow counter
CMP Counter CountTo ; Compare Counter to Count-To Value
BRGT Toggle         ; If Counter is Greater, Jump to Toggle Routine
RETURN              ; Else Return

Toggle:
CLEAR Counter
CMPI CountTo OnTime ; See which count-to expired
BREQ TurnOff
RJMP TurnOn

TurnOff:
SETI PORTA 0x00
SETI CountTo OffTime
RETURN

TurnOn:
SETI PORTA 0xFF
SETI CountTo OnTime
RETURN



