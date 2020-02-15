C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: double_integral.f
C
C VOLUME OF A COMPLICATED REGION IN THREE-SPACE BY MONTE CARLO (RANDOM)
C
      DATA  L,M,N/256,0,1000/ 
      DO 2 I = 1,N
        X = RANDOM(L)       
        Y = RANDOM(L)       
        Z = RANDOM(L)       
        IF((X*X+SIN(Y) .LE. Z) .AND. (X-Z+EXP(Y) .LE. 1.0))  M = M + 1
        IF(MOD(I,100) .EQ. 0)  THEN   
          VOL = REAL(M)/REAL(I)       
          PRINT 3,I,VOL     
        END IF    
   2  CONTINUE    
   3  FORMAT(5X,I5,F10.5)   
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
