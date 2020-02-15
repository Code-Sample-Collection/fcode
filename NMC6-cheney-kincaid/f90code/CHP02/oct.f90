!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 2.1
!
! File: oct.f90
!
! Print octal representation of a floating-point number
!
subroutine oct(i) 
   integer :: i
   write(6,600) i
600 format(o20) 
end subroutine oct 
