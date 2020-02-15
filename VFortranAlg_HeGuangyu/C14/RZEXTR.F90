SUBROUTINE rzextr(iest,xest,yest,yz,dy,nv,nuse)
PARAMETER (imax=11,nmax=10,ncol=7)
DIMENSION x(imax),yest(nv),yz(nv),dy(nv),&
          d(nmax,ncol),fx(ncol)
REAL yy,v,c,b,b1,ddy
INTEGER j,nv,k,m1
x(iest)=xest
if(iest==1) then
  do j=1,nv
    yz(j)=yest(j)
    d(j,1)=yest(j)
    dy(j)=yest(j)
  end do
else
  m1=min(iest,nuse)
  do k=1,m1-1
    fx(k+1)=x(iest-k)/xest
  end do
  do j=1,nv
    yy=yest(j)
    v=d(j,1)
    c=yy
    d(j,1)=yy
    do k=2,m1
      b1=fx(k)*v
      b=b1-c
      if(b/=0.) then
        b=(c-v)/b
        ddy=c*b
        c=b1*b
      else
        ddy=v
      endif
      v=d(j,k)
      d(j,k)=ddy
      yy=yy+ddy
    end do
    dy(j)=ddy
    yz(j)=yy
  end do
endif
END SUBROUTINE rzextr
