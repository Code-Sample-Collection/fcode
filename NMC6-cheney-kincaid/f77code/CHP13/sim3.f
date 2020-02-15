C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: two_die.f
C
C TWO DICE PROBLEM SIMULATION (RANDOM)
C
      DATA  L,M,N/256,0,1000/ 
      DO 4 I = 1,N
        DO 2 K = 1,24       
          I1 = INT(6.0*RANDOM(L) + 1.0) 
          I2 = INT(6.0*RANDOM(L) + 1.0) 
          IF(I1+I2 .LT. 12)  GO TO 2  
          M = M + 1 
          GO TO 3 
   2    CONTINUE  
   3    IF(MOD(I,100) .EQ. 0)  THEN   
          PROB = REAL(M)/REAL(I)      
          PRINT 5,I,PROB    
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
