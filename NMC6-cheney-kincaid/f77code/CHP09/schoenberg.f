C
C PAGE 300: NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: SCH.FOR
C
C INTERPOLATES TABLE USING SCHOENBERG'S PROCESS (SCH,ESCH,F)
C
      DIMENSION D(22),X(101),Y(101),Z(101)
      EXTERNAL F, ESCH
      DATA A,B,N,NP2,M/-5.,5.,20,22,101/
      CALL SCH(F,A,B,NP2,D) 
      PRINT 2,(D(J),J=1,NP2)
 2    FORMAT(1X,5E25.15)
      H=(B-A)/FLOAT(M-1)
      DO 3 J=1,M
      X(J)=A+H*FLOAT(J-1) 
      Y(J)=ESCH(A,B,NP2,D,X(J)) 
 3    Z(J)=Y(J)-F(X(J)) 
      DO 4 J=1,M
 4    PRINT 2,X(J),Y(J),Z(J)
      STOP
      END 
  
      FUNCTION F(X) 
      F=1.0/(X**2+1.0)
      RETURN
      END 
  
      SUBROUTINE SCH(F,A,B,NP2,D)     
      DIMENSION  D(NP2)     
      H = (B - A)/REAL(NP2-3) 
      DO 2 J = 2,NP2-1      
   2  D(J) = F(A + H*REAL(J-2))       
      D(1) = 2.0*D(2) - D(3)
      D(NP2) = 2.0*D(NP2-1) - D(NP2-2)
      RETURN      
      END 
  
      FUNCTION ESCH(A,B,NP2,D,X)      
      DIMENSION  D(NP2)     
      H = (B - A)/REAL(NP2-3) 
      C = A - 2.5*H 
      Y = (X - C)/H 
      J = INT(Y)  
      Y = Y - AINT(Y)       
      P = D(J+1)*Y + D(J)*(2.0 - Y)   
      Q = D(J)*(Y + 1.0) + D(J-1)*(1.0 - Y)     
      ESCH = (P*Y + Q*(1.0 - Y))*0.5  
      RETURN      
      END 

