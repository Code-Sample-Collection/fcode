SUBROUTINE chstwo(bins1,bins2,nbins,knstrn,df,chsq,&
                  prob)
DIMENSION bins1(nbins),bins2(nbins)
!USES gammq
REAL chsq,prob,df
INTEGER j,nbins,knstrn 
df=nbins-1-knstrn
chsq=0.
do j=1,nbins
  if(bins1(j)==0..and.bins2(j)==0.)then
    df=df-1.
  else
    chsq=chsq+(bins1(j)-bins2(j))**2/(bins1(j)+&
             bins2(j))
  endif
end do
prob=gammq(0.5*df,0.5*chsq)
END SUBROUTINE chstwo
