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
! File: shielding.f90
!
! Neutron shielding problem simulation

program shielding
      integer, parameter :: n = 5000, iprt = 1000
      real, dimension (n,7) :: r
      integer :: i,j,m
      real :: pi, x, per
      pi = 4.0*atan(1.0)    
      m = 0
      call random_number(r)
      do i = 1,n
         x = 1.0   
  inner: do j = 1,7
            x = x + cos(pi*r(i,j))
            if(x <= 0.0)  exit inner
            if(x >= 5.0) then 
            m = m + 1 
            exit inner
            end if
            end do inner
            if(mod(i,iprt) == 0)  then   
              per = 100.0*real(m)/real(i) 
              print *," print i, percent",i,per     
            end if
      end do
end program shielding
                                                                 


