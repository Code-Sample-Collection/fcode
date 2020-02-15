FUNCTION bessk(n,x)
INTEGER n
REAL bessk,x
!USES bessk0,bessk1
INTEGER j
REAL bk,bkm,bkp,tox,bessk0,bessk1
if (n<2) pause 'bad argument n in bessk'
tox=2.0/x
bkm=bessk0(x)
bk=bessk1(x)
do j=1,n-1
  bkp=bkm+j*tox*bk
  bkm=bk
  bk=bkp
end do
bessk=bk
END FUNCTION bessk
