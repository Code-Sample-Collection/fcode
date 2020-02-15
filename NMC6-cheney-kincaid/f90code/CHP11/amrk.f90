!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Using the Computer Problem Chapter 11
!
! file: amrk.f90
!
! Adams-Moulton method for systems of ode's (amrk,rksys,amsys,xpsys)

program main
      integer, parameter :: n = 5, nsteps = 100
      real, parameter :: a = 0.0, b = 1.0
      real ::  h    
      real, dimension (0:n) :: x

      x = (/1.0,2.0,-4.0,-2.0,7.0,6.0/)
      h = (b - a)/nsteps
      call amrk(n,h,x,40)
end program main
  
subroutine xpsys(n,x,f) 
      real, dimension (0:n) :: x, f   
      integer n
      f(0) = 1.0  
      f(1) = x(2)
      f(2) = x(1)-x(3)- 9*x(2)**2 +x(4)**3+ 6*x(5)+ 2*x(0)
      f(3) = x(4)
      f(4) = x(5)
      f(5) = x(5) -x(2) + exp(x(1)) - x(0)
end subroutine xpsys
  
subroutine amrk(n,h,x,nsteps)  
      integer :: n, nsteps, m, i, k
      real :: h, est
      real, dimension (0:n) :: x
      real, allocatable :: z(:,:), f(:,:)
      allocate (f(0:n,0:4),z(0:n,0:4))
      m = 0       
      do i=0,n  
        z(i,m) = x(i)       
      end do
      do k=1,3
         call rk4sys(m,n,h,z,f)
        print *,"k=",k
         print *,"z",(z(i,m),i=0,n)
      end do   
      do k = 4,nsteps
        call amsys(m,n,h,z,f,est)
        print *,"k = ", k
        print *, "est = ",est
        print *,"z",(z(i,m),i=0,n)
      end do
      do i=0,n  
        x(i) = z(i,m)       
      end do
      deallocate (f,z)
end subroutine amrk 
  
subroutine rk4sys(m,n,h,z,f)
      real, dimension (0:n,0:4) ::  f, z
      real, allocatable :: y(:), g(:,:)
      integer :: i, n, m,mp1
      real :: h
      allocate (y(0:n), g(0:n,3))
      mp1 = mod(1+m,5) 
        call xpsys(n,z(0,m),f(0,m))
in1:    do i = 0,n
          y(i) = z(i,m) + 0.5*h*f(i,m)      
        end do in1
        call xpsys(n,y,g(0,1))
in2:    do i = 0,n
          y(i) = z(i,m) + 0.5*h*g(i,1)      
        end do in2
        call xpsys(n,y,g(0,2))    
in3:    do i = 0,n
          y(i) = z(i,m) + h*g(i,2)       
        end do in3
        call xpsys(n,y,g(0,3))    
in4:    do i = 0,n
 z(i,mp1) = z(i,m) + h*(f(i,m) + 2.0*(g(i,1) + g(i,2)) + g(i,3))/6.0
        end do in4
      m = mp1
      deallocate (y)
end subroutine rk4sys 
  
subroutine amsys(m,n,h,z,f,est)
      real ::  h, est,dlt, dltmax
      integer :: n, m, mp1,k,i,j
      real, dimension (0:n,0:4) :: f, z
      real, allocatable :: sum(:), y(:)
      dimension cp(4), cc(4)
      real, parameter :: cp = (/55.0,-59.0,37.0,-9.0/)  
      real, parameter :: cc = (/ 9.0, 19.0,-5.0, 1.0/)
      allocate (sum(0:n), y(0:n))
      mp1 = mod(m+1,5)    
      call  xpsys(n,z(0,m),f(0,m))       
       do i = 0,n
        sum(i) = 0.0
      end do
outer: do k = 1,4
         j = mod(m-k+6,5)
 inner:   do i = 0,n
           sum(i) = sum(i) + cp(k)*f(i,j)
         end do inner  
       end do outer
      do i = 0,n
        y(i) = z(i,m) + h*sum(i)/24.0
      end do    
      call xpsys(n,y,f(0,mp1)) 
      do i = 0,n
        sum(i) = 0.0
      end do    
      do k = 1,4
        j = mod(mp1-k+6,5)
         do i = 0,n
          sum(i) = sum(i) + cc(k)*f(i,j)
        end do  
      end do
      do i = 0,n
        z(i,mp1) = z(i,m) + h*sum(i)/24.0
      end do
       dltmax = 0.0
      do i = 0,n 
        dlt = abs( (z(i,mp1) - y(i)))/ abs(z(i,mp1) )   
         if(dlt .gt. dltmax) then      
          dltmax = dlt      
          idlt = i
        end if    
      end do    
      est = (19.0/270.0)*dltmax
      m = mp1
      deallocate (sum,y)
 end subroutine amsys 




