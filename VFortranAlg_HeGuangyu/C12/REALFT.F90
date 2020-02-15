SUBROUTINE realft(data1,n,isign)
REAL*8 wr,wi,wpi,wpr,wtemp,theta
DIMENSION data1(2*n)
!USES four1
INTEGER n,isign,i1,i2,i3,i4,i
REAL c2,h2r,h2i,qrs,wis,h1r,h1i
theta=6.28318530717959d0/2.0d0/dfloat(n)
c1=0.5
if (isign==1) then
  c2=-0.5
  call four1(data1,n,+1)
else
  c2=0.5
  theta=-theta
endif
wpr=-2.0d0*dsin(0.5d0*theta)**2
wpi=dsin(theta)
wr=1.0d0+wpr
wi=wpi
n2p3=2*n+3
do i=2,n/2+1
  i1=2*i-1
  i2=i1+1
  i3=n2p3-i2
  i4=i3+1
  wrs=sngl(wr)
  wis=sngl(wi)
  h1r=c1*(data1(i1)+data1(i3))
  h1i=c1*(data1(i2)-data1(i4))
  h2r=-c2*(data1(i2)+data1(i4))
  h2i=c2*(data1(i1)-data1(i3))
  data1(i1)=h1r+wrs*h2r-wis*h2i
  data1(i2)=h1i+wrs*h2i+wis*h2r
  data1(i3)=h1r-wrs*h2r+wis*h2i
  data1(i4)=-h1i+wrs*h2i+wis*h2r
  wtemp=wr
  wr=wr*wpr-wi*wri+wr
  wi=wi*wpr+wtemp*wpi+wi
end do
if (isign==1) then
  h1r=data1(1)
  data1(1)=h1r+data1(2)
  data1(2)=h1r-data1(2)
else
  h1r=data1(1)
  data1(1)=c1*(h1r+data1(2))
  data1(2)=c1*(h1r-data1(2))
  call four1(data1,n,-1)
endif
END SUBROUTINE realft
