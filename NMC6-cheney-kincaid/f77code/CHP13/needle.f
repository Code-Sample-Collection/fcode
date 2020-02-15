C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: needle.f
C
C BUFFON'S NEEDLE PROBLEM SIMULATION (RANDOM)
C
      DATA  L,N,M/256,1000,0/ 
      PI2 = 2.0*ATAN(1.0)   
      ANS = 1.0/PI2 
      DO 2 I = 1,N
        W = RANDOM(L)       
        V = PI2*RANDOM(L)   
        IF(W .LE. SIN(V))  M = M + 1  
        IF(MOD(I,100) .EQ. 0)  THEN   
          PROB = REAL(M)/REAL(I)      
          PRINT 3,I,PROB,ANS
        END IF
   2  CONTINUE    
   3  FORMAT(5X,I5,2F10.5)
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
