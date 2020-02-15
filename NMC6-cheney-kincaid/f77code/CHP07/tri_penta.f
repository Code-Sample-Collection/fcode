C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: tri_penta.F
C
C SOLVES TRIDIAGONAL & PENTADIAGONAL LINEAR SYSTEMS (TRI,PENTA)
C
      DIMENSION E(10),A(10),D(10),C(10),F(10),B(10),X(10) 
      N = 10      
      DO 2 I=1,N  
      E(I) = 0.25 
      A(I) = 0.25
      C(I) = 0.25
      F(I) = 0.25 
      D(I) = 1.0   
2     B(I) = 2.0   
      B(1) = 1.5
      B(N) = 1.5     
      B(2) = 1.75
      B(N-1) = 1.75  
C       
      CALL PENTA(N,E,A,D,C,F,B,X)     
C       
      PRINT 10,X  
C       
      DO 20 I=1,N 
      D(I) =2.    
      A(I) = 0.5
      C(I) = 0.5      
20    B(I) = 3.0   
      B(1) = 2.5
      B(N) = 2.5     
C       
      CALL TRI(N,A,D,C,B,X) 
C       
      PRINT 10,X  
C       
      DO 25 I=1,N 
      D(I) = 2.0    
      C(I) = 0.5   
25    B(I) = 3.0   
      B(1) = 2.5
      B(N) = 2.5     
C       
      CALL TRI(N,C,D,C,B,X) 
C       
      PRINT 10,X  
      STOP
10    FORMAT(5X,3E22.14)    
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
  
      SUBROUTINE PENTA(N,E,A,D,C,F,B,X) 
      DIMENSION  E(N),A(N),D(N),C(N),F(N),B(N),X(N) 
      DO 2 I = 2,N-1
        XMULT = A(I-1)/D(I-1) 
        D(I) = D(I) - XMULT*C(I-1)    
        C(I) = C(I) - XMULT*F(I-1)    
        B(I) = B(I) - XMULT*B(I-1)    
        XMULT = E(I-1)/D(I-1) 
        A(I) = A(I) - XMULT*C(I-1)  
        D(I+1) = D(I+1) - XMULT*F(I-1)
        B(I+1) = B(I+1) - XMULT*B(I-1)
   2  CONTINUE    
      XMULT = A(N-1)/D(N-1) 
      D(N) = D(N) - XMULT*C(N-1)      
      X(N) = (B(N) - XMULT*B(N-1))/D(N) 
      X(N-1) = (B(N-1) - C(N-1)*X(N))/D(N-1)    
      DO 3 I = N-2,1,-1     
        X(I) = (B(I) - F(I)*X(I+2) - C(I)*X(I+1))/D(I)    
   3  CONTINUE    
      RETURN      
      END 
