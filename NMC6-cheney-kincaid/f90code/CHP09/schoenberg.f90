!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 9.3
!
! File: sch.f90
!
! Interpolates table using Schoenberg's process (sch_coef,sch_eval,f)

program main 
      integer, parameter :: n=20, m=100
      real, parameter :: a=-5.0, b=5.0
      real, dimension (n+3):: d
      real, dimension (0:m)::x,y,z,e
      integer :: j

      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface
      
      call sch_coef(f,a,b,n,d) 
      print*, "Here are the coefficients d(i), i=1 to n+3"
      do j =1, n+3
      print"(1x,5e25.15)",d(j)
      end do
      h=(b-a)/real(m)
      do j=0,m
      x(j)=a+h*real(j)     
      y(j)=f(x(j)) 
      z(j)=sch_eval(a,b,n,d,x(j)) 
      e(j)=y(j)-z(j)
      end do
      print*, " print i, x(i), y(i), z(i), e(i) for i=0 to 100"
      do j=0,m
      print*,j, x(j),y(j) ,z(j), e(j)
      end do
end program main

      function f(x)                
      real, intent(in) :: x        
      f=1.0/(x**2+1.0)             
      end function f               
                                    
subroutine sch_coef(f,a,b,n,d)         
      interface                        
      function f(x)              
      real, intent(in) :: x      
      end function f             
      end interface                    

      integer, intent(in) :: n               
      real, dimension(n+3)::  d            
      real, intent(in) :: a,b                
      real :: h
      integer :: i
      h = (b - a)/real(n) 
      do i=2, n+2      
         d(i) = f(a + h*real(i-2)) 
      end do
      d(1) = 2.0*d(2) - d(3)
      d(n+3) = 2.0*d(n+2) - d(n+1)
end subroutine sch_coef
     
function sch_eval(a,b,n,d,x)      
      real, dimension(n+3), intent(in):: d
      real, intent(in) :: a,b, x
      integer, intent(in) :: n
      integer :: k
      real :: h, p,c,e
      h = (b - a)/real(n) 
      k = int((x-a)/h + 2.5)
      p = x-a-(k-2.5)*h
      c = (d(k+1)*p + d(k)*(2.0*h - p))/(2.0*h)   
      e = (d(k)*(p + h) + d(k-1)*(h - p))/(2.0*h)     
      sch_eval = (c*p + e*(h-p))/h 
end function sch_eval


