SUBROUTINE four1(data1,nn,isign)
INTEGER isign,nn
REAL data1(2*nn)
INTEGER i,istep,j,m,mmax,n
REAL tempi,tempr
DOUBLE PRECISION theta,wi,wpi,wpr,wr,wtemp
n=2*nn
j=1
do i=1,n,2
  if(j>i)then
    tempr=data1(j)
    tempi=data1(j+1)
    data1(j)=data1(i)
    data1(j+1)=data1(i+1)
    data1(i)=tempr
    data1(i+1)=tempi
  endif
  m=n/2
  do while((m>=2).and.(j>m)) 
    j=j-m
    m=m/2
  end do
  j=j+m
end do
mmax=2
do while(n>mmax) 
  istep=2*mmax
  theta=6.28318530717959d0/(isign*mmax)
  wpr=-2.d0*dsin(0.5d0*theta)**2
  wpi=dsin(theta)
  wr=1.d0
  wi=0.d0
  do m=1,mmax,2
    do i=m,n,istep
      j=i+mmax
      tempr=sngl(wr)*data1(j)-sngl(wi)*data1(j+1)
      tempi=sngl(wr)*data1(j+1)+sngl(wi)*data1(j)
      data1(j)=data1(i)-tempr
      data1(j+1)=data1(i+1)-tempi
      data1(i)=data1(i)+tempr
      data1(i+1)=data1(i+1)+tempi
    end do
    wtemp=wr
    wr=wr*wpr-wi*wpi+wr
    wi=wi*wpr+wtemp*wpi+wi
  end do
  mmax=istep
end do
END SUBROUTINE four1
