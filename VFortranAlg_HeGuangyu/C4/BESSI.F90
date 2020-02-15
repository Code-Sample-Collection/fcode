FUNCTION bessi(n,x)
INTEGER n,IACC
REAL bessi,x,BIGNO,BIGNI
PARAMETER (IACC=40,BIGNO=1.0e10,BIGNI=1.0e-10)
!USES bessi0
INTEGER j,m
REAL bi,bim,bip,tox,bessi0
if (n<2) pause 'bad argument n in bessi'
if (x==0.) then
  bessi=0.
else
  tox=2.0/abs(x)
  bip=0.0
  bi=1.0
  bessi=0.
  m=2*((n+int(sqrt(float(IACC*n)))))
  do j=m,1,-1
    bim=bip+float(j)*tox*bi
    bip=bi
    bi=bim
    if (abs(bi)>BIGNO) then
      bessi=bessi*BIGNI
      bi=bi*BIGNI
      bip=bip*BIGNI
    endif
    if (j==n) bessi=bip
  end do
  bessi=bessi*bessi0(x)/bi
  if (x<0..and.mod(n,2)==1) bessi=-bessi
endif
END FUNCTION bessi
