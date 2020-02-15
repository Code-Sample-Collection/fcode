C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, (c) 1985
C
C FILE: seidel.F
C
C ELLIPTIC PDE SOLVED BY DISCRETIZATION AND GAUSS-SEIDEL METHOD
C  (SEIDEL,F,G,BNDY,USTART,TRUE)
C
      PARAMETER  (IU = 9)   
      DIMENSION  U(IU,IU)   
      DATA  AX,BX/0.0,1.0/, AY,BY/0.0,1.0/  
      DATA  NX,NY/2*9/, ITMAX/20/     
      H = (BX - AX)/REAL(NX - 1)      
      DO 2 J = 1,NY 
        Y = AY + REAL(J-1)*H
        U(1,J)  = BNDY(AX,Y)
        U(NX,J) = BNDY(BX,Y)
   2  CONTINUE
      DO 3 I = 1,NX 
        X = AX + REAL(I-1)*H
        U(I,1)  = BNDY(X,AY)
        U(I,NY) = BNDY(X,BY)
   3  CONTINUE
      DO 5 J = 2,NY-1       
        Y = AY + REAL(J-1)*H
        DO 4 I = 2,NX-1     
          X = AX + REAL(I-1)*H
          U(I,J) = USTART(X,Y)
   4    CONTINUE
   5  CONTINUE    
      PRINT 8,0,((U(I,J),I = 1,NX),J = 1,NY)    
      CALL SEIDEL(AX,AY,NX,NY,H,ITMAX,U,IU)     
      PRINT 8,ITMAX,((U(I,J),I = 1,NX),J = 1,NY)
      DO 7 J = 1,NY 
        Y = AY + REAL(J-1)*H
        DO 6 I = 1,NX       
          X = AX + REAL(I-1)*H
          U(I,J) = ABS( TRUE(X,Y) - U(I,J) )  
   6    CONTINUE
   7  CONTINUE    
      PRINT 8,ITMAX,((U(I,J),I = 1,NX),J = 1,NY)
   8  FORMAT(//4X,I5,//(9(2X,E12.5))) 
      STOP
      END 
        
      FUNCTION F(X,Y)       
      F = -25.0 
      RETURN      
      END 
        
      FUNCTION G(X,Y)       
      G = 0.0 
      RETURN      
      END 
        
      FUNCTION BNDY(X,Y)    
      BNDY = TRUE(X,Y)    
      RETURN      
      END 
        
      FUNCTION USTART(X,Y)  
      USTART = 1.0
      RETURN      
      END 
        
      FUNCTION TRUE(X,Y)    
      TRUE = 0.5*(COSH(5.0*X) + COSH(5.0*Y))/COSH(5.0)
      RETURN      
      END 
  
      SUBROUTINE SEIDEL(AX,AY,NX,NY,H,ITMAX,U,IU) 
      DIMENSION  U(IU,NY)   
      HSQ = H*H   
      DO 4 K = 1,ITMAX      
        DO 3 J = 2,NY-1     
          Y = AY + REAL(J-1)*H
          DO 2 I = 2,NX-1   
            X = AX + REAL(I-1)*H      
            V = U(I+1,J) + U(I-1,J) + U(I,J+1) + U(I,J-1) 
            U(I,J) = (V - HSQ*G(X,Y))/(4.0 - HSQ*F(X,Y))  
   2      CONTINUE
   3    CONTINUE  
   4  CONTINUE    
      RETURN      
      END 
