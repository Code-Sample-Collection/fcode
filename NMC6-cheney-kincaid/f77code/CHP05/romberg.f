C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: romberg.f
C
C ROMBERG ARRAY FOR THREE SEPARATE FUNCTIONS (ROMBERG,F,G,P)
C
      DIMENSION R(10,10)    
      EXTERNAL F,G,P
      CALL ROMBRG(F,0.,2.,3,R,10)     
      CALL ROMBRG(G,-1.,1.,4,R,10)    
      CALL ROMBRG(P,0.,1.,7,R,10)     
      STOP
      END 
  
      FUNCTION F(X) 
      F = 1./(1.+X) 
      RETURN      
      END 
  
      FUNCTION G(X) 
      G = EXP(X)  
      RETURN      
      END 
  
      FUNCTION P(X) 
      P = SQRT(X) 
      RETURN      
      END 

      SUBROUTINE ROMBRG(F,A,B,N,R,IR) 
      DIMENSION  R(IR,N)    
      H = B - A   
      R(1,1) = 0.5*H*(F(A) + F(B))    
      PRINT 5,R(1,1)
      L = 1       
      DO 4 I = 2,N
        H = 0.5*H 
        L = L + L 
        SUM = 0.0 
        DO 2 K = 1,L-1,2    
          SUM = SUM + F(A + H*REAL(K))
   2    CONTINUE  
        M = 1     
        R(I,1) = 0.5*R(I-1,1) + H*SUM 
        DO 3 J = 2,I
          M = 4*M 
          R(I,J) = R(I,J-1) + (R(I,J-1) - R(I-1,J-1))/REAL(M - 1)   
   3    CONTINUE  
        PRINT 5,(R(I,J),J = 1,I)      
   4  CONTINUE    
   5  FORMAT(5X,5E22.14)    
      RETURN      
      END 
