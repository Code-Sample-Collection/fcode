!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 11.1
!
! File: taylorsys1.f90
!
! Taylor series method (order 4) for system of ordinary differential equations

program taylorsys
      integer, parameter :: nsteps = 100
      real, parameter :: a = 0.0, b = 1.0
      integer :: k
      real :: h,t,x,y,x1,x2,x3,x4,y1,y2,y3,y4
      x = 1.0; y = 0.0
      t = a
      print *,0,t,x,y 
      h = (b - a)/nsteps
      do k = 1, nsteps      
        x1 = x - y + t*(2.0 - t*(1.0 + t))      
        y1 = x + y + t*t*(-4.0 + t)   
        x2 = x1 - y1 + 2.0 - t*(2.0 + 3.0*t)    
        y2 = x1 + y1 + t*(-8.0 + 3.0*t) 
        x3 = x2 - y2 - 2.0 - 6.0*t    
        y3 = x2 + y2 - 8.0 + 6.0*t    
        x4 = x3 - y3 - 6.0  
        y4 = x3 + y3 + 6.0  
        x = x + h*(x1 + (h/2.0)*(x2 + (h/3.0)*(x3 + (h/4)*(x4))))
        y = y + h*(y1 + (h/2.0)*(y2 + (h/3.0)*(y3 + (h/4)*(y4))))
        t = a + real(k)*h       
        print *,k,t,x,y       
      end do   
end program taylorsys








