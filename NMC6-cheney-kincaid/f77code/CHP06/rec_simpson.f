C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: rec_simpson.f
C
C ADAPTIVE SCHEME FOR SIMPSON'S RULE (SIMP,ASMP,PUSH,POP,FCN)
C
      PARAMETER (IST=5,IFS=16)
      REAL STACK(IST,3),FSTACK(IFS,3) 
      EXTERNAL FCN
      DATA EPSI/5.0E-5/, LVMAX/4/     
      A = 0.0 
      B = 8.0*ATAN(1.0)     
      CALL ASMP(FCN,A,B,EPSI,LVMAX,STACK,IST,FSTACK,IFS,SUM,IFLAG)  
      PRINT 3,SUM 
      IF(IFLAG .EQ. 0) THEN 
        PRINT 4   
      ELSE
        PRINT 5   
        DO 2 I=1,IFLAG      
          PRINT 6,FSTACK(I,1),FSTACK(I,2),INT(FSTACK(I,3))
    2   CONTINUE  
      END IF      
   3  FORMAT(//5X,'APPROXIMATE INTEGRAL =',E22.14/)   
   4  FORMAT(10X,'WITH NO BAD SUBINTERVALS')    
   5  FORMAT(10X,'WITH BAD SUBINTERVALS:')      
   6  FORMAT(10X,'[',F10.5,',',F10.5,']',2X,'LEVEL =',I5) 
      STOP
      END 
  
      FUNCTION FCN(X) 
        FCN = COS(2.0*X)/EXP(X) 
        RETURN
      END 
  
      SUBROUTINE PUSH(A,B,LEVEL,STACK,IST,I)    
      REAL STACK(IST,3)     
      IF(I .LT. IST) THEN   
        I = I+1 
        STACK(I,1) = A      
        STACK(I,2) = B
        STACK(I,3) = REAL(LEVEL)      
        RETURN
      ELSE
        STOP 'STACK OVERFLOW IN PUSH' 
      END IF      
      END 
  
      SUBROUTINE POP(A,B,LEVEL,STACK,IST,I)     
      REAL STACK(IST,3)     
      IF(I .GT. 0) THEN 
        A = STACK(I,1)
        B = STACK(I,2)
        LEVEL = INT(STACK(I,3))       
        I = I-1 
        RETURN
      ELSE
        STOP 'STACK UNDERFLOW IN POP' 
      END IF      
      END 
  
      SUBROUTINE ASMP(FCN,A,B,EPSI,LVMAX,STACK,IST,FSTACK,IFS,SUM,IFLAG)      
      REAL STACK(IST,3),FSTACK(IFS,3) 
      COMMON /BLK/ ITOP,LEVEL,LMAX    
      EXTERNAL FCN
      ITOP = 0
      LEVEL = 0   
      IFLAG = 0 
      SUM = 0.0 
      LMAX = 2**LVMAX 
      IF(IST .GE. LVMAX+1 .AND. IFS .GE. LMAX) THEN 
        CALL PUSH(A,B,LEVEL,STACK,IST,ITOP)     
        DO 2 LOOP=1,2*LMAX-1
          IF(ITOP .EQ. 0) RETURN      
          CALL POP(A,B,LEVEL,STACK,IST,ITOP)    
          CALL SIMP(FCN,A,B,EPSI,LVMAX,STACK,IST,FSTACK,IFS,SUM,IFLAG)
    2   CONTINUE  
      ELSE
        PRINT 3   
      END IF      
      RETURN
   3  FORMAT(//5X,'NOT ENOUGH WORKSPACE IN STACK OR FSTACK')
      END 
  
      SUBROUTINE SIMP(FCN,A,B,EPSI,LVMAX,STACK,IST,FSTACK,IFS,SUM,IFLAG)      
      REAL STACK(IST,3),FSTACK(IFS,3),X(0:4),F(0:4) 
      COMMON /BLK/ ITOP,LEVEL,LMAX    
      H = B - A 
      H4 = H/4.0  
      DO 2 I = 0,4
        X(I) = A + REAL(I)*H4 
        F(I) = FCN(X(I))
   2  CONTINUE    
      SUM2 = H*(F(0) + 4.0*F(2) + F(4))/6.0 
      SUM4 = H*(F(0) + 4.0*F(1) + 2.0*F(2) + 4.0*F(3) + F(4))/12.0
      IF(ABS(SUM4 - SUM2) .LE. 15.0*EPSI/REAL(2**LEVEL)) THEN       
        SUM = SUM + SUM4
      ELSE
        IF(LEVEL .LT. LVMAX) THEN     
          LEVEL = LEVEL + 1 
          CALL PUSH(X(2),X(4),LEVEL,STACK,IST,ITOP)       
          CALL PUSH(X(0),X(2),LEVEL,STACK,IST,ITOP)       
        ELSE      
          CALL PUSH(X(0),X(4),LEVEL,FSTACK,IFS,IFLAG)     
        END IF    
      END IF      
      RETURN
      END 
