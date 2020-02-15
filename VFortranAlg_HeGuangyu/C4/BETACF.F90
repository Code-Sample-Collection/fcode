FUNCTION betacf(a,b,x)
INTEGER maxit
REAL betacf,a,b,x,EPS,fpmin
PARAMETER (maxit=100,EPS=3.e-7,fpmin=1.e-30)
INTEGER m,m2
REAL aa,c,d,del,h,qab,qam,qap
qab=a+b
qap=a+1.
qam=a-1.
c=1.
d=1.-qab*x/qap
if(abs(d)<fpmin)d=fpmin
d=1./d
h=d
do m=1,maxit
  m2=2*m
  aa=m*(b-m)*x/((qam+m2)*(a+m2))
  d=1.+aa*d
  if(abs(d)<fpmin)d=fpmin
  c=1.+aa/c
  if(abs(c)<fpmin)c=fpmin
  d=1./d
  h=h*d*c
  aa=-(a+m)*(qab+m)*x/((a+m2)*(qap+m2))
  d=1.+aa*d
  if(abs(d)<fpmin)d=fpmin
  c=1.+aa/c
  if(abs(c)<fpmin)c=fpmin
  d=1./d
  del=d*c
  h=h*del
  if(abs(del-1.)<eps) then
    betacf=h
    return
  end if
end do
pause 'a or b too big, or maxit too small in betacf'
END FUNCTION betacf
