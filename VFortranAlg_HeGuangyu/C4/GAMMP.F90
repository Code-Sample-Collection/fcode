FUNCTION gammp(a,x)
REAL a,gammp,x
!USES gcf,gser
REAL gammcf,gamser,gln
if(x<0..or.a<=0.) pause 'bad arguments in gammp'
if(x<a+1.)then
  call gser(gamser,a,x,gln)
  gammp=gamser
else
  call gcf(gammcf,a,x,gln)
  gammp=1.-gammcf
endif
END FUNCTION gammp
