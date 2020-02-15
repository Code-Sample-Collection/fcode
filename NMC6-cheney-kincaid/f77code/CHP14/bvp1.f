C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: bvp1.f
C
C BOUNDARY VALUE PROBLEM SOLVED BY DISCRETIZATION TECHNIQUE (TRI)
C
      DIMENSION  A(98),B(98),C(98),D(98)
      DATA  N/98/, TA/1.0/, TB/2.0/ 
      DATA  ALPHA/1.09737491/, BETA/8.63749661/ 
      U(X) = EXP(X) - 3.0*SIN(X)      
      V(X) = -1.0 
      W(X) =  1.0 
      H = (TB - TA)/REAL(N+1) 
      HSQ = H*H   
      H2 = 0.5*H  
      DO 2 I = 1,N
        T = TA + REAL(I)*H  
        A(I) = -(1.0 + H2*W(T))       
        D(I) =  (2.0 + HSQ*V(T))      
        C(I) = -(1.0 - H2*W(T))       
        B(I) = -HSQ*U(T)    
   2  CONTINUE
      B(1) = B(1) - A(1)*ALPHA
      B(N) = B(N) - C(N)*BETA 
      CALL TRI(N,A(2),D,C,B,B)
      ERROR = EXP(TA) - 3.0*COS(TA) - ALPHA     
      PRINT 4,TA,ALPHA,ERROR
      DO 3 I = 9,N,9
        T = TA + REAL(I)*H  
        ERROR = EXP(T) - 3.0*COS(T) - B(I)      
        PRINT 4,T,B(I),ERROR
   3  CONTINUE
      ERROR = EXP(TB) - 3.0*COS(TB) - BETA  
      PRINT 4,TB,BETA,ERROR 
   4  FORMAT(5X,F10.5,2(5X,E22.14))   
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
