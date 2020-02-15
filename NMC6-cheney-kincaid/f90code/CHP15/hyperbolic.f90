!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 15.2
! 
! File:  hyperbolic.f90
!
! Hyperbolic pde problem solved by discretization (f)

program hyperbolic
      integer, parameter :: n = 10, m = 20
      real, parameter :: h = 0.1, k = 0.05
      real, dimension(0:n) :: u,v,w
      integer:: i,j
      real:: t, rho, x  

      u(0)=0.0; v(0)=0.0; w(0)=0.0; u(n)=0.0; v(n)=0.0; w(n)=0.0      
      rho = (k/h)**2       
      do i = 1,n-1
        x = real(i)*h     
        w(i) = f(x) 
        v(i) = 0.5*( rho*(f(x-h) + f(x+h)) + 2.0*(1.0- rho)*f(x) )   
      end do
      print*, " print j and u(i)"
      do j = 2,m
        do i = 1,n-1 
          u(i) = rho*(v(i+1) + v(i-1)) + 2.0*(1.0-rho)*v(i) - w(i)  
        end do 
        print*, "j = "
        print "(//3x,i5,//(3(3x,e22.14)))",j,(u(i),i = 0,n)      
        do i = 1, n-1
           w(i) = v(i)
           v(i) = u(i)
           t = real(j)*k
           x = real(i)*h
           u(i) = true(x,t) - v(i)
      end do
      print*, " print the difference between true value and v(i)"
        print *,u
      end do 
end program hyperbolic
        
      function f(x)
      real, intent(in):: x
      real :: pi 
      pi = 4.0*atan(1.0)
      f = sin(pi*x) 
      end function f
        
      function true(x,t)
      real, intent(in) :: x,t
      real :: pi 
      pi= 4.0*atan(1.0)
      true = sin(pi*x)*cos(pi*t)
      end function true


                                                                     


