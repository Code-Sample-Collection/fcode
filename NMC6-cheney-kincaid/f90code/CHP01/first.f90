!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 1.1
!
! File: first.f90
!
! First programming experiment:  compute derivative of sin(x)
! by limit definition

program first
      integer, parameter :: n =25
      integer :: i
      real :: error, h, y
      x = 0.5
      h = 1.0
      print*, "  i   h   y   error"
      do i = 1,n
         h = 0.25*h
         y = (sin(x + h) - sin(x))/h  
         error = abs(cos(x) - y)      
         print *, i, h, y, error     
      end do   
end program first
       
