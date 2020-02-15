SUBROUTINE ddpoly(c,nc,x,pd,nd)
INTEGER nc,nd
REAL x,c(nc),pd(nd)
INTEGER i,j,nnd
REAL const
pd(1)=c(nc)
do j=2,nd
  pd(j)=0.
end do
do i=nc-1,1,-1
  nnd=min(nd,nc+1-i)
  do j=nnd,2,-1
    pd(j)=pd(j)*x+pd(j-1)
  end do
  pd(1)=pd(1)*x+c(i)
end do
const=2.
do i=3,nd
  pd(i)=const*pd(i)
  const=const*i
end do
END SUBROUTINE ddpoly
