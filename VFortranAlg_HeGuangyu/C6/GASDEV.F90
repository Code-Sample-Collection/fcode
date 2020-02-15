FUNCTION gasdev(idum)
INTEGER idum
REAL gasdev
!USES ran1
INTEGER iset
REAL fac,gset,rsq,v1,v2,ran1
SAVE iset,gset
DATA iset/0/
if (iset==0) then
  do
    v1=2.*ran1(idum)-1.
    v2=2.*ran1(idum)-1.
    rsq=v1**2+v2**2
    if(.NOT.(rsq>=1..or.rsq==0.)) EXIT
  end do
  fac=sqrt(-2.*log(rsq)/rsq)
  gset=v1*fac
  gasdev=v2*fac
  iset=1
else
  gasdev=gset
  iset=0
endif
END FUNCTION gasdev
 