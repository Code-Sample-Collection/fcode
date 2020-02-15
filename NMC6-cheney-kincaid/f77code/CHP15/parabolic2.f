C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: parabolic2.F
C
C PARABOLIC PDE PROBLEM SOLVED BY CRANK-NICOLSON METHOD (TRI)
C
      DIMENSION  C(9),D(9),U(9),V(9)  
      DATA  N/9/, H/0.1/, HK/0.005/   
      PI = 4.0*ATAN(1.0)    
      PI2 = PI*PI 
      S = H*H/HK  
      R = 2.0 + S 
      DO 2 I = 1,N
        D(I) = R  
        C(I) = -1.0 
        U(I) = SIN(PI*REAL(I)*H)      
   2  CONTINUE
      PRINT 7,(U(I),I = 1,N)
      DO 6 J = 1,20 
        DO 3 I = 1,N
          D(I) = R
          V(I) = S*U(I)     
   3    CONTINUE
        CALL TRI(N,C,D,C,V,V) 
        PRINT 7,(V(I),I = 1,N)
        T = REAL(J)*HK      
        DO 4 I = 1,N
   4    U(I) = EXP(-PI2*T)*SIN(PI*REAL(I)*H) - V(I)       
        PRINT 7,(U(I),I = 1,N)
        DO 5 I = 1,N
          U(I) = V(I)       
   5    CONTINUE
   6  CONTINUE    
   7  FORMAT(//(5(5X,E22.14)))
      STOP
      END 
  
      SUBROUTINE TRI(N,A,D,C,B,X)     
      DIMENSION  A(N),D(N),C(N),B(N),X(N) 
      DO 2 I = 2,N
        XMULT = A(I-1)/D(I-1) 
        D(I) = D(I) - XMULT*C(I-1)    
        B(I) = B(I) - XMULT*B(I-1)    
   2  CONTINUE    
      X(N) = B(N)/D(N)      
      DO 3 I = N-1,1,-1     
        X(I) = (B(I) - C(I)*X(I+1))/D(I)
   3  CONTINUE    
      RETURN      
      END 
