FUNCTION gamdev(ia,idum)
INTEGER ia,idum
REAL gamdev
!USES ran1
INTEGER j
REAL am,e,s,v1,v2,x,y,ran1
if(ia<1) pause 'bad argument in gamdev'
if(ia<6) then
  x=1.
  do j=1,ia
    x=x*ran1(idum)
  end do
  x=-log(x)
else
  do
    do
	  do
        v1=ran1(idum)
        v2=2.*ran1(idum)-1.
        if(.not.v1**2+v2**2>1.) exit
	  end do
      y=v2/v1
      am=ia-1
      s=sqrt(2.*am+1.)
      x=s*y+am
      if(.not.x<=0.) exit
	end do
    e=(1.+y**2)*exp(am*log(x/am)-s*y)
    if(.not.ran1(idum)>e) exit
  end do
endif
gamdev=x
END FUNCTION gamdev
