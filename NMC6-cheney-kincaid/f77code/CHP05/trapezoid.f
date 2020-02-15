C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: trapezoid.f
C
C TRAPEZOID RULE PROGRAMMING EXPERIMENT FOR AN INTEGRAL
C
      DATA  N/60/ 
      F(X) = 1.0/EXP(X*X) 
      H = 1.0/(N-1) 
      SUM = 0.5*(F(0.0) + F(1.0))     
      DO 2 I=2,N-1
        XI = (I-1)*H
        SUM = SUM + F(XI)   
   2  CONTINUE
      SUM = H*SUM 
      PRINT *,SUM 
      STOP
      END 
