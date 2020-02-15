C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: sums.f
C
C UPPER AND LOWER SUMS PROGRAMMING EXPERIMENT FOR AN INTEGRAL
C
      DATA  N/1000/ 
      H = 1.0/REAL(N-1)     
      SUM = 0.0   
      DO 2 I = N-1,1,-1     
        X = H*REAL(I)       
        SUM = SUM + EXP(-X*X) 
   2  CONTINUE    
      SUMLO = H*SUM 
      SUMUP = SUMLO + H*(1.0 - EXP(-1.0))       
      PRINT *,'SUMLO =',SUMLO,'SUMUP =',SUMUP 
      STOP
      END 
