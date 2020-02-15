!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 13.2
!
! File: double_integral.f90
!
! Integral over a disk in xy-space by monte carlo 
!      
program double_integral
      integer, parameter :: n = 5000, iprt = 1000
      integer :: i, j
      real, dimension(n,2) :: r
      real :: sum, pi4, x, y
      
      pi4 = atan(1.0)       
      call random_number(r)
      sum = 0.0; j = 1
      do i = 1,n
         x = r(i,1); y = r(i,2)
         if ( (x - 0.5)**2 + (y - 0.5)**2 <= 0.25 )  then
            j = j + 1
            sum = sum + f(x,y)  
            if (mod(j,iprt) == 0)  then   
               vol = pi4*sum/real(j)       
               print *,j,vol     
            end if    
         end if   
      end do 
      vol = pi4*sum/real(j) 
      print *," print j and volume ",j,vol    
end program double_integral

      function f(x,y)
      real, intent(in) :: x,y
      f = sin (sqrt(log(x+y+1)))
      end function f
      

