FUNCTION ran1(idum)
INTEGER idum,ia,im,iq,ir,ntab,ndiv
REAL ran1,am,eps,rnmx
PARAMETER (ia=16807,im=2147483647,am=1./im,&
     iq=127773,ir=2836,ntab=32,ndiv=1+(im-1)/ntab,&
	 eps=1.2e-7,rnmx=1.-eps)
INTEGER j,k,iv(ntab),iy
SAVE iv,iy
DATA iv /ntab*0/, iy /0/
if (idum<=0.or.iy==0) then
  idum=max(-idum,1)
  do j=ntab+8,1,-1
    k=idum/iq
    idum=ia*(idum-k*iq)-ir*k
    if (idum<0) idum=idum+im
    if (j<=ntab) iv(j)=idum
  end do
  iy=iv(1)
endif
k=idum/iq
idum=ia*(idum-k*iq)-ir*k
if (idum<0) idum=idum+im
j=1+iy/ndiv
iy=iv(j)
iv(j)=idum
ran1=min(am*iy,rnmx)
END FUNCTION ran1
