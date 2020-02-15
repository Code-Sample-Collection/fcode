SUBROUTINE chebpc(c,d,n)
INTEGER n,NMAX
REAL c(n),d(n)
PARAMETER (NMAX=50)
INTEGER j,k
REAL sv,dd(NMAX)
do j=1,n
  d(j)=0.
  dd(j)=0.
end do
d(1)=c(n)
do j=n-1,2,-1
  do k=n-j+1,2,-1
    sv=d(k)
    d(k)=2.*d(k-1)-dd(k)
    dd(k)=sv
  end do
  sv=d(1)
  d(1)=-dd(1)+c(j)
  dd(1)=sv
end do
do j=n,2,-1
  d(j)=d(j-1)-dd(j)
end do
d(1)=-dd(1)+0.5*c(1)
END SUBROUTINE chebpc
