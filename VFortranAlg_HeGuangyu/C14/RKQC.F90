SUBROUTINE rkqc(y,dydx,n,x,htry,eps,yscal,hdid,hnext,&
                derivs)
PARAMETER(nmax=10,one=1.,safety=0.9,errcon=6.e-4,&
          fcor=6.6667e-2)
!USES rk4
EXTERNAL derivs
DIMENSION y(n),dydx(n),yscal(n),ytemp(nmax),ysav(nmax),&
          dysav(nmax)
REAL h,xsav,pgrow,pshrnk,hh,x,errmax,hnext,hdid
INTEGER i,n
pgrow=-0.2
pshrnk=-0.25
xsav=x
do i=1,n
  ysav(i)=y(i)
  dysav(i)=dydx(i)
end do
h=htry
do
  hh=0.5*h
  call rk4(ysav,dysav,n,xsav,hh,ytemp,derivs)
  x=xsav+hh
  call derivs(x,ytemp,dydx)
  call rk4(ytemp,dydx,n,x,hh,y,derivs)
  x=xsav+h
  if(x==xsav)&
        pause 'stepsize not significant in rkqc.'
  call rk4(ysav,dysav,n,xsav,h,ytemp,derivs)
  errmax=0.
  do i=1,n
    ytemp(i)=y(i)-ytemp(i)
    errmax=max(errmax,abs(ytemp(i)/yscal(i)))
  end do
  errmax=errmax/eps
  if(errmax>one) then
    h=safety*h*(errmax**pshrnk)
    flag=1.
  else
    hdid=h
    if(errmax>errcon) then
        hnext=safety*h*(errmax**pgrow)
    else
        hnext=4.*h
    endif
	flag=0.
  endif
  if(flag/=1.) exit
end do
do i=1,n
  y(i)=y(i)+ytemp(i)*fcor
end do
END SUBROUTINE rkqc
