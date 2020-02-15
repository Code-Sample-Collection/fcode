C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: shielding.f
C
C NEUTRON SHIELDING PROBLEM SIMULATION (RANDOM)
C
      DATA  L,N,M/256,1000,0/ 
      PI = 4.0*ATAN(1.0)    
      DO 4 I = 1,N
        X = 1.0   
        DO 2 K = 1,7
          THETA = PI*RANDOM(L)
          X = X + COS(THETA)
          IF(X .LE. 0.0)  GO TO 3     
          IF(X .LT. 5.0)  GO TO 2     
          M = M + 1 
          GO TO 3 
   2    CONTINUE  
   3    IF(MOD(I,100) .EQ. 0)  THEN   
          PER = 100.0*REAL(M)/REAL(I) 
          PRINT 5,I,PER     
        END IF
   4  CONTINUE
   5  FORMAT(5X,I5,F10.5) 
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
