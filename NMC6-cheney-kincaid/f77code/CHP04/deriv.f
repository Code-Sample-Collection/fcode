C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: deriv.f
C
C DERIVATIVE BY CENTER DIFFERENCES AND RICHARDSON EXTRAPOLATION (DERIV,F)
C
      PARAMETER  (ID=15)    
      DIMENSION  D(ID,ID)   
      EXTERNAL F
      DATA  H/1.0/,N/10/    
      PI3=4.0*ATAN(1.0)/3.0 
      CALL DERIV(F,PI3,N,H,D,ID)      
      STOP
      END 
  
      FUNCTION F(X) 
      F=SIN(X)    
      RETURN
      END 
  
      SUBROUTINE DERIV(F,X,N,H,D,ID)  
      DIMENSION D(ID,N)     
      DO 3 I=1,N  
        D(I,1)=(F(X+H)-F(X-H))/(2.0*H)
        Q=4.0     
        DO 2 J=1,I-1
          D(I,J+1)=D(I,J)+(D(I,J)-D(I-1,J))/(Q-1.0)       
          Q=4.0*Q 
   2    CONTINUE  
        PRINT 4,(D(I,J),J=1,I)
        H=H/2.0   
   3  CONTINUE    
   4  FORMAT(5X,5E22.14)    
      RETURN
      END 
