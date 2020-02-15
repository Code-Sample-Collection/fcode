!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 5.2
!
! File: trap.f
!
! Trapezoid rule programming experiment for an integral

program trap
      integer :: i
      real :: h, sum, x, f
      integer, parameter :: n=60 
      real, parameter:: a=0.0; b=1.0
    
      h = (b-a)/real(n)  
      sum = 0.5*(f(a) + f(b))     
      do  i=1,n-1
        x = a + i*h
        sum = sum + f(x)   
      end do
      sum = h*sum 
      print *,sum 
end program trap

      function f(t)
      real, intent(in) :: t
      f= 1.0/exp(t*t)
      end function f
