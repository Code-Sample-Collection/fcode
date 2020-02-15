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
! File: two_die.f90
!
! Two dice problem simulation 

program two_die
      integer, parameter :: n = 5000, iprt = 1000
      real, dimension(n,24,2) :: r
      real ::prob
      integer ::  i, j, i1, i2, m
      m = 0
      call random_number(r)
      do i = 1,n
         inner: do j = 1,24       
                   i1 = int(6.0*r(i,j,1) + 1.0) 
                   i2 = int(6.0*r(i,j,2)+ 1.0) 
                   if (i1+i2 == 12) then
                      m = m + 1 
                      exit inner
                    end if
                 end do inner
                 if (mod(i,iprt) == 0)  then   
                    prob = real(m)/real(i)      
                    print *,i,prob    
                 end if    
      end do
end program two_die
