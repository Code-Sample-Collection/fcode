SUBROUTINE polin2(x1a,x2a,ya,m,n,x1,x2,y,dy)
INTEGER m,n,NMAX,MMAX
REAL dy,x1,x2,y,x1a(m),x2a(n),ya(m,n)
PARAMETER (NMAX=20,MMAX=20)
!USES polint
INTEGER j,k
REAL ymtmp(MMAX),yntmp(NMAX)
do j=1,m
  do k=1,n
    yntmp(k)=ya(j,k)
  end do
  call polint(x2a,yntmp,n,x2,ymtmp(j),dy)
end do
call polint(x1a,ymtmp,m,x1,y,dy)
END SUBROUTINE polin2
