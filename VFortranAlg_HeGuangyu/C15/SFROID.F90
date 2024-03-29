PROGRAM SFROID
!PARAMETER (NE=3,M=41,NB=1,NCI=NE,NCJ=NE-NB+1,NCK=M+1&
!          ,NSI=NE,NSJ=2*NE+1,NYJ=NE,NYK=M)
PARAMETER (NE=3,M=41,NB=1,NCI=3,NCJ=3,NCK=42,NSI=3,&
           NSJ=7,NYJ=3,NYK=41)
!USES PLGNDR
COMMON X(M),H,MM,N,C2,ANORM
DIMENSION SCALV(NE),INDEXV(NE),Y(NE,M),C(NCI,NCJ,&
          NCK),S(NSI,NSJ)
ITMAX=100
CONV=5.E-6
SLOWC=1.
H=1./(M-1)
C2=0.0
WRITE(*,*)'ENTER M,N'
READ(*,*)MM,N
IF(MOD(N+MM,2)==1) THEN
! No interchange necessary
    INDEXV(1)=1
    INDEXV(2)=2
    INDEXV(3)=3
ELSE
! Interchange y1 and y2
    INDEXV(1)=2
    INDEXV(2)=1
    INDEXV(3)=3
ENDIF
ANORM=1.
IF(MM/=0)THEN
    Q1=N
    DO I=1,MM
        ANORM=-.5*ANORM*(N+I)*(Q1/I)
        Q1=Q1-1.
    END DO
ENDIF
! Initial guess
DO K=1,M-1
    X(K)=(K-1)*H
    FAC1=1.-X(K)**2
    FAC2=FAC1**(-MM/2.)
! PLGNDR  computes Legendre function
    Y(1,K)=PLGNDR(N,MM,X(K))*FAC2
    DERIV=-((N-MM+1)*PLGNDR(N+1,MM,X(K))-(N+1)*&
         X(K)*PLGNDR(N,MM,X(K)))/FAC1
    Y(2,K)=MM*X(K)*Y(1,K)/FAC1+DERIV*FAC2
    Y(3,K)=N*(N+1)-MM*(MM+1)
END DO
! Initial guess at x=1 done separately
X(M)=1.
Y(1,M)=ANORM
Y(3,M)=N*(N+1)-MM*(MM+1)
Y(2,M)=(Y(3,M)-C2)*Y(1,M)/(2.*(MM+1.))
SCALV(1)=ABS(ANORM)
SCALV(2)=MAX(ABS(ANORM),Y(2,M))
SCALV(3)=MAX(1.,Y(3,M))
DO
  WRITE (*,*) 'ENTER C**2 OR  999 TO END'
  READ (*,*) C2
  IF(C2==999.) STOP
  CALL SOLVDE(ITMAX,CONV,SLOWC,SCALV,INDEXV,NE,&
       NB,M,Y,NYJ,NYK,C,NCI,NCJ,NCK,S,NSI,NSJ)
  WRITE (*,'(1X,A,I3,A,I3,A,F8.4,A,F11.7)') 'M =',MM,&
  '   N =',N,'    C**2 =',C2,'    LAMBDA =',Y(3,1)+MM*(MM+1)
END DO
END
