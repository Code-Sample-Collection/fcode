C
C  NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: rk4sys.f
C
C RUNGE-KUTTA METHOD OF ORDER 4 FOR A SYSTEM OF ODE'S (RK4SYS,XPSYS)
C
      DIMENSION  X(3) 
      DATA  N/3/, T/0.0/, X/0.0,1.0,0.0/
      DATA  H/0.01/, NSTEP/100/ 
      CALL RK4SYS(N,T,X,H,NSTEP)
      STOP
      END 
  
      SUBROUTINE XPSYS(X,F) 
      DIMENSION  X(3),F(3)  
      F(1) = 1.0
      F(2) = X(2) - X(3) + X(1)*(2.0 - X(1)*(1.0+ X(1)))  
      F(3) = X(2) + X(3) - X(1)*X(1)*(4.0 - X(1)) 
      RETURN
      END 

      SUBROUTINE RK4SYS(N,T,X,H,NSTEP)
      DIMENSION  X(10),Y(10),F1(10),F2(10),F3(10),F4(10)  
      PRINT 7,T,(X(I),I=1,N)
      H2 = 0.5*H  
      START = T   
      DO 6 K = 1,NSTEP      
        CALL XPSYS(X,F1)    
        DO 2 I = 1,N
          Y(I) = X(I) + H2*F1(I)      
   2    CONTINUE
        CALL XPSYS(Y,F2)    
        DO 3 I = 1,N
          Y(I) = X(I) + H2*F2(I)      
   3    CONTINUE
        CALL XPSYS(Y,F3)    
        DO 4 I = 1,N
          Y(I) = X(I) + H*F3(I)       
   4    CONTINUE
        CALL XPSYS(Y,F4)    
        DO 5 I = 1,N
          X(I) = X(I) + H*(F1(I) + 2.0*(F2(I) + F3(I)) + F4(I))/6.0 
   5    CONTINUE
        T = START + REAL(K)*H 
        PRINT 7,T,(X(I),I = 1,N)      
   6  CONTINUE
   7  FORMAT(2X,'T,X:',E10.3,5(2X,E22.14))
      RETURN      
      END 

