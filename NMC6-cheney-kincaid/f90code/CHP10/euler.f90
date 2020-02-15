!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 10.1
!
! File: euler.f90
!
! Euler's method for solving an ordinary differential equation

program main
      real :: a= 1.0, b= 2.0, x=-4.0, h, t, f
      integer :: n= 100, k

      h = (b - a)/ real(n)
      t = a 
      print *,t,x 
      do k = 1,n
         x = x + h*f(t,x)
         t = t + h 
         print*, "this is k,t,x", k,t,x 
      end do
end program main

      function f(t,x)
      real, intent(in)::x, t
      f = 1.0 + x*x + t**3    
      end function f

                                                                      




