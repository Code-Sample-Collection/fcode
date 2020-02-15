SUBROUTINE pzextr(iest,xest,yest,yz,dy,nv,nuse)
PARAMETER (imax=11,ncol=7,nmax=10)
DIMENSION x(imax),yest(nv),yz(nv),dy(nv),&
          qcol(nmax,ncol),d(nmax)
REAL xest,f1,delta,f2,q
INTEGER nv,nuse,j,k1,m1,itest
x(iest)=xest
do j=1,nv
  dy(j)=yest(j)
  yz(j)=yest(j)
end do
if(iest==1)then
  do j=1,nv
    qcol(j,1)=yest(j)
  end do
else
  m1=min(iest,nuse)
  do j=1,nv
    d(j)=yest(j)
  end do
  do k1=1,m1-1
    delta=1./(x(iest-k1)-xest)
    f1=xest*delta
    f2=x(iest-k1)*delta
    do j=1,nv
      q=qcol(j,k1)
      qcol(j,k1)=dy(j)
      delta=d(j)-q
      dy(j)=f1*delta
      d(j)=f2*delta
      yz(j)=yz(j)+dy(j)
    end do
  end do
  do j=1,nv
    qcol(j,m1)=dy(j)
  end do
endif
END SUBROUTINE pzextr
