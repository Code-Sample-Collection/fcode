C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: load_die.f
C
C LOADED DIE PROBLEM SIMULATION (RANDOM)
C
      DIMENSION  M(6),Y(6)  
      DATA  L,N/256,1000/   
      DATA  (Y(I),I=1,6)/0.2,0.34,0.56,0.72,0.89,1.0/     
      DO 2 I = 1,6
        M(I) = 0  
   2  CONTINUE
      DO 5 I = 1,N
        RANNUM = RANDOM(L)  
        DO 3 K = 1,6
          IF(RANNUM .LT. Y(K))  GO TO 4 
   3    CONTINUE  
   4    M(K) = M(K) + 1     
   5  CONTINUE    
      PRINT 6,(M(I),I = 1,6)
   6  FORMAT(5X,6I5)
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
