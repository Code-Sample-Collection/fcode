FUNCTION ran3(idum)
INTEGER idum
INTEGER MBIG,MSEED,MZ
!REAL MBIG,MSEED,MZ
REAL ran3,FAC
PARAMETER (MBIG=1000000000,MSEED=161803398,MZ=0,FAC=1./MBIG)
!PARAMETER (MBIG=4000000.,MSEED=1618033.,MZ=0.,FAC=1./MBIG)
INTEGER i,iff,ii,inext,inextp,k
INTEGER mj,mk,ma(55)
!REAL mj,mk,ma(55)
SAVE iff,inext,inextp,ma
DATA iff /0/
if(idum<0.or.iff==0) then
  iff=1
  mj=MSEED-iabs(idum)
  mj=mod(mj,MBIG)
  ma(55)=mj
  mk=1
  do i=1,54
    ii=mod(21*i,55)
    ma(ii)=mk
    mk=mj-mk
    if(mk<MZ) mk=mk+MBIG
    mj=ma(ii)
  end do
  do k=1,4
    do i=1,55
      ma(i)=ma(i)-ma(1+mod(i+30,55))
      if(ma(i)<MZ) ma(i)=ma(i)+MBIG
    end do
  end do
  inext=0
  inextp=31
  idum=1
endif
inext=inext+1
if(inext==56) inext=1
inextp=inextp+1
if(inextp==56) inextp=1
mj=ma(inext)-ma(inextp)
if(mj<MZ) mj=mj+MBIG
ma(inext)=mj
ran3=mj*FAC
END FUNCTION ran3
