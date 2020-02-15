!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 11.1
!
! File: rk4sys.f90
!
! Runge-Kutta method of order 4 for a system of ode's (rk4sys,xpsys)

program main
      integer, parameter :: n = 2, nsteps = 100
      real, parameter :: a = 0.0, b =1.0
      real ::  x(0:n) 
      x = (/0.0, 1.0, 0.0/)
      h = (b - a)/nsteps
      call rk4sys(n,h,x,nsteps)
end program main
  
subroutine xpsys(n,x,f) 
      real, dimension (0:n) ::  x, f
      integer n
      f(0) = 1.0
      f(1) = x(1) - x(2) + x(0)*(2.0 - x(0)*(1.0+ x(0)))  
      f(2) = x(1) + x(2) - x(0)*x(0)*(4.0 - x(0)) 
end subroutine xpsys 

subroutine rk4sys(n,h,x,nsteps)
      real ::  x(0:n)
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


















