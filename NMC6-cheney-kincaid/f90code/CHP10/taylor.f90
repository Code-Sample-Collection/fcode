!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 10.1 
!
! File: taylor.f90
!
! Taylor series method (order 4) for solving an ordinary differential equation

program main
      real ::  a=1.0,b=2.0, x=-4.0, h, t, x1,x2,x3,x4
      integer :: n=100, k

      h=(b-a)/real(n)
      t=a
      print*,"0",t,x
      do k=1,n
         x1 = 1.0 + x*x + t**3 
         x2 = 2.0*x*x1 + 3.0*t*t       
         x3 = 2.0*x*x2 + 2.0*x1*x1 + 6.0*t       
         x4 = 2.0*x*x3 + 6.0*x1*x2 + 6.0 
         x = x + h*(x1 + (h/2.0)*(x2 + (h/3.0)*(x3 + (h/4.0)*x4)))
         t =  a + real(k)*h       
         print *, k,t,x
      end do
end program main
                                                                        
