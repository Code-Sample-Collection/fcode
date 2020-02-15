FUNCTION bessy(n,x)
INTEGER n
REAL bessy,x
!USES bessy0,bessy1
INTEGER j
REAL by,bym,byp,tox,bessy0,bessy1
if(n<2) pause 'bad argument n in bessy'
tox=2./x
by=bessy1(x)
bym=bessy0(x)
do j=1,n-1
  byp=j*tox*by-bym
  bym=by
  by=byp
end do
bessy=by
END FUNCTION bessy
