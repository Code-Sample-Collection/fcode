!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 11.1
!
! File: taylorsys2.f90
!
! Taylor series method (order 4) for system of ordinary differential equations

 program taylorsys2
      integer, parameter :: n = 2, nsteps = 100
      real, parameter :: a = 0.0, b = 1.0
      integer :: i, k
      real :: h
      real x(0:n,0:4)
       x(0,0) = 0.0
       x(1,0) = 1.0
       x(2,0) = 0.0
      print *,0,x
      h = ( b - a) /nsteps
      do k = 1, nsteps      
         x(0,1) = 1.0
         x(1,1) = x(1,0) - x(2,0) + x(0,0)*(2.0 - x(0,0)*(1.0 + x(0,0)))      
         x(2,1) = x(1,0) + x(2,0) + x(0,0)*x(0,0) * (-4.0 + x(0,0))   
         x(0,2) = 0.0
         x(1,2) = x(1,1) - x(2,1) + 2.0 - x(0,0)*(2.0 + 3.0*x(0,0))    
         x(2,2) = x(1,1) + x(2,1) + x(0,0)*(-8.0 + 3.0*x(0,0)) 
         x(0,3) = 0.0
         x(1,3) = x(1,2) - x(2,2) - 2.0 - 6.0*x(0,0)    
         x(2,3) = x(1,2) + x(2,2) - 8.0 + 6.0*x(0,0)    
         x(0,4) = 0.0
         x(1,4) = x(1,3) - x(2,3) - 6.0  
         x(2,4) = x(1,3) + x(2,3) + 6.0  
         do i=0,n
x(i,0)=x(i,0)+h*(x(i,1)+(h/2.0)*(x(i,2)+(h/3.0)*(x(i,3)+(h/4)*x(i,4))))
         print *,'k = ',k,', x(',i,',0) = ',x(i,0)
         end do      
      end do   
end program taylorsys2








