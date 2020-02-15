!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 10.2
!
! File: rk4.f90
!
! Runge-Kutta method of order 4 for solving an initial value problem (rk4,f)

program main
      real :: a = 1.0, b = 1.5625, x=2.0, h, t
      integer :: n =72

      interface
      function f (t,x) 
      real, intent(in) ::  t, x
      end function f
      end interface
      
      h=(b-a)/real(n)
      t=a
      call rk4(f,t,x,h,n) 
end program main
  
      function f (t,x)
      real, intent(in) :: t, x 
      f = 2.0 + (x - t - 1.0)**2  
      end function f
  
subroutine rk4 (f,t,x,h,n)   
    real :: f1, f2, f3, f4, ta
        real, intent(in) :: t,x,h
    integer, intent (in) :: n
    integer:: k

        interface
    function f (t,x)
    real, intent(in) ::  t, x
    end function f
        end interface
        print *,"0",t,x 
        ta = t   
        do k = 1, n      
           f1 = h*f(t, x)       
           f2 = h*f(t + h/2.0, x + 0.5*f1)   
           f3 = h*f(t + h/2.0, x + 0.5*f2)   
           f4 = h*f(t + h, x + f3)
           x = x + (f1 + 2*f2  +2*f3 + f4)/6.0
           t = ta + h*real(k) 
           print *,k,t,x 
        end do
end subroutine rk4
                                                                          




