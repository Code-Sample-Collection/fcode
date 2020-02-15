C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: cone.f
C
C ICE CREAM CONE EXAMPLE (RANDOM)
C
      DATA  L,M,N/256,0,1000/ 
      DO 2 K = 1,N
        X = 2.0*RANDOM(L) - 1.0 
        Y = 2.0*RANDOM(L) - 1.0 
        Z = 2.0*RANDOM(L) 
        IF( (X*X + Y*Y .LE. Z*Z) .AND.
     A      (X*X + Y*Y .LE. Z*(2.0 - Z)) )  M = M + 1     
        IF( MOD(K,100) .EQ. 0 )  THEN 
          VOL = 8.0*REAL(M)/REAL(N) 
          PRINT *,VOL 
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
