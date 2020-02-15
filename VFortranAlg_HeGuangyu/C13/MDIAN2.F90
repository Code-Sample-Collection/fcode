SUBROUTINE mdian2(x,n,xmed)
REAL x(n)
PARAMETER (big=1.e30,afac=1.5,amp=1.5)
REAL a,eps,ap,am,xp,xm,xx,sum,sumx,aa,xmed,dum
INTEGER np,nm,n
a=0.5*(x(1)+x(n))
eps=abs(x(n)-x(1))
ap=big
am=-big
1 sum=0.
sumx=0.
np=0
nm=0
xp=big
xm=-big
do j=1,n
  xx=x(j)
  if(xx/=a) then
    if(xx>a) then
      np=np+1
      if(xx<xp) xp=xx
    else if(xx<a) then
      nm=nm+1
      if(xx>xm) xm=xx
    endif
    dum=1./(eps+abs(xx-a))
    sum=sum+dum
    sumx=sumx+xx*dum
  endif
end do
if(np-nm>=2) then
  am=a
  aa=xp+max(0.,sumx/sum-a)*amp
  if(aa>ap) aa=0.5*(a+ap)
  eps=afac*abs(aa-a)
  a=aa
  go to 1
else if(nm-np>=2) then
  ap=a
  aa=xm+min(0.,sumx/sum-a)*amp
  if(aa<am) aa=0.5*(a+am)
  eps=afac*abs(aa-a)
  a=aa
  go to 1
else
  if(mod(n,2)==0) then
    if(np==nm) then
      xmed=0.5*(xp+xm)
    else if(np>nm) then
      xmed=0.5*(a+xp)
    else
      xmed=0.5*(xm+a)
    endif
  else
    if(np==nm) then
      xmed=a
    else if(np>nm) then
      xmed=xp
    else
      xmed=xm
    endif
  endif
endif
END SUBROUTINE mdian2
