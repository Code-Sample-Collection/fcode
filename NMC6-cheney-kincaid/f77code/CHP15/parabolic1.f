C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: parabolic.f
C
C PARABOLIC PARTIAL DIFFERENTIAL EQUATION PROBLEM
C
      DIMENSION  U(11),V(11)
      DATA  U(1),V(1),U(11),V(11)/4*0.0/
      DATA  M/11/, H/0.1/, HK/0.005/  
      PI = 4.0*ATAN(1.0)    
      PI2 = PI*PI 
      DO 2 I = 2,M-1
        U(I) = SIN(PI*REAL(I-1)*H)    
   2  CONTINUE
      PRINT 7,(U(I),I = 1,M)
      DO 6 J = 1,20 
        DO 3 I = 2,M-1      
          V(I) = 0.5*(U(I-1) + U(I+1))
   3    CONTINUE  
        PRINT 7,(V(I),I = 1,M)
        T = REAL(J)*HK      
        DO 4 I = 2,M-1      
          U(I) = EXP(-PI2*T)*SIN(PI*REAL(I-1)*H) - V(I)   
   4    CONTINUE  
        PRINT 7,(U(I),I = 1,M)
        DO 5 I = 2,M-1      
          U(I) = V(I)       
   5    CONTINUE  
   6  CONTINUE
   7  FORMAT(//(5(5X,E22.14)))
      STOP
      END 
