!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 3.2
!
! File: rec_bisection.f90
!
! Uses recursive bisection function bisection(f, a,b,fa,fb,nstep,ncount)
!
      program main
      integer, parameter :: nsteps = 20
      integer :: ncount
      real :: a, b, fa, fb, ga, gb

      interface                              
      function f(x)                          
      real, intent(in) :: x                  
      end function f                         
      function g(x)                          
      real, intent(in) :: x                  
      end function g                         
      end interface                          

      print *, "first function f"
      a = 0.0 ; b = 1.0
      print *, "a =",a, "b =",b
      fa = f(a) ; fb = f(b)
      print *, "fa, fb", fa,fb
      ncount=0
      call bisection(f,a,b,fa,fb,nsteps,ncount)
      print *, "second function g"
      a = 0.5 ; b = 2.0
      print *, "a =",a, "b =",b
      ga = g(a) ; gb = g(b)
      print *, "ga, gb", ga, gb
      ncount=0
      call bisection(g,a,b,ga,gb,nsteps,ncount)
      end program main

      function f(x) 
      real, intent (in) :: x
      f = (x*x - 3.0)*x + 1.0     
      end function f 

      function g(x)  
      real, intent (in) :: x
      g = x*x*x - 2.0*sin(x)
      end function g

      recursive subroutine bisection(f,a,b,fa,fb,nsteps,ncount)
      integer, intent (in) :: nsteps, ncount
      real :: a, b, fa, fb 
      real ::  c, fc, error                               
      interface                            
      function f(x)                  
      real, intent(in) :: x          
      end function f                 
      end interface                  
      if ( sign(1.0,fa) == sign(1.0,fb) ) then                       
         print *, "function has same sign at ends"
         print *,a,b,fa,fb
      else
         error = (b - a)*0.5
         c = a + error  
         fc = f(c)
         print *,"n =",ncount," c =",c," f(c) =",fc," error =",error
         ncount = ncount + 1
         if ( ncount <=  nsteps ) then
            if ( sign(1.0,fa) /= sign(1.0,fc) ) then           
               call bisection(f,a,c,fa,fc,nsteps,ncount)
            else                       
               call bisection(f,c,b,fc,fb,nsteps,ncount)
            endif                                               
         endif    
      endif
      end subroutine bisection          
