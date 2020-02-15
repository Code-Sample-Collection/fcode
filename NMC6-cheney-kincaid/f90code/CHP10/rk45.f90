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
! File: rk45.f90
!
! Runge-Kutta-Fehlberg method for solving an initial value problem (rk45,f)  
                                                                           !
program main
      real ::a=1.0, b=1.5625, x=2.0,t,h,e
      integer ::n=72, i
     
      interface 
      function f(t,x)
      real, intent(in) :: t, x
      end function f
      end interface     

      h=(b-a)/real(n)
      t=a
      print *,"0",t,x 
      do i=1,n
         call rk45(f,t,x,h,e)
         print *,t,x,e
      end do
end program main

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



                                                                      
