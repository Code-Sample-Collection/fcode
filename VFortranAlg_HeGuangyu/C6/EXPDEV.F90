FUNCTION expdev(idum)
INTEGER idum
REAL expdev
!USES ran1
REAL dum,ran1
do
  dum=ran1(idum)
  if(.not.dum==0.) exit
end do
expdev=-log(dum)
END FUNCTION expdev
