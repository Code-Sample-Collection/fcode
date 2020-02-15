!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 5.3
!
! File: romberg.f90
!
! Romberg array for three separate functions (romberg,f,g,p)

program rombrgp   
      real,  dimension (10,10):: r    
      real :: f, g, p

      interface
      function f(x)
      real, intent(in) :: x
      end function f
      function g(x)
      real, intent(in) :: x
      end function g
      function p(x)
      real, intent(in) :: x
      end function p
      end interface

      print *, "The first function is f(x)= 1/(1+x)"
      call rombrg(f,0.,2.,3,r)     
      print *, "The second function is g(x)=exp(x)"
      call rombrg(g,-1.,1.,4,r)    
      print *, "The third function is p(x)= sqrt(x)"
      call rombrg(p,0.,1.,7,r)     
end program rombrgp
  
      function f(x)
      real, intent (in) :: x 
      f = 1.0/(1.0 +x)
      end function f 
  
      function g(x) 
      real, intent (in) :: x
      g= exp(x)  
      end function g
  
      function p(x)
      real, intent (in):: x 
      p = sqrt(x) 
      end function p

subroutine rombrg(f,a,b,n,r)
      real,  dimension  (0:n, 0:n) :: r
      integer, intent (in) :: n
      real, intent(in) :: a, b
      real :: h, sum
      integer :: i, k, j

      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface
      
      h = b - a   
      r(0,0) = 0.5*h*(f(a) + f(b))    
      print "(a, 5e22.14)", "r(0,0) = ", r(0,0)
      do  i = 1, n
        h = 0.5*h 
        sum = 0.0 
        do k = 1,2**i -1,2    
          sum = sum + f(a + h*real(k))
        end do 
       m=1
        r(i,0) = 0.5*r(i-1,0) + h*sum 
        print "(a, i1, a, 5e22.14)", "r(", i,",0) =", r(i,0)
        do j = 1,i
          m = 4*m 
          r(i,j) = r(i,j-1) + (r(i,j-1) - r(i-1,j-1))/real(m - 1)
          print "(a, i1, a, i1, a, 5e22.14)", "r(", i, ",", j,") = ", r(i,j)
        end do 
      end do    
end subroutine rombrg
