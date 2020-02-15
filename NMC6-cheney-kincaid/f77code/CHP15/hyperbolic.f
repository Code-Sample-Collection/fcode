C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: hyperbolic.f
C
C HYPERBOLIC PDE PROBLEM SOLVED BY DISCRETIZATION (F,TRUE)
C
      DIMENSION  U(11),V(11),W(11)    
      DATA  N/11/, M/20/, H/0.1/, HK/0.05/      
      DATA  U(1),V(1),W(1),U(11),V(11),W(11)/6*0.0/       
      RHO = (HK/H)**2       
      PHO = 2.0*(1.0 - RHO) 
      DO 2 I = 2,N-1
        X = REAL(I-1)*H     
        W(I) = F(X) 
        V(I) = 0.5*( RHO*(F(X-H) + F(X+H)) + PHO*F(X) )   
   2  CONTINUE
      DO 5 K = 2,M
        DO 3 I = 2,N-1      
          U(I) = RHO*(V(I+1) + V(I-1)) + PHO*V(I) - W(I)  
   3    CONTINUE
        PRINT 6,K,(U(I),I = 1,N)      
        DO 4 I = 2,N-1      
          W(I) = V(I)       
          V(I) = U(I)       
          T = REAL(K)*HK    
          X = REAL(I-1)*H   
          U(I) = TRUE(X,T) - V(I)     
   4    CONTINUE
        PRINT 6,K,(U(I),I = 1,N)      
   5  CONTINUE
   6  FORMAT(//5X,I5,//(4(5X,E22.14)))
      STOP
      END 
        
      FUNCTION F(X) 
      DATA  PI/3.14159 26535 898/     
      F = SIN(PI*X) 
      RETURN      
      END 
        
      FUNCTION TRUE(X,T)    
      DATA  PI/3.14159 26535 898/     
      TRUE = SIN(PI*X)*COS(PI*T)      
      RETURN      
      END 
