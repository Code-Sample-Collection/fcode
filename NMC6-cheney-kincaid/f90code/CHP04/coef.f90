!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 3.1
!
! File: coef.f90
!
! Newton interpolation polynomial for sin(x) at equidistant points (coef,eval)
! 10 equidistant points (9 intervals)
! evaluate sin(x)-p(x) at 37 points
!
program main     
      integer, parameter :: n=9
      real, dimension (0:n) :: x, y, a
      real :: eval
      integer :: i
      
      interface
      function eval(n,x,a,t)
      integer :: n                          
      real, dimension(0:n) :: x, a      
      real :: t
      end function eval
      subroutine coef(n,x,y,a)                                   
      integer, intent(in) :: n                             
      real, dimension(0:n), intent(in) :: x, y               
      real, dimension(0:n), intent(out) :: a                 
      end subroutine coef
      end interface

      h = 1.6875/real(n)
      do  i=0,n  
        x(i) = real(i)*h  
        y(i) = sin(x(i))    
      end do
      call coef(n,x,y,a)    
      print *, "Print the array a"
      print *, a
      print *, " Evaluation of sin(x)-p(x):  n  t   d"
      do  i = 0,4*n      
        t = real(i)*h*0.25
        d = sin(t) - eval(n,x,a,t)   
       print *, i,t,d
      end do
end program main
  
subroutine coef(n,x,y,a)                                   
      integer, intent(in) :: n                             
      integer :: i, j    
      real, dimension(0:n), intent(in) :: x, y               
      real, dimension(0:n), intent(out) :: a                 
                                                           
      do  i = 0,n
        a(i) = y(i) 
      end do
      do  j = 1,n
        do  i = n,j,-1   
          a(i) = (a(i) - a(i-1))/(x(i) - x(i-j))
        end do
      end do
end subroutine coef
  
function eval(n,x,a,t)
      integer :: i, n                    
      real, dimension(0:n) :: x, a           
      real :: t, temp                       
      temp = a(n) 
      do  i=n-1,0,-1 
        temp = temp*(t - x(i)) + a(i) 
      end do
      eval = temp    
end function eval 
                                                                      











