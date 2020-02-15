!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 3.1
!
! File: bisection.f90
!
! Bisection method using subroutine bisect(f,fa,fb,n)
!
      program main
      integer, parameter ::m=20
      real :: fa = 0.0, fb =1.0, f 
      real :: ga = 0.5, gb =2.0, g 

      interface
      function f(x)
      real, intent(in) :: x
      end function 
      function g(x)
      real, intent(in) :: x
      end function g 
      end interface

      print *, "first function f"
      print *, "a =",fa, "b =",fb
      call bisect(f,fa,fb,m)
      print *, "second function g"
      print *, "a =", ga, "b =",gb
      call bisect(g,ga,gb,m)
      end program main

      function f(x)  
      real, intent (in) :: x
      f = ((x)*x - 3.0)*x + 1.0     
      end function f 

      function g(x)
      real, intent (in) :: x
      g = x**3 - 2.0*sin(x)
      end function
      
      subroutine bisect(f,a,b,m)                                            
      integer, intent (in) :: m                                         
      real :: a, b, c, fa, fb, fc, error                               
      interface                                                             
      function f(x)                                                   
      real, intent(in) :: x                                             
      end function f                                                    
      end interface

      fa = f(a)                                                       
      fb = f(b)
      if ( sign(1.0,fa) == sign(1.0,fb) ) then                       
        print *,"function has same sign at",a,b                       
      else                                                            
        print *,"n    c    f(c)     error"                           
        error = b - a
        do n = 0,m                                                    
            error = error/2.0
            c  = a + error
            fc = f(c)
            if ( sign(1.0,fa) /= sign(1.0,fc) ) then           
               b = c                  
               fb = fc                                                
            else                                                
               a = c    
               fa = fc  
            endif                                               
            print *, n, c, fc, error                            
         end do                                                 
      end if                                                          
   end subroutine bisect          
