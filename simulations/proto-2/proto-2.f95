!  TODO Add better diode mode
!  TODO Add better VIN model that does not allow reverse current flow


program proto2
implicit none

! Simulation Variables
real,parameter :: time_step = 10e-9, time_start = .1
integer,parameter :: num_points = 300
real,parameter:: time_stop = time_start + (time_step*num_points)
real,parameter :: v_source = 170.
integer,parameter :: num_led = 50
real,parameter :: L = 1e-4, C1= 47e-6, C2= 100e-6, R_sense = 10.
real,parameter :: f_sw = 500e3, duty = 0.1
real,parameter :: f_adc = 10e3 
integer :: counter = 0
real :: max_i_d = 0

! Data Index names
type point
    real    time
    real    v_in
    real    v_c1
    real    v_c2
    real    v_out
    real    v_sense
    real    i_l
    real    i_c1
    real    i_c2
    real    i_d
    real    i_sense
    real    i_source
    real    v_gs
end type

! Create Data Point Object
type(point) :: new,old

! Set Initial COnditions
old%time = 0.
old%v_in = 170.
old%v_c1 = 0.
old%v_out = 0.
old%v_sense = 0.
old%v_c2 = 0.
old%i_c2 = 0.
old%i_l = 0.
old%i_c1 = 0.
old%i_d = 0.
old%i_sense = 0.
old%i_source = 0.
old%v_gs = 0.


! Calculation Loop
do
    ! If you have reached the stop time, exit the loop
    if (old%time .GT. time_stop) exit

    if (old%time .GT. time_start) then
        print *, old%time,old%i_l,old%i_d,old%v_gs
    end if


    ! Increament Time 
    new%time = old%time + time_step


    ! If MOSFET is conducting
    if (switch_on(new%time)) then
        new%v_gs = 5.
        ! Do First Order equations first... they use the old data
        new%i_l = old%i_l + ((old%v_in-old%v_out)/L*time_step)
        new%v_c1 = old%v_c1 + (old%i_c1/C1*time_step)
        new%v_c2 = old%v_c2 + (old%i_c2/C2*time_step)        
        ! Do the non-differential equations, the use the new data
        new%v_in = new%v_c2
        new%v_source = old%v_source
        new%i_sense = new%i_l
        new%v_sense = new%i_sense*R_sense
        new%v_out = new%v_sense + new%v_c1
        new%i_d = ILED(new%v_c1/num_led)
        new%i_c1 = new%i_l - new%i_d
        new%i_source = ILED(new%v_source - new%v_in)
        
        new%i_c2 = new%i_source - new%i_l        

    else ! If MOSFET is not conducting
        new%v_gs = 0.
        ! Do First Order equations first... they use the old data
        new%i_l = old%i_l + ((old%v_in-old%v_out)/L*time_step)
        new%v_c1 = old%v_c1 + (old%i_c1/C1*time_step)
        ! Do the non-differential equations, the use the new data
        new%v_in = old%v_in
        new%i_sense = 0.0
        new%v_sense = 0.0
        new%v_out = new%v_in + new%v_c
        new%i_d = ILED(new%v_c1/num_led)
        new%i_c1 = new%i_l - new%i_d
    end if

    old = new



end do

contains

logical function switch_on(t)
    implicit none
    real, intent(in) :: t
    real :: period, cycle_t, d
    ! Calculate Period
    period = 1.0/f_sw
    ! Calculate how far we are into the current cycle
    cycle_t = mod(t,period)
    ! Depict cycle time as a percent of period
    d = cycle_t / period
    if (d .LT. duty) then
        switch_on = .TRUE.
    else
        switch_on = .FALSE.
    end if
end function switch_on

real function ILED(v)
    implicit none
    real, intent(in) :: v
    if (v > 1.4) then
        ILED = (v-1.4)/1
    else
        ILED = 0
    end if
end function ILED

  
end program proto2
