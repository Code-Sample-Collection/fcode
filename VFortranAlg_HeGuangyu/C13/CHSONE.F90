SUBROUTINE chsone(bins,ebins,nbins,knstrn,df,&
                  chsq,prob)
DIMENSION bins(nbins),ebins(nbins)
REAL df,chsq,prob
INTEGER j,nbins,knstrn
!USES gammq
df=nbins-1-knstrn
chsq=0.
do j=1,nbins
  if(ebins(j)<=0.) pause 'bad expected number'
  chsq=chsq+(bins(j)-ebins(j))**2/ebins(j)
end do
prob=gammq(0.5*df,0.5*chsq)
END SUBROUTINE chsone
