C*****************************************************************************
C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: bisect1.f
C
C FIRST VERSION OF BISECTION METHOD (BISECT,F,G)
C
      EXTERNAL F,G
      DATA AF/0.0/, BF/1.0/, N/50/
      DATA AG/0.5/, BG/2.0/ 
      CALL BISECT(F,AF,BF,N)
      CALL BISECT(G,AG,BG,N)
      STOP
      END 
  
      FUNCTION F(X) 
      F = EXP(X) - 3.0*X
      RETURN
      END 
  
      FUNCTION G(T) 
      G = T**3 - 2.0*SIN(T) 
      RETURN
      END 
  
      SUBROUTINE BISECT(F,A,B,N)
      U=F(A)      
      V=F(B)      
      PRINT 6,A,U,B,V       
      IF(U*V) 2,7,7 
  2   DO 5 J=1,N  
        C=(A+B)*0.5 
        W=F(C)    
        PRINT 6,C,W 
        IF(W*U) 3,7,4       
  3     B=C       
        V=W       
        GO TO 5   
  4     A=C       
        U=W       
  5   CONTINUE    
  6   FORMAT(2X,2E22.14)    
  7   RETURN      
      END
