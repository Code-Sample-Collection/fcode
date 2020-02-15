FUNCTION erfc(x)
REAL erfc,x
!USES gammp,gammq
REAL gammp,gammq
if(x<0.)then
  erfc=1.+gammp(.5,x**2)
else
  erfc=gammq(.5,x**2)
endif
END FUNCTION erfc
