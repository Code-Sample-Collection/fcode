C
C PAGE 220-223: NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: GAUSS.FOR
C
C GAUSSIAN ELIMINATION WITH SCALED PARTIAL PIVOTING (GAUSS,SOLVE,TSTGAUS)
C
      DIMENSION A1(4,4),A2(4,4),A3(4,4),B1(4),B2(4),B3(4) 
      DIMENSION L(4),S(4),X(4)
      DATA ((A1(I,J),I=1,4),J=1,4)/3.,1.,6.,0.,4.,5.,3.,0.,3.,-1.,7.,
     A     0.,0.,0.,0.,0./    
      DATA (B1(I),I=1,4)/16.,-12.,102.,0./       
      DATA ((A2(I,J),I=1,4),J=1,4)/3.,2.,1.,0.,2.,-3.,4.,0.,-5.,1.,-1.,
     A     0.,0.,0.,0.,0./  
      DATA (B2(I),I=1,4)/4.,8.,3.,0./  
      DATA ((A3(I,J),I=1,4),J=1,4)/1.,3.,5.,4.,-1.,2.,8.,2.,2.,1.,6.,
     A 5.,1.,4.,3.,3./  
      DATA (B3(I),I=1,4)/5.,8.,10.,12./
C       
      CALL TSTGAUS(3,A1,4,L,S,B1,X)   
      CALL TSTGAUS(3,A2,4,L,S,B2,X)   
      CALL TSTGAUS(4,A3,4,L,S,B3,X)   
      END 
  
      SUBROUTINE TSTGAUS(N,A,IA,L,S,B,X)
      DIMENSION  A(IA,N),B(N),X(N),S(N),L(N)
      PRINT 10,((A(I,J),J=1,N),I=1,N) 
      PRINT 10,(B(I),I=1,N) 
      CALL GAUSS(N,A,IA,L,S)
      CALL SOLVE(N,A,IA,L,B,X)
      PRINT 10,(X(I),I=1,N) 
      RETURN
10    FORMAT(5X,3(F10.5,2X))
      END 
  
      SUBROUTINE GAUSS(N,A,IA,L,S)    
      DIMENSION  A(IA,N),L(N),S(N)    
      DO 3 I = 1,N
        L(I) = I  
        SMAX = 0.0
        DO 2 J = 1,N
          SMAX = AMAX1(SMAX,ABS(A(I,J)))
   2    CONTINUE  
        S(I) = SMAX 
   3  CONTINUE    
      DO 7 K = 1,N-1
        RMAX = 0.0
        DO 4 I = K,N
          R = ABS(A(L(I),K))/S(L(I))  
          IF(R .LE. RMAX)  GO TO 4    
          J = I   
          RMAX = R
   4    CONTINUE  
        LK = L(J) 
        L(J) = L(K) 
        L(K) = LK 
        DO 6 I = K+1,N      
          XMULT = A(L(I),K)/A(LK,K)   
          DO 5 J = K+1,N    
            A(L(I),J) = A(L(I),J) - XMULT*A(LK,J) 
   5      CONTINUE
          A(L(I),K) = XMULT 
   6    CONTINUE  
   7  CONTINUE    
      RETURN      
      END 
  
      SUBROUTINE SOLVE(N,A,IA,L,B,X)  
      DIMENSION  A(IA,N),L(N),B(N),X(N) 
      DO 3 K = 1,N-1
        DO 2 I = K+1,N      
          B(L(I)) = B(L(I)) - A(L(I),K)*B(L(K)) 
   2    CONTINUE
   3  CONTINUE    
      X(N) = B(L(N))/A(L(N),N)
      DO 5 I = N-1,1,-1     
        SUM = B(L(I))       
        DO 4 J = I+1,N      
          SUM = SUM - A(L(I),J)*X(J)  
   4    CONTINUE  
        X(I) = SUM/A(L(I),I)
   5  CONTINUE    
      RETURN      
      END 

