SUBROUTINE GASCOL(A,N,NP,B)
DIMENSION A(NP,NP),B(N)
DO 15 K=1,N-1
pivoting
    IR=K
    DO 10 I=K,N
        IF (ABS(A(IR,K)).LT.ABS(A(I,K))) IR=I
    CONTINUE
    IF (A(IR,K).EQ.0.) PAUSE 'singular matrix'
    IF (IR.NE.K) THEN
        P=B(K)
        B(K)=B(IR)
        B(IR)=P
        DO 11 J=K,N
            P=A(K,J)
            A(K,J)=A(IR,J)
            A(IR,J)=P
        CONTINUE
    ENDIF
elimination
    P=1./A(K,K)
    B(K)=B(K)*P
    DO 12 J=K,N
        A(K,J)=A(K,J)*P
    CONTINUE
    DO 14 I=K+1,N
        B(I)=B(I)-B(K)*A(I,K)
        DO 13 J=K+1,N
            A(I,J)=A(I,J)-A(K,J)*A(I,K)
        CONTINUE
        A(I,K)=0.
    CONTINUE
CONTINUE
backsubstitution
B(N)=B(N)/A(N,N)
DO 17 I=N-1,1,-1
    DO 16 J=I+1,N
        B(I)=B(I)-A(I,J)*B(J)
    CONTINUE
CONTINUE
RETURN
END
