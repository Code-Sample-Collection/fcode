FUNCTION bessj(n,x)
INTEGER n,IACC
REAL bessj,x,BIGNO,BIGNI
PARAMETER (IACC=40,BIGNO=1.e10,BIGNI=1.e-10)
!USES bessj0,bessj1
INTEGER j,jsum,m
REAL ax,bj,bjm,bjp,sum,tox,bessj0,bessj1
if(n<2) pause 'bad argument n in bessj'
ax=abs(x)
if(ax==0.) then
  bessj=0.
else if(ax>float(n)) then
  tox=2./ax
  bjm=bessj0(ax)
  bj=bessj1(ax)
  do j=1,n-1
    bjp=j*tox*bj-bjm
    bjm=bj
    bj=bjp
  end do
  bessj=bj
else
  tox=2./ax
  m=2*((n+int(sqrt(float(IACC*n))))/2)
  bessj=0.
  jsum=0
  sum=0.
  bjp=0.
  bj=1.
  do j=m,1,-1
    bjm=j*tox*bj-bjp
    bjp=bj
    bj=bjm
    if(abs(bj)>BIGNO) then
      bj=bj*BIGNI
      bjp=bjp*BIGNI
      bessj=bessj*BIGNI
      sum=sum*BIGNI
    endif
    if(jsum/=0) sum=sum+bj
    jsum=1-jsum
    if(j==n) bessj=bjp
  end do
  sum=2.*sum-bj
  bessj=bessj/sum
endif
if(x<0..and.mod(n,2)==1) bessj=-bessj
END FUNCTION bessj
