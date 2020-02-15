SUBROUTINE gser(gamser,a,x,gln)
INTEGER ITMAX
REAL a,gamser,gln,x,EPS
PARAMETER (ITMAX=100,EPS=3.e-7)
!USES gammln
INTEGER n
REAL ap,del,sum,gammln
gln=gammln(a)
if(x<=0.) then
  if(x<0.) pause 'x < 0 in gser'
  gamser=0.
  return
endif
ap=a
sum=1./a
del=sum
do n=1,ITMAX
  ap=ap+1.
  del=del*x/ap
  sum=sum+del
  if(abs(del)<abs(sum)*EPS) then
    gamser=sum*exp(-x+a*log(x)-gln)
	return
  end if  
end do
pause 'a too large, ITMAX too small in gser'
END SUBROUTINE gser 
