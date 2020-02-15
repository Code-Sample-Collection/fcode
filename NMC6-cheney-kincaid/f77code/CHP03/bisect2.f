C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: bisect2.f
C
C SECOND VERSION OF BISECTION METHOD (BISECT,F,G)
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
      FA = F(A) 
      FB = F(B) 
      IF( SIGN(1.0,FA) .EQ. SIGN(1.0,FB) ) THEN 
        PRINT 5,A,B 
        RETURN
      ELSE
        PRINT 3 
        WIDTH = B - A 
        DO 2 I = 1,N
          C = A + (B - A)*0.5 
          FC = F(C) 
          WIDTH = WIDTH/2.0 
          IF( SIGN(1.0,FA) .EQ. SIGN(1.0,FC) ) THEN 
            A = C 
            FA = FC 
          ELSE
            B = C 
            FB = FC 
          ENDIF   
          PRINT 4,I,C,FC,WIDTH
   2    CONTINUE
        RETURN
      ENDIF       
   3  FORMAT(//3X,'STEP',10X,'C',13X,'F(C)',5X,'ERROR',//)
   4  FORMAT(2X,I5,E22.14,2E10.3)     
   5  FORMAT(2X,'FUNCTION HAS SAME SIGN AT',2E22.14)      
      END 
