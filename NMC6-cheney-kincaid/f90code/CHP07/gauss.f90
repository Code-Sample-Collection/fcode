!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 7.2
!
! File: gauss.f
!
! Gaussian elimination with scaled partial pivoting (gauss,solve,tstgaus)

program pgauess
      integer, parameter :: n=4, ia=4
      real, dimension (ia,n):: a 
      real, dimension (n)::s,b,x
      integer, dimension(n)::l
interface
      subroutine gauss(n,a,ia,l,s)
      integer, intent(in) :: n,ia
      real, dimension (:,:), intent(inout)::a
      real, dimension (n)::s
      integer, dimension(n) , intent(out)::l
      end subroutine gauss
      subroutine solve(n,a,ia,l,b,x)
      integer, intent(in)::n,ia
      real, dimension(:,:), intent(in)::a
      real, dimension(:), intent(in) :: b
      integer, dimension(n), intent(in)::l
      real, dimension(n), intent(out) :: x
      end subroutine solve
end interface

      a(1,1)=3.0; a(1,2)=-13.0; a(1,3)=9.0; a(1,4)=3.0
      a(2,1)=-6.0; a(2,2)=4.0; a(2,3)=1.0; a(2,4)=-18.0
      a(3,1)=6.0; a(3,2)=-2.0; a(3,3)=2.0; a(3,4)=4.0
      a(4,1)=12.0; a(4,2)=-8.0; a(4,3)=6.0; a(4,4)=10.0
      print*, "the coefficient matrix a"
      b(1)=-19.0; b(2)=-34.0; b(3)=16.0; b(4)=26.0
      do i=1,n
      print*, (a(i,j),j=1,n)
      end do
      print*, "the following are the constants b(i)"
      print*, (b(i), i=1,n)
      call  gauss(n,a,n,l,s)
      print*, "the matrix a after gauss"
      do i=1,n
         print*, (a (i,j), j=1,n)
      end do
      call solve(n,a,ia,l,b,x)
      print*, "the solution x(i) ", (x(i), i=1,n)
end program pgauess
  
subroutine gauss(n,a,ia,l,s)    
      integer, intent(in) :: n, ia
      real, dimension (:,:), intent(inout):: a
      real, dimension (n):: s
      integer, dimension(n), intent(out)::l
      do  i = 1,n
        l(i) = i  
        smax = 0.0
        do j = 1,n
          smax = amax1(smax,abs(a(i,j)))
        end do
        s(i) = smax 
    end do 
     do  k = 1,n-1
        rmax = -1.0
        do i = k,n
          r = abs(a(l(i),k))/s(l(i))  
          if(r <= rmax)  exit    
          j = i   
          rmax = r
         end do 
  
        lk = l(j) 
        l(j) = l(k) 
        l(k) = lk  
        do i = k+1,n      
          xmult = a(l(i),k)/a(lk,k)   
          do j = k+1,n    
            a(l(i),j) = a(l(i),j) - xmult*a(lk,j) 
          end do 
          a(l(i),k) = xmult 
        end do 
     end do   
end subroutine gauss 
  
subroutine solve(n,a,ia,l,b,x)  
      integer, intent(in) :: n, ia
      real, dimension (:,:), intent(in):: a
      real, dimension (:), intent(in) :: b
      real, dimension (n), intent(out):: x
      integer, dimension(n), intent(in)::l
      integer :: k, i, j
      do k = 1,n-1
         do i = k+1,n      
          b(l(i)) = b(l(i)) - a(l(i),k)*b(l(k)) 
         end do 
     end do 
      x(n) = b(l(n))/a(l(n),n)
     do i = n-1,1,-1     
        sum = b(l(i))       
        do j = i+1,n      
          sum = sum - a(l(i),j)*x(j)  
        end do 
        x(i) = sum/a(l(i),i)
     end do 
end subroutine solve
                                                                          


