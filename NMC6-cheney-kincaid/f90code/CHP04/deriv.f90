!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 4.3
!
! File: deriv.f90
! 
! Derivative by center differences and richardson extrapolation (deriv,f)
!
program main
      integer, parameter :: n=10    
      real, dimension(0:n,0:n) :: d  
      real :: h, pi3, f
      
      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface

      h=1.0    
      pi3=4.0*atan(1.0)/3.0 
      call deriv(f,pi3,n,h,d)      
      do i=0,n
      do j=0,i-1
         print*, "d(",i,j,")"
         print "(5e22.14)", d(i,j)
      end do
      print*, "d(",i,j,")"
      print "(5e22.14)", d(i,j)
      end do
end program main
  
      function f(x) 
      real, intent(in) :: x
      f=sin(x)    
      end function f 
  
subroutine deriv(f,x,n,h,d)  
      real, dimension (0:n,0:n) :: d
      real, intent(in) :: x, h
      integer, intent(in) :: n
      real :: q
      integer :: i, j

      interface
      function f(x)
      real, intent(in) :: x
      end function f
      end interface

      do  i=0,n  
        d(i,0)=(f(x+h)-f(x-h))/(2.0*h)
        q=4.0     
        do  j=0,i-1
          d(i,j+1)=d(i,j)+(d(i,j)-d(i-1,j))/(q-1.0)       
          q=4.0*q 
        end do
        h=h/2.0   
      end do
end subroutine deriv
                                                                        





