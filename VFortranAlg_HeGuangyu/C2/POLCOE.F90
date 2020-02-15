SUBROUTINE polcoe(x,y,n,cof)
INTEGER n,NMAX
REAL cof(n),x(n),y(n)
PARAMETER (NMAX=15)
INTEGER i,j,k
REAL b,ff,phi,s(NMAX)
do i=1,n
  s(i)=0.
  cof(i)=0.
end do
s(n)=-x(1)
do i=2,n
  do j=n+1-i,n-1
    s(j)=s(j)-x(i)*s(j+1)
  end do
  s(n)=s(n)-x(i)
end do
do j=1,n
  phi=n
  do k=n-1,1,-1
    phi=k*s(k+1)+x(j)*phi
  end do
  ff=y(j)/phi
  b=1.
  do k=n,1,-1
    cof(k)=cof(k)+b*ff
    b=s(k)+x(j)*b
  end do
end do
END SUBROUTINE polcoe
