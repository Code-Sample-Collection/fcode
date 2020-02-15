!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 7.1
!
! File: ngauss.f
!
! Naive Gaussian elimination with subroutine ngauss

program gaulim
      integer, parameter :: ia=15
      real, dimension (ia, ia):: a
      real, dimension (ia)::x, b
      integer:: i,j,n

interface
      subroutine ngauss(n,a,ia,b,x)
      integer, intent(in)::n,ia
      real, dimension(:,:), intent(in)::a
      real, dimension(:), intent(in)::b
      real, dimension(n), intent(out)::x
      end subroutine ngauss
end interface
      do n=2,15
         do i=1,n
            do j=1,n
               a(i,j)=real(i+1)**(j-1)
            end do
            b(i)=(real(i+1)**n-1.0)/real(i)
         end do
      call ngauss(n,a,ia,b,x)
      print*, "n = ", n
      print "(f22.14)", (x(i),i=1,n)
      end do
end program gaulim
  
subroutine ngauss(n,a,ia,b,x)    
      integer, intent(in) :: n, ia
      real, dimension (:,:), intent(in)::a
      real, dimension (:), intent(in)::b
      real, dimension(n), intent(out)::x
      integer :: i,j,k
      do  k = 1,n-1
         do i = k+1,n
            xmult = a(i,k)/a(k,k)   
            do j = k+1,n    
            a(i,j) = a(i,j) - xmult*a(k,j) 
         end do 
         a(i,k) = xmult
         b(i)=b(i)-xmult*b(k)
        end do 
     end do   
      x(n)=b(n)/a(n,n)
      do i=n-1,1,-1
        sum=b(i)
        do j=i+1, n
           sum=sum-a(i,j)*x(j)
        end do
        x(i)=sum/a(i,i)
      end do
end subroutine ngauss 
  
