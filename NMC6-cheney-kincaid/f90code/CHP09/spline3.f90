!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 9.2
!
! file: spline3.f
!
! Natural cubic spline function for sin(x) at 10 equidistant points 
! also evaluates sin(x) - S(x) at 37 equidistant points using
! spline3_coef(n,t,y,z) and spline3_eval(n,t,y,z,x)

program main
      integer, parameter :: n = 9
      real, parameter :: a=0.0, b=1.6875
      real, dimension(0:n):: t,y,z
      real :: d,h,x
      integer ::i

      interface
      subroutine spline3_coef(n,t,y,z)
      integer, intent(in)::n
      real, dimension(0:n), intent(in):: t,y
      real, dimension(0:n), intent(out):: z
      end subroutine spline3_coef
      function spline3_eval(n,t,y,z,x)
      integer, intent(in)::n
      real, dimension(0:n), intent(in)::t,y,z
      real, intent(in):: x
      end function spline3_eval
      end interface

      h = (b-a)/real(n)
      do i=0,n  
        t(i)  = a + real(i)*h  
        y(i) = sin(t(i))    
      end do
      call spline3_coef(n,t,y,z)     
      do i = 0,4*n
        x = a + real(i)*h*0.25
        d = sin(x) - spline3_eval(n,t,y,z,x)  
        print "(i5,f22.14,e15.3)", i,x,d       
      end do
end program main
     
subroutine spline3_coef(n,t,y,z) 
      integer, intent(in)::n
      real, dimension(0:n), intent(in)::  t,y
      real, dimension(0:n-1) :: h,b
      real, dimension(n-1)::u,v
      real, dimension(0:n), intent(out):: z 
      integer :: i
      do i = 0,n-1
        h(i) = t(i+1) - t(i)
        b(i) = (y(i+1) -y(i))/h(i)    
      end do
      u(1) = 2.0*(h(0) + h(1))
      v(1) = 6.0*(b(1) - b(0))
      do i = 2,n-1
        u(i) = 2.0*(h(i) + h(i-1)) - h(i-1)**2/u(i-1)     
        v(i) = 6.0*(b(i) - b(i-1)) - h(i-1)*v(i-1)/u(i-1) 
      end do
      z(n) = 0.0  
      do i = n-1,1,-1     
        z(i) = (v(i) - h(i)*z(i+1))/u(i)
      end do
      z(0) = 0.0
end subroutine spline3_coef 
  
function spline3_eval(n,t,y,z,x)
      integer, intent(in):: n
      real, dimension(0:n), intent(in):: t,y,z       
      real, intent(in):: x
      real :: h, temp
      integer :: i
      do i = n-1,1,-1     
        if( x - t(i) >= 0.0) exit    
      end do
      h = t(i+1) - t(i)     
      temp = 0.5*z(i) + (x - t(i))*(z(i+1) - z(i))/(6.0*h) 
     temp = (y(i+1) - y(i))/h - h*(z(i+1) + 2.0*z(i))/6.0 + (x- t(i))*temp     
      spline3_eval = y(i) + (x - t(i))*temp  
end function spline3_eval 
                                                                   

