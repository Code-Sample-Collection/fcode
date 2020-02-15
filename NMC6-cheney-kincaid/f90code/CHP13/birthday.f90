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
! File: birthday.f90
!
! Birthday problem with n persons and npts times repeated

program birth
      integer, parameter :: n = 23, npts = 1000
      integer :: i
      print*, "Birthday Problem Simulation with n persons "
      print*, "no. of persons = ", n, "; no. of iterations = ", npts
      do i = 1, 10
         print*, "probability ", probably(n, npts)
      end do
end program birth
      
function probably(n, npts)
      real :: probably
      integer, intent(in) :: n, npts
      real:: sum
      integer :: i
      logical :: temp
      sum = 0.0
      do i = 1, npts
         temp = birthday(n)
         if (temp) then 
         sum = sum + 1.0 
         endif
       end do

      probably = sum/real(npts)
      contains

      function birthday(n)
      logical :: birthday
      integer, intent(in) :: n
      real, dimension (n) :: r
      logical, dimension (365) :: days
      integer :: i, number
      call random_number(r)
      do i = 1, 365
         days(i) = .false.
      end do
      birthday = .false.
      do i = 1, n
         number = 365* r(i) + 1
         if (days(number)) then 
         birthday = .true.
         exit 
         end if
      days(number) = .true.
      end do
      end function birthday 
end function probably







