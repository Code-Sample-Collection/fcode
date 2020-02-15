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
! File: loaded_die.f90
!
! Loaded die problem simulation

program loaded_die
      integer, parameter :: n = 5000
      real, dimension(n) :: r
      real, dimension(6) :: y = (/ 0.2,0.34,0.56,0.72,0.89,1.0 /)
      integer, dimension(6) :: m = (/ 0.0,0.0,0.0,0.0,0.0,0.0 /) 
      integer :: i, j
      call random_number(r)
      do i = 1,n
         inner: do j = 1,6
                   if(r(i) < y(j)) then
                      m(j) = m(j) + 1     
                      exit inner
                   end if   
                end do inner
      end do    
      print *,m
end program loaded_die
  

