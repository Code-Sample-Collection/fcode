!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 13.1
!
! File: coarse_check.f90
!
! Coarse check on the random-number generator

program coarse_check
      integer, parameter :: n = 10000 
      real, dimension(n) :: r
      real:: per
      integer::  i, m
      m = 0
      call random_number(r)
      do i = 1,n
         if(r(i) <= 0.5)  m = m + 1     
         if( mod(i, 1000) == 0)  then
            per = 100.0*real(m)/real(i)      
            print *, i, per
          end if  
      end do
end program coarse_check
  
