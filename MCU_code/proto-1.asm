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
; Put Device to sleep
RJMP Loop


Interrupt:		; THis interrupt will be called every second
; Compare Counter and CountTo
; if Counter > CountTo
; Toggle PortA
;




