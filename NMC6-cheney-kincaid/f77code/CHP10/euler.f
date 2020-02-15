C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: euler.f
C
C EULER'S METHOD FOR SOLVING AN ORDINARY DIFFERENTIAL EQUATION
C
      DOUBLE PRECISION A,B,S,T,H,X,F
      DATA  A/1.0/, B/2.0/, S/-4.0/, N/128/
      F(T,X) = 1.0 + X*X + T**3 
      H = (B - A)/REAL(N)   
      X = S 
      T = A 
      PRINT *,0,T,X 
      DO 2 K = 1,N
        X = X + H*F(T,X)
        T = T + H 
        PRINT 3,K,T,X 
   2  CONTINUE
   3   FORMAT(5X,I5,5X,F10.5,5X,E19.11)
       STOP
      END 
