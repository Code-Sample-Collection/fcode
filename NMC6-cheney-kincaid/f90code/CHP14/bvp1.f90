!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 14.2
!
! File: bvp1.f90
!
! Boundary value problem solved by discretization technique (tri)

program main
      real, dimension (99)::  a,b,c,d,y
      integer, parameter :: n = 99
      real, parameter :: ta =1.0, tb=2.0,  &
                         alpha=1.09737491, beta=8.63749661 
      real:: error,h,t,u,v,w,x
      integer:: i
      
      u(x) = exp(x) - 3.0*sin(x)      
      v(x) = -1.0 
      w(x) =  1.0
      interface
      subroutine tri(n,a,d,c,b,x)
      integer, intent(in)::n
      real, dimension(:), intent(in):: a,d,c,b
      real, dimension(:), intent(out)::x
      end subroutine tri
      end interface
 
      h = (tb - ta)/dble(n) 
      do i = 1,n-1
        t = ta + dble(i)*h  
        a(i) = -(1.0 + (h*0.5)*w(t))       
        d(i) =  (2.0 + h*h*v(t))      
        c(i) = -(1.0 - (h*0.5)*w(t))       
        b(i) = -h*h*u(t)    
      end do
      b(1) = b(1) - a(1)*alpha
      b(n-1) = b(n-1) - c(n-1)*beta 
      do i=1,n-1
         a(i) = a(i+1)
      end do
      call  tri(n-1,a(1:n),d,c,b,y)
      error = exp(ta) - 3.0*cos(ta) - alpha     
      print *,ta,alpha,error
      do i = 9,n-1,9
         t = ta + real(i)*h  
         error = exp(t) - 3.0*cos(t) - y(i)      
         print *,t,y(i),error
     end do
     error = exp(tb) - 3.0*cos(tb) - beta  
     print *,tb,beta,error 
end program main 
  
  
subroutine tri(n,a,d,c,b,x)     
      integer, intent(in)::n
      real, dimension(:), intent(in)::a,d,c,b
      real, dimension(:), intent(out):: x
      integer ::i
      real:: xmult
      do i = 2,n
        xmult = a(i-1)/d(i-1) 
        d(i) = d(i) - xmult*c(i-1)    
        b(i) = b(i) - xmult*b(i-1)    
      end do
      x(n) = b(n)/d(n)      
      do i = n-1,1,-1     
        x(i) = (b(i) - c(i)*x(i+1))/d(i)
      end do
end subroutine tri
  


