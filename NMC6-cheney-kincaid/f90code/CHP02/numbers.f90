!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 2.1
!
! File: numbers.f90
!
! Print hexadecimal and octal internal machine representation
! of various numbers
!
! Compile routines hex.f90 and oct.90 with the commands:
! f90 -c hex.f90
! f90 -c oct.f90
!
! An object files "hex.o" and "oct.o" will be created.
! Next, compile the main program "numbers.f90" and load the objects files
! with the command:
!
! f90 numbers.f90 hex.o oct.o
!
      real :: x
    
      x = -52.234375
      print *,x
      call oct(x)
    call hex(x)

      x = 7112.
      print *,x
      call oct(x)
    call hex(x)

      x = -185./262144.
      print *,x
      call oct(x)
    call hex(x)

      x = 1375396./8**7
      print *,x
      call oct(x)
    call hex(x)
      x = 105364./8**8
      print *,x
      call oct(x)
    call hex(x)
      x = -212570./8**6
      print *,x
      call oct(x)
    call hex(x)
      x = -9992892
      print *,x
      call oct(x)
    call hex(x)
      x = -48937.
      print *,x
      call oct(x)
    call hex(x)
      x = -48937.*2**6
      print *,x
      call oct(x)
    call hex(x)
      x = -34215.
      print *,x
      call oct(x)
    call hex(x)
      x = -34215.*2**8
      print *,x
      call oct(x)
    call hex(x)
      x = 850282.
      print *,x
      call oct(x)
    call hex(x)
      x = 850282./2**(4)
      print *,x
      call oct(x)
    call hex(x)
      x = 9992892.
      print *,x
      call oct(x)
    call hex(x)
      x = -9992892./2.
      print *,x
      call oct(x)
    call hex(x)
      x  = 2595.
      print *,x
      call oct(x)
    call hex(x)
      x  = 2595.*2**7
      print *,x
      call oct(x)
    call hex(x)
      x = 3591.
      print *,x
      call oct(x)
    call hex(x)
      x = 3591./2**(2)
      print *,x
      call oct(x)
    call hex(x)
      x = -3390.
      print *,x
      call oct(x)
    call hex(x)
      x = -3390.**2**2
      print *,x
      call oct(x)
    call hex(x)
      x = 255.
      print *,x
      call oct(x)
    call hex(x)
      x = 255.*2**(6)
      print *,x
      call oct(x)
    call hex(x)
      x = (1.-2**(24))
      print *,x
      call oct(x)
    call hex(x)
      x = 0.125
      print *,x
      call oct(x)
    call hex(x)
      x = -0.125
      print *,x
      call oct(x)
    call hex(x)
      x = 0.5
      print *,x
      call oct(x)
    call hex(x)
      x = -0.5
      print *,x
      call oct(x)
    call hex(x)

      x = 1.
      print *,x
      call oct(x)
    call hex(x)

      x = -1.
      print *,x
      call oct(x)
    call hex(x)

      x = -0.
      print *,x
      call oct(x)
    call hex(x)

      x = 0.234375
      print *,x
      call oct(x)
    call hex(x)

      x = 492.78125
      print *,x
      call oct(x)
    call hex(x)

      x = 64.37109375
      print *,x
      call oct(x)
    call hex(x)

      x = -285.75
      print *,x
      call oct(x)
    call hex(x)

      x = 1.0E-2
      print *,x
      call oct(x)
    call hex(x)
      stop
      end

