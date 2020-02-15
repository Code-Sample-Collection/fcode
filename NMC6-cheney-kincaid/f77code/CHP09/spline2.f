C
C PAGE 297-298: NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: ASPL2.FOR
C
C INTERPLATES TABLE USING A QUADRATIC B-SPLINE FUNCTION (ASPL2,BSPL2)
C
      DIMENSION T(10),Y(10),Z(11),A(10),H(10)   
      DATA (T(I),I=1,5)/1.,2.,3.,4.,5./
      DATA (Y(I),I=1,5)/0.,1.,0.,1.,0./
C       
      NP1 = 6     
C      DO 2 K=1,20 
C      A(1) = -5.0 + 0.5*FLOAT(K)      
      CALL ASPL2(NP1,T,Y,A,H) 
      Z(1) = BSPL2(NP1,T,A,H,1.)      
      Z(2) = BSPL2(NP1,T,A,H,2.)      
      Z(3) = BSPL2(NP1,T,A,H,3.)      
      Z(4) = BSPL2(NP1,T,A,H,4.)      
      Z(5) = BSPL2(NP1,T,A,H,5.)      
      Z(6) = BSPL2(NP1,T,A,H,1.25)    
      Z(7) = BSPL2(NP1,T,A,H,2.5)     
      Z(8) = BSPL2(NP1,T,A,H,3.75)    
      Z(9) = BSPL2(NP1,T,A,H,4.5)     
      Z(10)= BSPL2(NP1,T,A,H,5.75)    
      Z(11)= BSPL2(NP1,T,A,H,0.0)    
C       
      PRINT 5,A
      PRINT 5,Z   
    2 CONTINUE    
      STOP
    5 FORMAT(5X,10F10.5)    
      END 

      SUBROUTINE ASPL2(NP1,T,Y,A,H)   
      DIMENSION  T(NP1),Y(NP1),A(NP1),H(NP1)    
      DO 2 J = 2,NP1-1      
   2  H(J) = T(J) - T(J-1)  
      H(1) = H(2) 
      H(NP1) = H(2) 
      D = -1.0    
      G = 2.0*Y(1)
      P = D*G     
      Q = 2.0     
      DO 3 I = 2,NP1-1      
      R = H(I+1)/H(I)       
      D = -R*D    
      G = -R*G + (R + 1.0)*Y(I)       
      P = P + D*G 
   3  Q = Q + D*D 
      A(1) = -P/Q 
      DO 4 J = 2,NP1
   4  A(J) = ((H(J-1) + H(J))*Y(J-1) - H(J)*A(J-1))/H(J-1)
      RETURN      
      END 
  
      FUNCTION BSPL2(NP1,T,A,H,X)     
      DIMENSION  T(NP1),A(NP1),H(NP1) 
      DO 2 J = 2,NP1-1      
      IF(X .LE. T(J))  GO TO 3
   2  CONTINUE    
   3  TEMP = A(J+1)*(X - T(J-1)) + A(J)*(T(J) - X + H(J+1)) 
      C2 = TEMP/(H(J) + H(J+1))       
      TEMP = A(J)*(X - T(J-1) + H(J-1)) + A(J-1)*(T(J-1) - X + H(J))
      C1 = TEMP/(H(J-1) + H(J))       
      BSPL2 = (C2*(X - T(J-1)) + C1*(T(J) - X))/H(J)      
      print *,j,x
      RETURN      
      END 

