!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 3.3
!
! File: secant.f90
!
! Secant method using subroutine secant(f,a,b,m)
!
      program main
      real :: a = 1.0, b = -1.0
      integer :: m = 8
      interface
      function f(x)
      real, intent(in) :: x
      end function
      end interface

      call secant(f,a,b,m)
      end program main

      subroutine secant(f,a,b,m)
      real, intent(in) :: a,b
      integer, intent(in) :: m
      real :: fa, fb, temp
      integer :: n
      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface

      fa = f(a)
      fb = f(b)
      if (abs(fa) >  abs(fb)) then
         temp = a
         a = b
         b = temp
         temp = fa
         fa = fb
         fb = temp
      end if
      print *,"    n        x(n)         f(x(n))"
      print *," 1 ", b, fb
      print *," 0 ", a, fa    
      do n = 2,m
         if (abs(fa) >  abs(fb)) then
            temp = a
            a = b
            b = temp
            temp = fa
            fa = fb
            fb = temp
         end if
         temp = (b - a)/(fb - fa)
       b = a
     fb = fa
         a = a - fa*temp
         fa = f(a)
         print *,n,a,fa
      end do   
      end subroutine secant

      real function f(x)
      real, intent(in) :: x
      f = x**5 + x**3 + 3.0
      end function f


                                                                   
