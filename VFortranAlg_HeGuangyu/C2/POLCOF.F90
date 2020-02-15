SUBROUTINE polcof(xa,ya,n,cof)
INTEGER n,NMAX
REAL cof(n),xa(n),ya(n)
PARAMETER (NMAX=15)
!USES polint
INTEGER i,j,k
REAL dy,xmin,x(NMAX),y(NMAX)
do j=1,n
  x(j)=xa(j)
  y(j)=ya(j)
end do
do j=1,n
  call polint(x,y,n+1-j,0.,cof(j),dy)
  xmin=1.e38
  k=0
  do i=1,n+1-j
    if (abs(x(i))<xmin) then
      xmin=abs(x(i))
      k=i
    endif
    if(x(i)/=0.) y(i)=(y(i)-cof(j))/x(i)
  end do
  do i=k+1,n+1-j
    y(i-1)=y(i)
    x(i-1)=x(i)
  end do
end do
END SUBROUTINE polcof
