FUNCTION beta(z,w)
REAL beta,w,z
!USES gammln
REAL gammln
beta=exp(gammln(z)+gammln(w)-gammln(z+w))
END FUNCTION beta
