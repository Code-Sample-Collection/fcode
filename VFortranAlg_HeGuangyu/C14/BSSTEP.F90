SUBROUTINE bsstep(y,dydx,nv,x,htry,eps,yscal,hdid,&
                  hnext,derivs)
PARAMETER(nmax=10,imax=11,nuse=7,one=1.e0,&
          shrink=0.95e0,grow=1.2e0)
DIMENSION y(nv),dydx(nv),yscal(nv),yerr(nmax),&
     ysav(nmax),dysav(nmax),yseq(nmax),nseq(imax)
REAL h,htry,x,xsav,hnext
INTEGER i,j,k,m1
!USES mmid,rzextr
DATA nseq /2,4,6,8,12,16,24,32,48,64,96/
h=htry
xsav=x
do i=1,nv
  ysav(i)=y(i)
  dysav(i)=dydx(i)
end do
do
  do i=1,imax
    call mmid(ysav,dysav,nv,xsav,h,nseq(i),yseq,&
             derivs)
    xest=(h/nseq(i))**2
    call rzextr(i,xest,yseq,y,yerr,nv,nuse)
    errmax=0.
    do j=1,nv
      errmax=max(errmax,abs(yerr(j)/yscal(j)))
    end do
    errmax=errmax/eps
    if(errmax<one) then
      x=x+h
      hdid=h
      if(i==nuse) then
        hnext=h*shrink
      else if(i==nuse-1) then
        hnext=h*grow
      else
        hnext=(h*nseq(nuse-1))/nseq(i)
      endif
      return
    endif
  end do
  h=0.25*h/2**((imax-nuse)/2)
  if(x+h==x) pause 'step size underflow'
end do
END SUBROUTINE bsstep
