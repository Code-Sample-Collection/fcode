FUNCTION gammq(a,x)
REAL a,gammq,x
!USES gcf,gser
REAL gammcf,gamser,gln
if(x<0..or.a<=0.) pause 'bad arguments in gammq'
if(x<a+1.) then
  call gser(gamser,a,x,gln)
  gammq=1.-gamser
else
  call gcf(gammcf,a,x,gln)
  gammq=gammcf
endif
END FUNCTION gammq
