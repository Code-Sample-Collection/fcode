!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 15.1
!
! File: parabolic1.f90
!
! Parabolic pde problem solved by explicit method

program parabolic1
      integer, parameter :: n = 10, m = 20
      real, parameter :: h = 0.1, k = 0.005
      real, dimension (0:n) :: u,v
      integer:: i,j
      real::pi,pi2
      u(0) = 0.0; v(0) = 0.0; u(n) = 0.0; v(n) =0.0
      pi = 4.0*atan(1.0)    
      pi2 = pi*pi 
      do i=1, n-1
         u(i) = sin( pi*real(i)*h)
      end do
      print*, " print u(i) calculated for the first time"
      print "(//(5(5x,e22.14)))",(u(i),i = 0,n)
out:  do j = 1,m 
in1:    do i = 1, n-1
           v(i) = 0.5*(u(i-1)+u(i+1))
        end do in1
        print*, "print the calculated v(i) where j = ",j
        print "(//(5(5x,e22.14)))",(v(i),i = 0,n)
        t = real(j)*k      
in2:    do i = 1, n-1
           u(i) = exp(-pi2*t)*sin(pi*real(i)*h) - v(i)       
        end do in2
        print*, "This is the difference between true value and v(i) and j =",j
        print "(//(5(5x,e22.14)))",(u(i),i = 0,n)
in3:    do i = 1, n-1
           u(i) = v(i)       
        end do in3
      end do out
end program parabolic1
 
                                                                   








                                                                   
