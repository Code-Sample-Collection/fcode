C
C PAGE 261: NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: SPL1.FOR
C
C INTERPOLATES TABLE USING A FIRST-DEGREE SPLINE FUNCTION (SPL1)
C
      DIMENSION T(10),Y(10),Z(11),C(10) 
      DATA (T(I),I=1,5)/1.,2.,3.,4.,5./
      DATA (Y(I),I=1,5)/0.,1.,0.,1.,0./
C       
      N = 5       
      Z(1) = SPL1(N,T,Y,1.) 
      Z(2) = SPL1(N,T,Y,2.) 
      Z(3) = SPL1(N,T,Y,3.) 
      Z(4) = SPL1(N,T,Y,4.) 
      Z(5) = SPL1(N,T,Y,5.) 
      Z(6) = SPL1(N,T,Y,-0.5) 
      Z(7) = SPL1(N,T,Y,1.25)
      Z(8) = SPL1(N,T,Y,2.75)
      Z(9) = SPL1(N,T,Y,3.5)
      Z(10) = SPL1(N,T,Y,4.25)
      Z(11) = SPL1(N,T,Y,5.5)
C       
      PRINT 5,Z   
    5 FORMAT(5X,10F10.5)    
      END 
  
      FUNCTION SPL1(N,T,Y,X)
      DIMENSION  T(N),Y(N)  
      DO 2 I = N-1,2,-1     
        DIFF = X - T(I)     
        IF(DIFF .GE. 0.0)  GO TO 3    
   2  CONTINUE    
      I = 1     
      DIFF = X - T(1)       
   3  XM = (Y(I+1) - Y(I))/(T(I+1) - T(I))      
      SPL1 = Y(I) + XM*DIFF 
      RETURN      
      END 
