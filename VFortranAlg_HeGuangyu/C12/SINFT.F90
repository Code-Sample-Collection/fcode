SUBROUTINE sinft(y,n)
INTEGER n
REAL y(n)
!USES realft
INTEGER j
REAL sum,y1,y2
DOUBLE PRECISION theta,wi,wpi,wpr,wr,wtemp
theta=3.141592653589793d0/dble(n)
wr=1.0d0
wi=0.0d0
wpr=-2.0d0*sin(0.5d0*theta)**2
wpi=sin(theta)
y(1)=0.0
do j=1,n/2
  wtemp=wr
  wr=wr*wpr-wi*wpi+wr
  wi=wi*wpr+wtemp*wpi+wi
  y1=wi*(y(j+1)+y(n-j+1))
  y2=0.5*(y(j+1)-y(n-j+1))
  y(j+1)=y1+y2
  y(n-j+1)=y1-y2
end do
call realft(y,n/2,+1)
sum=0.0
y(1)=0.5*y(1)
y(2)=0.0
do j=1,n-1,2
  sum=sum+y(j)
  y(j)=y(j+1)
  y(j+1)=sum
end do
END
