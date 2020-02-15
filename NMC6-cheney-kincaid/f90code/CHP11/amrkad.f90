!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! (c) 2003
!
! Section 11.3
!
! file: amrkad.f90
!
! adaptive scheme for adams-moulton method for systems of ode's
!  (amrkad,xpsys,amrk,amsys,rksys)

program main
      integer, parameter :: n = 5
      real:: ta,tb,h,emin, emax,hmin, hmax
      integer :: itmax,iflag
      real, dimension(0:n) :: x
      itmax = 25
      ta = 0.0
      tb = 1.0    
      t = ta    
      x = (/1.0,2.0,-4.0,-2.0,7.0,6.0/)      
      h = (tb -ta)/itmax
      emin = 1.0e-8  
      emax = 1.0e-2      
      hmin = 1.0e-4   
      hmax = 1.0
      print "(2x,'ta and h:',(2x,2f10.5))",ta,h 
      print "(5x,7e15.8)",(x(i),i=0,n)
      call amrkad(n,h,t,tb,x,itmax,emin,emax,hmin,hmax,iflag)       
      print "('0  iflag =',i2)", iflag 
end program main
  
subroutine xpsys(n,x,f)
      integer n
      real, dimension (0:n) :: x, f
      f(0) = 1.0
      f(1) = x(2)  
      f(2) = x(1)-x(3)- 9*x(2)**2 + x(4)**3 + 6*x(5) + 2*x(0)
      f(3) = x(4)
      f(4) = x(5)
      f(5)  = x(5) -x(2) + exp(x(1)) - x(0)
end subroutine xpsys

subroutine amrkad(n,h,t,tb,x,itmax,emin,emax,hmin,hmax,iflag)   
      integer :: itmax,iflag,m,irk,iam,nstep,i
      real, parameter :: epsi = 1.0e-6   
      real :: t,h,tb,emin,emax,hmin,hmax,dt
      real, dimension (0:n)  :: x
      real, allocatable :: z(:,:), f(:,:)
      allocate (f(0:n,0:4),z(0:n,0:4))
      m = 0       
      irk = 3     
      iam = 0     
      iflag = 3   
      nstep = 0  
      print "(2x,'initial values: nstep,t,h:',i5,1x,2(e10.3,1x))",nstep,t,h
      print "(8x,'x:',5(5x,e22.14))", x
      do i=0,n  
         z(i,m) = x(i)
      end do

      if (abs(tb - t) < abs(4.0*h)) h = 0.25*h

all: do
      if (abs(h) < hmin) then
         h = sign(1.0,h)*hmin
         iflag = 2
      end if   
      if (abs(h) > hmax) then
         h = sign(1.0,h)*hmax
         iflag =2
      end if

      dt = abs(tb - t)       
      if (dt < abs(h))  then
         iflag = 0   
         if (dt <= epsi*max(abs(tb),abs(t)))  exit
         h = sign(1.0,dt)*h
     irk = 1
     iam = 0
     if ( (abs(h) < hmin) .or. (abs(h) > hmax)) then
            iflag = 2
        exit
     end if
      end if

      if (iam == 0)  then
         do k=1,irk
            call rk4sys(m,n,h,z,f)
            nstep = nstep + 1
            t = t + h
            print "(2x,'RK: nstep,t,h:',i5,1x,2(e10.3,1x))",nstep,t,h
            print "(8x,'x:',5(5x,e22.14))", (z(i,m),i=0,n) 
         end do
         if (nstep > itmax .or. irk == 1)  exit
      end if

      call amsys(m,n,h,z,f,est)     
      nstep = nstep + 1     
      t = t + h
      print "(2x,'AM: nstep,t,h,est:',i5,1x,3(e10.3,1x))",nstep,t,h,est      
      print "(8x,'x:',5(5x,e22.14))",(z(i,m),i=1,n) 
      if(nstep > itmax .or. iflag == 0)  exit
      
      if (emin <= est .and. est <= emax) then
         irk = 0
         iam =  1     
      else
         t = t - 4.0*h
         nstep = nstep - 4
         m = 0
         irk = 3
         iam = 0
         if (est < emin)  then
            h = 2.0*h
         end if
         if (est > emax)  then      
            h = 0.5*h   
         end if
         if ( (abs(h) < hmin) .or. (abs(h) > hmax)) then
            iflag = 2
            exit
         end if
      end if

end do all       

      iflag = 1   
       do i=0,n  
         x(i) = z(i,m)
      end do
      deallocate (f,z)
end subroutine amrkad
  
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





