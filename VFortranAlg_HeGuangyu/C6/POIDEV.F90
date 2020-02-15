FUNCTION poidev(xm,idum)
INTEGER idum
REAL poidev,xm,PI
PARAMETER (PI=3.141592654)
!USES gammln,ran1
REAL alxm,em,g,oldm,sq,t,y,gammln,ran1
SAVE alxm,g,oldm,sq
DATA oldm /-1./
if (xm<12.)then
  if (xm/=oldm) then
    oldm=xm
    g=exp(-xm)
  endif
  em=-1
  t=1.
  do
    em=em+1.
    t=t*ran1(idum)
    if (.not.t>g) exit
  end do
else
  if (xm/=oldm) then
    oldm=xm
    sq=sqrt(2.*xm)
    alxm=log(xm)
    g=xm*alxm-gammln(xm+1.)
  endif
  do
    do
      y=tan(PI*ran1(idum))
      em=sq*y+xm
      if (.not.em<0.) exit
    end do
    em=int(em)
    t=0.9*(1.+y**2)*exp(em*alxm-gammln(em+1.)-g)
    if (.not.ran1(idum)>t) exit
  end do
endif
poidev=em
END FUNCTION poidev
