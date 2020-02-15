C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: taylor.f
C
C TAYLOR SERIES METHOD (ORDER 4) FOR SOLVING AN ORDINARY DIFFERENTIAL EQUATION
C
      DOUBLE PRECISION A,B,X,H,T,X,X1,X2,X3,X4
      DATA  A/1.00/, B/2.00/, X/-4.0/, N/128/
      H = (B-A)/REAL(N)
      T = A
      PRINT 3,0,T,X 
      DO 2 K=1,N
        X1 = 1.0 + X*X + T**3 
        X2 = 2.0*X*X1 + 3.0*T*T       
        X3 = 2.0*X*X2 + 2.0*X1*X1 + 6.0*T       
        X4 = 2.0*X*X3 + 6.0*X1*X2 + 6.0 
        X = X + H*(X1 + H*(X2/2.0 + H*(X3/6.0 + H*X4/24.0)))
        T = A+ REAL(K)*H       
      PRINT 3,K,T,X 
   2  CONTINUE
   3  FORMAT(5X,I5,5X,F10.5,5X,E19.11)      
      STOP
      END 
