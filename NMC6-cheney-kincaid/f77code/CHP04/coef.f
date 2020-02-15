C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: coef.f
C
C NEWTON INTERPOLATION POLYNOMIAL FOR SIN(X) AT EQUIDISTANT POINTS (COEF,EVAL)
C
      PARAMETER (N=10)
      DIMENSION X(N),Y(N),A(N)
      H = 1.6875/REAL(N-1)
      DO 2 I=1,N  
        X(I) = REAL(I-1)*H  
        Y(I) = SIN(X(I))    
   2  CONTINUE    
      CALL COEF(N,X,Y,A)    
      PRINT 3,(A(I), I=1,N) 
   3  FORMAT(2X,5E22.14,//) 
      DO 4 I = 1,4*N-3      
        T = REAL(I-1)*H*0.25
        D = SIN(T) - EVAL(10,X,A,T)   
        PRINT 5,I,T,D       
   4  CONTINUE    
   5  FORMAT(2X,I5,F22.14,E10.3)      
      STOP
      END 
  
      SUBROUTINE COEF(N,X,Y,A)
      DIMENSION X(N),Y(N),A(N)
      DO 2 I = 1,N
        A(I) = Y(I) 
   2  CONTINUE    
      DO 4 J = 1,N-1
        DO 3 I = N,J+1,-1   
          A(I) = (A(I) - A(I-1))/(X(I) - X(I-J))
   3    CONTINUE  
   4  CONTINUE
      RETURN
      END 
  
      FUNCTION EVAL(N,X,A,T)
      DIMENSION X(N),A(N)   
      EVAL = A(N) 
      DO 2 I=N-1,1,-1 
        EVAL = EVAL*(T - X(I)) + A(I) 
   2  CONTINUE    
      RETURN      
      END 
