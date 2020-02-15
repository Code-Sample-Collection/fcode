!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 9.3
!
! file: bspline2.f90
!
! interpolates table using a quadratic b-spline function 
! (bspline2_coef, bspline2_eval)

program main
      integer, parameter :: n = 4
      real, dimension (0:n):: t,y
      real, dimension (1:10)::z
      real, dimension (0:n+1) ::a
      real, dimension (0:n+1):: h 

      interface
      subroutine bspline2_coef(n,t,y,a,h)              
      integer, intent(in) :: n                         
      real, dimension (0:n), intent(in):: t, y         
      real, dimension (0:n+1), intent(out):: a         
      real, dimension (0:n+1), intent(out):: h          
      end subroutine bspline2_coef
      function bspline2_eval(n,t,a,h,x)                 
      real, dimension (0:n+1), intent(in) :: a          
      real, dimension (0:n+1), intent(in) :: h          
      real, dimension (0:n), intent(in) :: t            
      integer, intent(in) :: n                          
      real, intent(in) :: x                             
      end function bspline2_eval
      end interface
      
      t(0)=1.0; t(1)=2.0; t(2)=3.0; t(3)=4.0; t(4)=5.0
      y(0)=0.0; y(1)=1.0; y(2)=0.0; y(3)=1.0; y(4)=0.0
  
      call bspline2_coef(n,t,y,a,h) 
      z(1) = bspline2_eval(n,t,a,h,1.)      
      z(2) = bspline2_eval(n,t,a,h,2.)      
      z(3) = bspline2_eval(n,t,a,h,3.)      
      z(4) = bspline2_eval(n,t,a,h,4.)      
      z(5) = bspline2_eval(n,t,a,h,5.)      
      z(6) = bspline2_eval(n,t,a,h,1.25)    
      z(7) = bspline2_eval(n,t,a,h,2.5)     
      z(8) = bspline2_eval(n,t,a,h,3.75)    
      z(9) = bspline2_eval(n,t,a,h,4.5)     
      z(10)= bspline2_eval(n,t,a,h,5.75)    

      print *,"coefficients a", a
      print*, "evaluation of bspline at 1,2,3,4,5,1.25,2,5.3,75,4.5,5.75"
      print*, z
end program main

subroutine bspline2_coef(n,t,y,a,h)              
      integer, intent(in) :: n                         
      real, dimension (0:n), intent(in):: t, y         
      real, dimension (0:n+1), intent(out):: a         
      real, dimension (0:n+1), intent(out):: h          
      integer :: i
      real :: delta, gamma, p,q
      do i = 1,n
      h(i) = t(i) - t(i-1)
      end do
      h(0) = h(1) 
      h(n+1) = h(n) 
      delta = -1.0
      gamma = 2.0*y(0)
      p = delta*gamma
      q = 2.0
      do  i = 1,n      
         r  = h(i+1)/h(i)
         delta = -r*delta
         gamma = -r*gamma + (r + 1.0)*y(i)
         p = p + gamma*delta 
         q = q + delta*delta 
      end do
      a(0) = -p/q 
      do i = 1,n+1
         a(i) = ((h(i-1)+h(i))*y(i-1)-h(i)*a(i-1))/h(i-1)
      end do
end subroutine bspline2_coef
  
function bspline2_eval(n,t,a,h,x)                 
      real, dimension (0:n+1), intent(in) :: a          
      real, dimension (0:n+1), intent(in) :: h          
      real, dimension (0:n), intent(in) :: t            
      integer, intent(in) :: n                          
      real, intent(in) :: x                                               
      integer :: i
      do i = n-1,0,-1      
         if ( x - t(i) >= 0.0) exit
      end do
      i = i + 1
      print *,"i,x",i,x
       d  =(a(i+1)*(x - t(i-1)) + a(i)*(t(i) - x + h(i+1)))/(h(i) + h(i+1)) 
 e = (a(i)*(x - t(i-1) + h(i-1)) + a(i-1)*(t(i-1) - x + h(i)))/(h(i-1) + h(i))
      bspline2_eval = ((d*(x - t(i-1)) + e*(t(i) - x)))/h(i)      
end function bspline2_eval

                                                                       




