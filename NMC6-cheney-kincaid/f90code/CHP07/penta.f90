!
! Numerical Mathematics and Computing, Fith Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 7.3
!
! File: penta.f
!
! Solves pentadiagonal linear systems (penta)
! the solution for each system is x(i)=1

program main
      real, dimension (10):: e,a,d,c,f,b,x
      integer ::n = 10      

interface                                                       
      subroutine penta(n,e,a,d,c,f,b,x)
      integer, intent(in)::n
      real, dimension(:), intent(in)::e,a,d,c,f,b
      real, dimension(:), intent(out)::x
      end subroutine penta
end interface
      do  i=1,n  
      e(i) = 0.25 
      a(i) = 0.25
      c(i) = 0.25
      f(i) = 0.25 
      d(i) = 1.0   
      b(i) = 2.0   
      end do
      b(1) = 1.5
      b(n) = 1.5     
      b(2) = 1.75
      b(n-1) = 1.75  
      call penta(n,e,a,d,c,f,b,x)     
      print*, "This is from the subroutine penta." 
      print "(f22.14)",(x(i), i=1,n)  
end program main
  
subroutine penta(n,e,a,d,c,f,b,x) 
      integer, intent(in)::n
      real, dimension(:), intent(in)::e,a,d,c,f,b
      real, dimension(:), intent(out):: x
      integer :: i
      real :: xmult
      do i = 2,n-1
        xmult = a(i-1)/d(i-1) 
        d(i) = d(i) - xmult*c(i-1)    
        c(i) = c(i) - xmult*f(i-1)    
        b(i) = b(i) - xmult*b(i-1)    
        xmult = e(i-1)/d(i-1) 
        a(i) = a(i) - xmult*c(i-1)  
        d(i+1) = d(i+1) - xmult*f(i-1)
        b(i+1) = b(i+1) - xmult*b(i-1)
      end do
      xmult = a(n-1)/d(n-1) 
      d(n) = d(n) - xmult*c(n-1)      
      x(n) = (b(n) - xmult*b(n-1))/d(n) 
      x(n-1) = (b(n-1) - c(n-1)*x(n))/d(n-1)    
      do i = n-2,1,-1     
        x(i) = (b(i) - f(i)*x(i+2) - c(i)*x(i+1))/d(i)    
      end do
 end subroutine penta 
                                                                             
