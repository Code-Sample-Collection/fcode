C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: taysys.f
C
C TAYLOR SERIES METHOD (ORDER 4) FOR SYSTEM OF ORDINARY DIFFERENTIAL EQUATIONS
C
      DATA  T/0.0/, X/1.0/, Y/0.0/, H/0.01/, NSTEP/100/   
      PRINT *,T,X,Y 
      DO 2 K = 1,NSTEP      
        X1 = X - Y + T*(2.0 - T*(1.0 + T))      
        Y1 = X + Y + T*T*(-4.0 + T)   
        X2 = X1 - Y1 + 2.0 - T*(2.0 + 3.0*T)    
        Y2 = X1 + Y1 + T*(-8.0 + 3.0*T) 
        X3 = X2 - Y2 - 2.0 - 6.0*T    
        Y3 = X2 + Y2 - 8.0 + 6.0*T    
        X4 = X3 - Y3 - 6.0  
        Y4 = X3 + Y3 + 6.0  
        X = X + H*(X1 + H*(X2/2.0 + H*(X3/6.0 + H*X4/24.0)))
        Y = Y + H*(Y1 + H*(Y2/2.0 + H*(Y3/6.0 + H*Y4/24.0)))
        T = REAL(K)*H       
        PRINT *,T,X,Y       
   2  CONTINUE    
      STOP
      END 
