!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 6.1
!
! File: rec_simpson.f90
!   
! Recursive simpson
!
program test_simpson                
      integer :: level = 0, level_max = 20
      real :: x_min, x_max, epsilon
      real :: answer, pi

      interface
      function f (x)  result (f_result)
      real, intent (in) :: x
      real :: f_result
      end function f
      end interface

      pi = 4.0*atan(1.0)
      x_min= 0; x_max= 2*pi; epsilon = .00005
      print *, " hello: beginning ..."
      answer = simpson (f, x_min, x_max, epsilon, level, level_max)
      print *, " finished program"
      print *, "approximate integral =", answer
end program test_simpson

      function f(x) 
      real, intent (in) :: x
      f = cos(2*x)/exp(x)
      end function f

recursive function simpson (f, a, b, epsilon, level, level_max)  &
                            result (simpson_result)

      interface
      function f(x)   result (f_result)
      real, intent (in) :: x
      real :: f_result
      end function f
      end interface

      real, intent(in) :: a, b, epsilon
      real :: simpson_result
      real :: h, c, d, e
      real :: one_simpson, two_simpson
      real :: left_simpson, right_simpson
      integer :: level

      level = level + 1
      h = b - a
      c = (a+b)/2.0
      print *, "simpson"
      print *,"a, b", a, b      
      print *, "level", level
      one_simpson = h*(f(a) + 4.0*f(c) + f(b))/6.0
      d = (a+c)/2.0
      e = (c+b)/2.        
      two_simpson = h*(f(a) + 4.0*f(d) + 2.0*f(c) &
                            + 4.0*f(e) + f(b))/12.0
      print *, "one_simpson", one_simpson
      print *, "two_simpsn", two_simpson
      if (level >= level_max) then
         simpson_result = two_simpson
      else   
         if ( abs(two_simpson - one_simpson) <= 15.0*epsilon ) then
            simpson_result = two_simpson
            print *, "no split"
            print *, "simpson_result", simpson_result
         else
            left_simpson = simpson(f, a, c, epsilon/2. , level, level_max)
            right_simpson = simpson(f, c, b, epsilon/2. , level, level_max)
            simpson_result = left_simpson + right_simpson
            print *, "split"
            print *, "left_simpson", left_simpson    
            print *, "right_simpson", right_simpson
            print *, "simpson_result", simpson_result
         end if
      end if   
end function simpson
