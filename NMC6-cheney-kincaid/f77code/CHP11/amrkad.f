C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: amrkad.f
C
C ADAPTIVE SCHEME FOR ADAMS-MOULTON METHOD FOR SYSTEMS OF ODE'S
C  (AMRKAD,XPSYS,AMRK,AMSYS,RKSYS)
C
      DIMENSION XA(10)      
      TA = 3.0 
      TB = .5    
      XA(1) =3. 
      XA(2) =6. 
      XA(3) = 3.
      H = -.2     
      ITMAX = 100 
      EMIN = 1.0E - 8  
      EMAX = 1.0E - 2      
      HMIN = 1.0E - 4   
      HMAX = 1.0 
      PRINT 13,TA,H 
      PRINT 15,(XA(I),I=1,3)
      CALL AMRKAD(TA,XA,H,TB,ITMAX,EMIN,EMAX,HMIN,HMAX,IFLAG)       
      PRINT 5,IFLAG 
      STOP
    5 FORMAT('0  IFLAG =',I2)       
   13 FORMAT(2X,2F10.5)     
   15 FORMAT(5X,7E15.8)     
      END 
  
      SUBROUTINE XPSYS(N,X,F) 
      DIMENSION X(10),F(10) 
      N = 2       
      X1 = X(1)   
      X2 = X(2)   
      F(1) = 1.0  
      F(2) = 3.0*X2/X1 + 4.5*X1 - 13. 
      RETURN      
      END 

      SUBROUTINE AMRKAD(T,X,H,TB,ITMAX,EMIN,EMAX,HMIN,HMAX,IFLAG)   
      DIMENSION X(10),Z(10,5),F(10,5) 
      DATA  EPSI/1.0E-6/   
      M = 1       
      IRK = 3     
      IAM = 0     
      IFLAG = 3   
      NSTEP = 0   
      IF(ABS(TB-T) .LT. ABS(4.0*H))  H = 0.25*H 
      CALL XPSYS(N,X,F(1,M))
      PRINT 10,T,H
      PRINT 11,(X(I),I=1,N) 
      DO 1 I=1,N  
   1  Z(I,M) = X(I) 
C
   2  DT = ABS(TB -T)       
      IF(DT .GE. ABS(H))  GO TO 3   
      IFLAG = 0   
      IF(DT .LE. EPSI*AMAX1(ABS(TB),ABS(T)))  GO TO 8     
      H = SIGN(DT,H)
      IRK = 1     
      IAM = 0     
      IF(HMIN .LE. ABS(H) .AND. ABS(H) .LE. HMAX)  GO TO 3
      IFLAG = 2   
      GO TO 8     
C
   3  IF(IAM .EQ. 1)  GO TO 5 
      DO 4 K=1,IRK
      CALL RKSYS(N,M,T,Z,H,F)
      NSTEP = NSTEP + 1     
      PRINT 10,T,H
   4  PRINT 11,(Z(I,M),I=1,N) 
      IF(NSTEP .GT. ITMAX .OR. IRK .EQ. 1)  GO TO 8       
   5  CALL AMSYS(N,M,T,Z,H,F,EST)     
      PRINT 10,T,H,EST      
      PRINT 11,(Z(I,M),I=1,N) 
      NSTEP = NSTEP + 1     
C       
      IF(NSTEP .GT. ITMAX .OR. IFLAG .EQ. 0)  GO TO 8     
      IAM = 1     
      HSAVE = H   
      IF(EST .LT. EMIN)  GO TO 6      
      IF(EST .LE. EMAX)  GO TO 2      
      H = 0.5*H   
      GO TO 7     
   6  IF(DT .LT. ABS(4.0*H))  GO TO 2 
      H = 2.0*H   
   7  M = 1 + MOD(M,5)      
      T = T - 4.0*HSAVE     
      IAM = 0     
      IF(HMIN .LE. ABS(H) .AND. ABS(H) .LE. HMAX)  GO TO 2
      IFLAG = 1   
C       
   8  DO 9 I=1,N  
   9  X(I) = Z(I,M) 
      RETURN      
  10  FORMAT(2X,'T,H,EST:',3(E10.3,1X)) 
  11  FORMAT(8X,'X:',5(5X,E22.14))    
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
