C
C PAGE 208-209: NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: NGAUSS.FOR
C
C NAIVE GAUSSIAN ELIMINATION TO SOLVE LINEAR SYSTEMS (NGAUSS)
C
      PARAMETER  (IA = 15)
      DIMENSION A(IA,IA),X(IA),B(IA)  
      DO 4 N = 10,15
        DO 3 I = 1,N
          DO 2 J = 1,N      
            A(I,J) = REAL(I+1)**(J-1) 
   2      CONTINUE
          B(I) = (REAL(I+1)**N - 1.0)/REAL(I)   
   3    CONTINUE  
        CALL NGAUSS(N,A,IA,B,X)       
        PRINT 5,N,(X(I),I=1,N)
   4  CONTINUE    
   5  FORMAT(//,'N = ',I2,//,(2X,3E22.14))      
      STOP
      END 
  
      SUBROUTINE NGAUSS(N,A,IA,B,X)   
      DIMENSION A(IA,N),B(N),X(N)     
      DO 4 K = 1,N-1
        DO 3 I = K+1,N      
          XMULT = A(I,K)/A(K,K)       
          DO 2 J = K+1,N    
            A(I,J) = A(I,J) - XMULT*A(K,J)      
   2      CONTINUE
          A(I,K) = XMULT
          B(I) = B(I) - XMULT*B(K)    
   3    CONTINUE  
   4  CONTINUE    
      X(N) = B(N)/A(N,N)
      DO 6 I = N-1,1,-1     
        SUM = B(I)
        DO 5 J = I+1,N      
          SUM = SUM - A(I,J)*X(J) 
   5    CONTINUE  
        X(I) = SUM/A(I,I)   
   6  CONTINUE    
      RETURN
      END 
