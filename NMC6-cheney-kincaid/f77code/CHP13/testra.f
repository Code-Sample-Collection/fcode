C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: testra.f
C
C COARSE CHECK ON THE RANDOM-NUMBER GENERATOR (RANDOM)
C
      DIMENSION  A(5,5)     
      DATA  NPTS/16000/ 
      DO 3 I = 1,5
        L = I*256 
        N = 1000  
        J = 1     
        M = 0     
        DO 2 K = 1,NPTS     
          IF(RANDOM(L) .LE. 0.5)  M = M + 1     
          IF(K .EQ. N)  THEN
            A(I,J) = 100.0*REAL(M)/REAL(N)      
            N = 2*N 
            J = J + 1       
          END IF  
   2    CONTINUE  
   3  CONTINUE    
      PRINT 4,((A(I,J),J = 1,5),I = 1,5)
   4  FORMAT(5X,5F6.1)      
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
