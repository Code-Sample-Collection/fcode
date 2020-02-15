C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: amrk.f
C
C ADAMS-MOULTON METHOD FOR SYSTEMS OF ODE'S (AMRK,RKSYS,AMSYS,XPSYS)
C
      DIMENSION X(6)
      DATA T/1.0/, X/1.0,2.0,-4.0,-2.0,7.0,6.0/   
      DATA N/6/, H/0.01/, NSTEP/100/   
      CALL AMRK(N,T,X,H,NSTEP)
      STOP
      END 
  
      SUBROUTINE XPSYS(X,F) 
      DIMENSION X(6),F(6)   
      F(1) = 1.0  
      F(2) = X(3) 
      F(3) = X(2) - X(4) - 9.0*X(3)**2 + X(5)**3 + 6.0*X(6) + 2.0*X(1)
      F(4) = X(5) 
      F(5) = X(6) 
      F(6) = X(6) - X(3) + EXP(X(2)) - X(1) 
      RETURN      
      END 
  
      SUBROUTINE AMRK(N,T,X,H,NSTEP)  
      DIMENSION  X(10),F(10,5),Z(10,5)
      M = 1       
      PRINT 6,T,H 
      PRINT 7,(X(I),I=1,N)  
      DO 2 I=1,N  
        Z(I,M) = X(I)       
   2  CONTINUE    
      DO 3 K = 1,3
        CALL RKSYS(N,M,T,Z,H,F)       
        PRINT 6,T,H 
        PRINT 7,(Z(I,M),I = 1,N)      
   3  CONTINUE
      DO 4 K = 4,NSTEP      
        CALL AMSYS(N,M,T,Z,H,F,EST)   
        PRINT 6,T,H,EST     
        PRINT 7,(Z(I,M),I = 1,N)      
   4  CONTINUE
      DO 5 I=1,N  
        X(I) = Z(I,M)       
   5  CONTINUE
      RETURN      
   6  FORMAT(2X,'T,H,EST:',3(1X,E10.3)) 
   7  FORMAT(8X,'X:',5(5X,E22.14))
      END 
  
      SUBROUTINE RKSYS(N,M,T,X,H,F)   
      DIMENSION  X(10,5),XP(10),F(10,5),F2(10),F3(10),F4(10)
      MP1 = 1 + MOD(M,5)    
      H2 = 0.5*H  
      CALL XPSYS(X(1,M),F(1,M))       
      DO 2 I = 1,N
        XP(I) = X(I,M) + H2*F(I,M)    
   2  CONTINUE
      CALL XPSYS(XP,F2)     
      DO 3 I = 1,N
        XP(I) = X(I,M) + H2*F2(I)     
   3  CONTINUE
      CALL XPSYS(XP,F3)     
      DO 4 I = 1,N
        XP(I) = X(I,M) + H*F3(I)      
   4  CONTINUE
      CALL XPSYS(XP,F4)     
      DO 5 I = 1,N
        X(I,MP1) = X(I,M) + H*(F(I,M) + 2.0*(F2(I) + F3(I)) + F4(I))/6.0      
  5   CONTINUE
      T = T + H   
      M = MP1     
      RETURN      
      END 
  
      SUBROUTINE AMSYS(N,M,T,X,H,F,EST) 
      DIMENSION  X(10,5),XP(10),F(10,5),SUM(10),CP(4),CC(4) 
      DATA  CP/55.0,-59.0,37.0,-9.0/  
      DATA  CC/ 9.0, 19.0,-5.0, 1.0/  
      MP1 = 1 + MOD(M,5)    
      CALL XPSYS(X(1,M),F(1,M))       
      DO 2 I = 1,N
        SUM(I) = 0.0
   2  CONTINUE
      DO 4 K = 1,4
        J = 1 + MOD(M-K+5,5)
        DO 3 I = 1,N
          SUM(I) = SUM(I) + CP(K)*F(I,J)
   3    CONTINUE  
   4  CONTINUE
      DO 5 I = 1,N
        XP(I) = X(I,M) + H*SUM(I)/24.0
   5  CONTINUE    
      CALL XPSYS(XP,F(1,MP1)) 
      DO 6 I = 1,N
        SUM(I) = 0.0
   6  CONTINUE    
      DO 8 K = 1,4
        J = 1 + MOD(MP1-K+5,5)
        DO 7 I = 1,N
          SUM(I) = SUM(I) + CC(K)*F(I,J)
   7    CONTINUE  
   8  CONTINUE
      DO 9 I = 1,N
        X(I,MP1) = X(I,M) + H*SUM(I)/24.0       
   9  CONTINUE    
      T = T + H   
      M = MP1     
      DLTMAX = 0.0
      DO 10 I = 1,N 
        DLT = ABS( X(I,M) - XP(I) )   
        IF(DLT .GT. DLTMAX) THEN      
          DLTMAX = DLT      
          IDLT = I
        END IF    
  10  CONTINUE    
      EST = 19.0*DLTMAX/( 270.0*ABS(X(IDLT,M)) )
      RETURN      
      END 

