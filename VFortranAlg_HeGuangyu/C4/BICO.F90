FUNCTION bico(n,k)
INTEGER k,n
REAL bico
!USES factln
REAL factln
bico=nint(exp(factln(n)-factln(k)-factln(n-k)))
END FUNCTION bico
