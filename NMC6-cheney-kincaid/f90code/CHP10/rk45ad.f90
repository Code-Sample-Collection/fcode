!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 10.3
!
! File: rk45ad.f90
!
! Adaptive scheme based on Runge-Kutta-Fehlberg method (rk45ad,rk45,f)

program main
      real :: t, x, h, tb, emin, emax, hmin, hmax
      integer :: itmax,iflag

      interface 
      function f(t, x)
      real, intent(in) :: t,x
      end function f
      end interface

      t= 1.0 
      x = 2.0 
      h = 7.8125e-3 
      tb = 1.5625 
      itmax = 100 
      emin = 1.0e-8 
      emax = 1.0e-4 
      hmin = 1.0e-6 
      hmax = 1.0
      call rk45ad(f,t,x,h,tb,itmax,emin,emax,hmin,hmax,iflag)    
end program main 
  
subroutine rk45ad(f,t,x,h,tb,itmax,emin,emax,hmin,hmax,iflag) 
      real, intent(in):: t,x,h,tb,emin,emax,hmin,hmax     
      integer, intent(out):: iflag
      integer, intent(in):: itmax
      real ::delta=0.5e-5, d,xsave,tsave
      integer :: k
      
      interface 
      function f(t, x)
      real, intent(in) :: t,x
      end function f
      end interface 

      print*, "print  n    h   t   x"
      print*, "0 "; print "(5x,e10.3,2(5x,e22.14),5x,e10.3)",h,t,x 
  
       iflag = 1 
       k = 0
       do 
       k = k + 1
       if (k > itmax) exit
       if(abs(h) < hmin) h = sign(1.0,h)*hmin
       if(abs(h) > hmax) h = sign(1.0,h)*hmax
       d = abs(tb - t)      

      if(d <= abs(h))  then
        iflag = 0 
        if(d <= delta*max(abs(tb),abs(t))) exit    
        h = sign(1.0,h)*d     
      end if      
      xsave = x   
      tsave = t   
      call rk45(f,t,x,h,e)
      print*, k,h,t,x,e    
      if (iflag == 0) exit
      if(e < emin)  then 
        h = 2.0*h 
        end if
     if (e > emax) then
        h = 0.5*h 
        x = xsave       
        t = tsave
        k = k - 1
      end if      
  end do 
end subroutine rk45ad
  
subroutine rk45(f,t,x,h,e)    
      interface                           
      function f(t,x)                      
      real, intent(in) :: t, x     
      end function f  
      end interface       
                                         
      real, intent(inout):: t,x,h,e        
      real, parameter :: c20=0.25; c21=0.25; &
      c30=0.375; c31=0.09375; c32=0.28125; &
      c40=0.92307692307692; &
      c41=0.87938097405553; c42=-3.2771961766045; c43=3.3208921256258; &
      c51=2.0324074074074; c52=-8.0; c53=7.1734892787524;&
      c54=-0.20589668615984;       & 
      c60=0.5; c61=-0.2962962962963; c62=2.0; &
      c63=-1.3816764132554; c64=0.45297270955166; c65=-0.275; &
      a1=0.11574074074074; a2=0; a3=0.54892787524366; &
      a4=0.5353313840156; a5=-0.2;        &
      b1=0.11851851851852; b2=0.0; b3=0.51898635477583; &
      b4=0.50613149034201; b5=-0.18;      &
      b6=0.036363636363636                           
     
      f1 = h*f(t,x) 
      f2 = h*f(t+ c20*h,x + c21*f1)  
      f3 = h*f(t+ c30*h,x + c31*f1 + c32*f2)   
      f4 = h*f(t+ c40*h,x + c41*f1 + c42*f2 + c43*f3)  
      f5 = h*f(t+h,x + c51*f1 + c52*f2 + c53*f3 + c54*f4)       
      f6 = h*f(t+ c60*h,x + c61*f1 + c62*f2 + c63*f3 + c64*f4 + c65*f5)
      x5 = x + b1*f1 + b3*f3 + b4*f4 + b5*f5 + b6*f6      
      x  = x + a1*f1 + a3*f3 + a4*f4 + a5*f5    
      t = t + h   
      e = abs(x - x5)     
end subroutine rk45
  
      function f(t,x) 
      real, intent(in):: t,x
      f = 2.0+(x-t-1.0)**2  
      end function f 



                                                                      



                                                                             





