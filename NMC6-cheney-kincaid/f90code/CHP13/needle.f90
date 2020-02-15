!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 13.3
!
! File: needle.f90
!
! Buffon's needle problem simulation

program needle
      integer, parameter :: n = 5000, iprt = 1000
      real, dimension(n,2) :: r
      real :: pi2, w, v, prob
      integer :: i,m
      pi2 = 2.0*atan(1.0)
      m = 0
      call random_number(r)
      do i = 1,n
         w = r(i,1)       
         v = pi2*r(i,2) 
         if (w <= sin(v))  then
            m = m + 1  
         end if
         if (mod(i,iprt) == 0)  then   
            prob = real(m)/real(i)      
            print *," i, prob, 2/pi", i,prob, 1.0/pi2
         end if
      end do   
end program needle
