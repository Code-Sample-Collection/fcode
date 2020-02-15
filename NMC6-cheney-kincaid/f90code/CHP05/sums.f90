!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 5.1
!
! File: ulsum.f
!
! Upper and lower sums programming experiment for an integral

program sums
      integer :: i
      real :: h, sum, suml, sumu, x
      integer, parameter :: n = 1000
      real, parameter :: a = 0.0 ; b = 1.0
 
      h = 1.0/real(n)     
      sum = 0.0   
      do i = n,1,-1     
        x = a + real(i)*h       
        sum = sum + f(x)
      end do  
      suml = h*sum 
      sumu = suml + h*(f(a) - f(b))
      print *,"suml =",suml,"sumu =",sumu 
end program sums

      function f(x)
      real, intent(in) :: x
      f = 1.0/exp(x*x)
      end function f

