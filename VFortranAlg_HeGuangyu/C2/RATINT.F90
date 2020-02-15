SUBROUTINE ratint(xa,ya,n,x,y,dy)
INTEGER n,NMAX
REAL dy,x,y,xa(n),ya(n),TINY
PARAMETER (NMAX=10,TINY=1.e-25)
INTEGER i,m,ns
REAL dd,h,hh,t,w,c(NMAX),d(NMAX)
ns=1
hh=abs(x-xa(1))
do i=1,n
  h=abs(x-xa(i))
  if (h==0.)then
    y=ya(i)
    dy=0.0
    return
  else if (h<hh) then
    ns=i
    hh=h
  endif
  c(i)=ya(i)
  d(i)=ya(i)+TINY
end do
y=ya(ns)
ns=ns-1
do m=1,n-1
  do i=1,n-m
    w=c(i+1)-d(i)
    h=xa(i+m)-x
    t=(xa(i)-x)*d(i)/h
    dd=t-c(i+1)
    if(dd==0.) pause 'failure in ratint'
    dd=w/dd
    d(i)=c(i+1)*dd
    c(i)=t*dd
  end do
  if (2*ns<n-m)then
    dy=c(ns+1)
  else
    dy=d(ns)
    ns=ns-1
  endif
  y=y+dy
end do
END SUBROUTINE ratint
