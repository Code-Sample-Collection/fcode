SUBROUTINE odeint(ystart,nvar,x1,x2,eps,h1,hmin,nok,&
                  nbad,derivs,rkqc)
PARAMETER (maxstp=10000,nmax=10,two=2.0,zero=0.0,&
           tiny=1.e-30)
COMMON /path/ kmax,kount,dxsav,xp(200),yp(10,200)
!USES rkqc
DIMENSION ystart(nvar),yscal(nmax),y(nmax),dydx(nmax)
REAL x,x1,x2,eps,hmin,hdid,h,xsav
INTEGER nok,nbad,kount,nstp,i
EXTERNAL derivs
x=x1
h=sign(h1,x2-x1)
nok=0
nbad=0
kount=0
do i=1,nvar
  y(i)=ystart(i)
end do
xsav=x-dxsav*two
do nstp=1,maxstp
  call derivs(x,y,dydx)
  do i=1,nvar
    yscal(i)=abs(y(i))+abs(h*dydx(i))+tiny
  end do
  if(kmax>0)then
    if(abs(x-xsav)>abs(dxsav))  then
      if(kount<kmax-1)  then
        kount=kount+1
        xp(kount)=x
        do i=1,nvar
          yp(i,kount)=y(i)
        end do
        xsav=x
      endif
    endif
  endif
  if((x+h-x2)*(x+h-x1)>zero) h=x2-x
  call rkqc(y,dydx,nvar,x,h,eps,yscal,hdid,hnext,&
              derivs)
  if(hdid==h) then
    nok=nok+1
  else
    nbad=nbad+1
  endif
  if((x-x2)*(x2-x1)>=zero) then
    do i=1,nvar
      ystart(i)=y(i)
    end do
    if(kmax/=0) then
      kount=kount+1
      xp(kount)=x
      do i=1,nvar
        yp(i,kount)=y(i)
      end do
    endif
    return
  endif
  if(abs(hnext)<hmin)&
             pause 'stepsize smaller than minimum.'
  h=hnext
end do
PAUSE 'Too many steps.'
END SUBROUTINE odeint
