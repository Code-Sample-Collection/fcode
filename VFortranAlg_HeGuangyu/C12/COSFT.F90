SUBROUTINE  cosft(y,n,isign)
REAL*8  wr,wi,wpr,wpi,wtemp,theta
!USES realft
REAL y(n),sum,odd,even,enf0,sum0,sume
REAL y1,y2
INTEGER j,m,n,isign
theta=3.14159265358979d0/dfloat(n)
wr=1.0d0
wi=0.0d0
wpr=-2.0d0*dsin(0.5d0*theta)**2
wpi=dsin(theta)
sum=y(1)
m=n/2
do j=1,m-1
  wtemp=wr
  wr=wr*wpr-wi*wpi+wr
  wi=wi*wpr+wtemp*wpi+wi
  y1=0.5*(y(j+1)+y(n-j+1))
  y2=(y(j+1)-y(n-j+1))
  y(j+1)=y1-wi*y2
  y(n-j+1)=y1+wi*y2
  sum=sum+wr*y2
end do
call realft(y,m,+1)
y(2)=sum
do j=4,n,2
  sum=sum+y(j)
  y(j)=sum
end do
if (isign==-1) then
  even=y(1)
  odd=y(2)
  do i=3,n-1,2
    even=even+y(i)
    odd=odd+y(i+1)
  end do
  enf0=2.0*(even-odd)
  sum0=y(1)-enf0
  sume=(2.0*odd/float(n))-sum0
  y(1)=0.5*enf04
  y(2)=y(2)-sume
  do i=3,n-1,2
    y(i)=y(i)-sum0
    y(i+1)=y(i+1)-sume
  end do
endif
END SUBROUTINE  cosft
