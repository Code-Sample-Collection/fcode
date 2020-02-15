C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: rk4.f
C
C RUNGE-KUTTA METHOD OF ORDER 4 FOR SOLVING AN INITIAL VALUE PROBLEM (RK4,F)
C
      EXTERNAL F
      DATA T/1.0/, X/2.0/, H/7.8125E-3/, NSTEP/72/
      CALL RK4(F,T,X,H,NSTEP) 
      STOP
      END 
  
      FUNCTION F(T,X) 
      F = 2.0+(X-T-1.0)**2  
      RETURN
      END 
  
      SUBROUTINE RK4(F,T,X,H,NSTEP)   
      PRINT 3,T,X 
      H2 = 0.5*H
      START = T   
      DO 2 K = 1,NSTEP      
        F1 = H*F(T,X)       
        F2 = H*F(T + H2,X + 0.5*F1)   
        F3 = H*F(T + H2,X + 0.5*F2)   
        F4 = H*F(T + H,X + F3)
        X = X + (F1 + F2 + F2  + F3 + F3 + F4)/6.0
        T = START + H*REAL(K) 
        PRINT 3,T,X 
   2  CONTINUE
   3  FORMAT(5X,2E22.14)    
      RETURN
      END 
