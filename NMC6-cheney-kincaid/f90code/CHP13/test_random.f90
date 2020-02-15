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
! File: test_random.f90
!
! Example to compute and print n random numbers
   
program test_random
      integer, parameter :: n = 10
      real, dimension(n) :: x
      call random_seed
      call random_number(x)    
      print "(f22.14)",( x(i),i=1,n)
end program test_random



