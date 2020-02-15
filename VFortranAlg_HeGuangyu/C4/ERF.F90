FUNCTION erf(x)
REAL erf,x
!USES gammp
REAL gammp
if(x<0.)then
  erf=-gammp(.5,x**2)
else
  erf=gammp(.5,x**2)
endif
END FUNCTION erf
