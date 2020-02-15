C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: newton.f
C
C SAMPLE NEWTON METHOD PROGRAM
C 
      DOUBLE PRECISION X,F,G,FX       
      F(X) = ((X - 2.0D0)*X + 1.0D0)*X - 3.0D0  
      G(X) = (3.0D0*X - 4.0D0)*X + 1.0D0
      X  =  4.0D0 
      PRINT 3     
      FX = F(X)   
      PRINT 4,0,X,FX
      DO 2 N = 1,10 
        X = X - FX/G(X)     
        FX = F(X) 
        PRINT 4,N,X,FX      
   2  CONTINUE    
   3  FORMAT(//9X,'N',24X,'X',26X,'F(X)',//)  
   4  FORMAT(5X,I5,5X,D36.28,5X,E10.3)
      STOP
      END 
