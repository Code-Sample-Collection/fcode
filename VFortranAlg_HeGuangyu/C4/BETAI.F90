FUNCTION betai(a,b,x)
REAL betai,a,b,x
!USES betacf,gammln
REAL bt,betacf,gammln
if(x<0..or.x>1.) pause 'bad argument x in betai'
if(x==0..or.x==1.) then
  bt=0.
else
  bt=exp(gammln(a+b)-gammln(a)-gammln(b)+a*log(x)&
     +b*log(1.-x))
endif
if(x<(a+1.)/(a+b+2.)) then
  betai=bt*betacf(a,b,x)/a
  return
else
  betai=1.-bt*betacf(b,a,1.-x)/b
  return
endif
END FUNCTION betai
