C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: test_random.f
C
C EXAMPLE TO COMPUTE, STORE, AND PRINT RANDOM NUMBERS (RANDOM)
C
      DIMENSION  X(10)
      DATA  L/256/
      DO 2 I = 1,10 
        X(I) = RANDOM(L)    
   2  CONTINUE
      PRINT 3,(X(I),I=1,10) 
   3  FORMAT(5X,F22.14)     
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
