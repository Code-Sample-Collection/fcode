SUBROUTINE rk4(y,dydx,n,x,h,yout,derivs)
PARAMETER (nmax=10)
DIMENSION y(n),dydx(n),yout(n),yt(nmax),dyt(nmax),&
          dym(nmax)
REAL hh,h6,xh,x,h
INTEGER i,n
hh=h*0.5
h6=h/6.
xh=x+hh
do i=1,n
  yt(i)=y(i)+hh*dydx(i)
end do
call derivs(xh,yt,dyt)
do i=1,n
  yt(i)=y(i)+hh*dyt(i)
end do
call derivs(xh,yt,dym)
do i=1,n
  yt(i)=y(i)+h*dym(i)
  dym(i)=dyt(i)+dym(i)
end do
call derivs(x+h,yt,dyt)
do i=1,n
  yout(i)=y(i)+h6*(dydx(i)+dyt(i)+2.*dym(i))
end do
END SUBROUTINE rk4
