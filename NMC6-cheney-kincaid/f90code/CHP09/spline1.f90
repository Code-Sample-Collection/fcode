!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 9.1
!
! File: spline1.f
!
! Interpolates table using a first-degree spline function (spline1)

program main
      integer, parameter :: n = 4
      real, dimension(0:n) :: t, y
      real, dimension(1:11) :: z

      interface
      function spline1(n,t,y,x)
      integer, intent(in)::n
      real, dimension(0:n)::t,y
      real, intent(in)::x
      end function spline1
      end interface
     
      t=(/ 1., 2., 3., 4., 5./)
      y=(/ 0., 1., 0., 1., 0./)
      
      z(1) = spline1(n,t,y,1.) 
      z(2) = spline1(n,t,y,2.) 
      z(3) = spline1(n,t,y,3.) 
      z(4) = spline1(n,t,y,4.) 
      z(5) = spline1(n,t,y,5.) 
      z(6) = spline1(n,t,y,-0.5)
      z(7) = spline1(n,t,y,1.25) 
      z(8) = spline1(n,t,y,2.75)
      z(9) = spline1(n,t,y,3.5)
      z(10) = spline1(n,t,y,4.25)
      z(11) = spline1(n,t,y,5.5)
      print *, z
end program main

function spline1(n,t,y,x)
      integer, intent(in) :: n
      real, dimension (0:n) :: t, y
      real, intent(in):: x 
      integer :: i
      real :: diff
      do i = n-1,1,-1     
        diff = x - t(i)     
         print *,"i,diff",i,diff
        if (diff >= 0.0) exit  
      end do    
      print *,"i,x,diff",i,x,diff
      spline1 = y(i) + (x - t(i))*(y(i+1) - y(i))/(t(i+1) - t(i))
end function spline1
                                                                        





