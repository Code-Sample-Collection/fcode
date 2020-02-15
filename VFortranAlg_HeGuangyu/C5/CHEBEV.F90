FUNCTION chebev(a,b,c,m,x)
INTEGER m
REAL chebev,a,b,x,c(m)
INTEGER j
REAL d,dd,sv,y,y2
if ((x-a)*(x-b)>0.) pause 'x not in range in chebev'
d=0.
dd=0.
y=(2.*x-a-b)/(b-a)
y2=2.*y
do j=m,2,-1
  sv=d
  d=y2*d-dd+c(j)
  dd=sv
end do
chebev=y*d-dd+0.5*c(1)
END FUNCTION chebev
