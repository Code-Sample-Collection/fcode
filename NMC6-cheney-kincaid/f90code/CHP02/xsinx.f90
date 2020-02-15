!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 2.3      
!
! File: xsinx.f
!
! Example of programming f(x) = x - sin(x) using the function f
!
program xsinx
      integer, parameter :: dp = kind(1d0)
      real (kind = dp) dx, dy, dz
      real x, y, f
      integer  n

      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface

      dx = 1.0_dp/15.0_dp     
      dy = sin(dx)
      dz = dx - dy
      print *,dx,dy,dz      
      x = 16.0    
      do n = 1,52 
        x = 0.25*x
        y = f(x)  
        print *,n,x,y       
      end do
      x = sin(1.0)
      y = f(1.0)
      print *,x,y 
end program xsinx
  
function f(x) 
      real, intent (in) :: x
      real :: f, t
      integer :: n
      if(abs(x) >= 1.9) then
        f = x - sin(x)
        else
        t = x**3/6.0
        f = t     
        do n = 1,9
          t = -t*x*x/real((2*n+2)*(2*n+3))      
          f = f + t 
        end do    
      end if      
end function f
                                                                      

