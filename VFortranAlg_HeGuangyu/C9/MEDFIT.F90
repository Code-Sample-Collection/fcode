SUBROUTINE medfit(x,y,ndata,a,b,abdev)
INTEGER ndata,NMAX,ndatat
PARAMETER (NMAX=1000)
REAL a,abdev,b,abdevt,X(NMAX),Y(NMAX)
!USES rofunc
INTEGER j
REAL b1,b2,bb,chisq,del,f,f1,f2,sigb,sx,sxx,sxy,sy,rofunc
COMMON /ARRAYS/ NDATAt,Xt(NMAX),Yt(NMAX),ARR(NMAX),AA,ABDEVt
sx=0.
sy=0.
sxy=0.
sxx=0.
do j=1,ndata
  xt(j)=x(j)
  yt(j)=y(j)
  sx=sx+x(j)
  sy=sy+y(j)
  sxy=sxy+x(j)*y(j)
  sxx=sxx+x(j)**2
end do
ndatat=ndata
del=ndata*sxx-sx**2
aa=(sxx*sy-sx*sxy)/del
bb=(ndata*sxy-sx*sy)/del
chisq=0.
do j=1,ndata
  chisq=chisq+(y(j)-(aa+bb*x(j)))**2
end do
sigb=sqrt(chisq/del)
b1=bb
f1=rofunc(b1)
b2=bb+sign(3.*sigb,f1)
f2=rofunc(b2)
if(b2==b1)then
  a=aa
  b=bb
  abdev=abdevt/ndata
  return
endif
do while(f1*f2>0.)
  bb=b2+1.6*(b2-b1)
  b1=b2
  f1=f2
  b2=bb
  f2=rofunc(b2)
end do
sigb=0.01*sigb
do while(abs(b2-b1)>sigb)
  bb=b1+0.5*(b2-b1)
  if(bb==b1.or.bb==b2) exit
  f=rofunc(bb)
  if(f*f1>=0.)then
    f1=f
    b1=bb
  else
    f2=f
    b2=bb
  endif
end do
a=aa
b=bb
abdev=abdevt/ndata
END SUBROUTINE medfit
