C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: bvp2.f
C
C BOUNDARY VALUE PROBLEM SOLVED BY SHOOTING METHOD (RK4SYS,XPSYS)
C
      DIMENSION  X(5),X2(99),X4(99)   
      DATA  NP1/99/, TA/1.0/, TB/2.0/ 
      DATA  ALPHA/1.09737491/, BETA/8.63749661/ 
      DATA  X/1.0,1.09737491,0.0,1.09737491,1.0/
      H = (TB - TA)/REAL(NP1) 
      T = TA      
      DO 2 I = 1,NP1
        CALL RK4SYS(5,T,X,H,1,0)      
        X2(I) = X(2)
        X4(I) = X(4)
        T = TA + REAL(I)*H  
   2  CONTINUE
      P = (BETA - X4(NP1))/(X2(NP1) - X4(NP1))  
      Q = 1.0 - P 
      DO 3 I = 1,NP1
        X2(I) = P*X2(I) + Q*X4(I)     
   3  CONTINUE
      ERROR = EXP(TA) - 3.0*COS(TA) - ALPHA     
      PRINT 5,TA,ALPHA,ERROR
      DO 4 I = 9,NP1,9      
        T = TA + REAL(I)*H  
        ERROR = EXP(T) - 3.0*COS(T) - X2(I)     
        PRINT 5,T,X2(I),ERROR 
   4  CONTINUE
   5  FORMAT(5X,F10.5,2(5X,E22.14))   
      STOP
      END 
        
      SUBROUTINE XPSYS(X,F) 
      DIMENSION  X(5),F(5)  
      F(1) = 1.0  
      F(2) = X(3) 
      F(3) = EXP(X(1)) - 3.0*SIN(X(1)) + X(3) - X(2)      
      F(4) = X(5) 
      F(5) = EXP(X(1)) - 3.0*SIN(X(1)) + X(5) - X(4)      
      RETURN      
      END 
        
      SUBROUTINE RK4SYS(N,T,X,H,NSTEP,J)
      DIMENSION  X(10),Y(10),F1(10),F2(10),F3(10),F4(10)  
      H2 = 0.5*H  
      START = T   
      DO 6 K = 1,NSTEP      
      CALL XPSYS(X,F1)      
      DO 2 I = 1,N
   2  Y(I) = X(I) + H2*F1(I)
      CALL XPSYS(Y,F2)      
      DO 3 I = 1,N
   3  Y(I) = X(I) + H2*F2(I)
      CALL XPSYS(Y,F3)      
      DO 4 I = 1,N
   4  Y(I) = X(I) + H*F3(I) 
      CALL XPSYS(Y,F4)      
      DO 5 I = 1,N
   5  X(I) = X(I) + H*(F1(I) + 2.0*(F2(I) + F3(I)) + F4(I))/6.0     
      T = START + REAL(K)*H 
   6  IF(K .EQ. (K/J)*J)  PRINT 7,T,(X(I),I = 1,N)
   7  FORMAT(5X,F10.5,4(5X,E22.14))   
      RETURN      
      END 
