!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 14.2
!
! File: bvp2.f90
!
! Boundary value problem solved by shooting method (rk4sys,xpsys)

program main
      integer, parameter :: n = 99, m = 4
      real, parameter :: ta =1.0, tb=2.0, &
                         alpha=1.09737491, beta=8.63749661

      real, dimension (0:n+1)::  x1, x3
      real, dimension (0:m)::  x = (/1.0,1.09737491,0.0,1.09737491,1.0/)

      real :: error,h,t,p,q
      integer :: i
 
      h = (tb - ta)/n
      t = ta      
      do i = 1,n
      call rk4sys(m,h,x,1)      
        x1(i) = x(1)
        x3(i) = x(3)
        t = ta + dble(i)*h  
      end do
      p = (beta - x3(n))/(x1(n) - x3(n))  
      q = 1.0 - p 
      do i = 1,n
        x1(i) = p*x1(i) + q*x3(i)     
      end do
      error = exp(ta) - 3.0*cos(ta) - alpha     
      print *,ta,alpha,error
      do i = 9,n,9      
        t = ta + dble(i)*h  
        error = exp(t) - 3.0*cos(t) - x1(i)     
        print *,t,x1(i),error 
      end do
end program main
        
subroutine xpsys(n,x,f) 
      real, dimension (0:n) ::  x, f
      integer n
      f(0) = 1.0  
      f(1) = x(2) 
      f(2) = exp(x(0)) - 3.0*sin(x(0)) + x(2) - x(1)      
      f(3) = x(4) 
      f(4) = exp(x(0)) - 3.0*sin(x(0)) + x(4) - x(3)      
end subroutine xpsys 

subroutine rk4sys(n,h,x,nsteps)
      real::  x(0:n)
      real, allocatable :: y(:), f(:,:)  
      integer :: i, k, n
      real :: h
      print *,0,x
      allocate (y(0:n), f(0:n,4))
out:  do k = 1,nsteps      
        call xpsys(n,x,f(0,1))
in1:    do i = 0,n
          y(i) = x(i) + 0.5*h*f(i,1)      
        end do in1
        call xpsys(n,y,f(0,2))
in2:    do i = 0,n
          y(i) = x(i) + 0.5*h*f(i,2)      
        end do in2
        call xpsys(n,y,f(0,3))    
in3:    do i = 0,n
          y(i) = x(i) + h*f(i,3)       
        end do in3
        call xpsys(n,y,f(0,4))    
in4:    do i = 0,n
          x(i) = x(i) + (h/6.0)* (f(i,1) + 2.0*(f(i,2) + f(i,3)) + f(i,4)) 
        end do in4
        print *, k, x
      end do out
end subroutine rk4sys 
   



