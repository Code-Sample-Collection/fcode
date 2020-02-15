C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: volume.f
C
C NUMERICAL VALUE OF INTEGRAL OVER A DISK IN XY-SPACE BY MONTE CARLO (RANDOM)
C
      DATA  L,N,SUM/256,1000,0.0/     
      F(X,Y) = SIN(SQRT(ALOG(X + Y + 1.0))) 
      PI4 = ATAN(1.0)       
      DO 3 I = 1,N
   2    X = RANDOM(L)       
        Y = RANDOM(L)       
        IF((X - 0.5)**2 + (Y - 0.5)**2 .GT. 0.25)  GO TO 2
        SUM = SUM + F(X,Y)  
        IF(MOD(I,250) .EQ. 0)  THEN   
          VOL = PI4*SUM/REAL(I)       
          PRINT 4,I,VOL     
        END IF    
   3  CONTINUE    
   4  FORMAT(5X,I5,F10.5) 
      STOP
      END 
  
      FUNCTION RANDOM(L)
      L = MOD(16807*L,2147483647)
      RANDOM = REAL(L)*4.6566128752458E-10      
      RETURN
      END 
