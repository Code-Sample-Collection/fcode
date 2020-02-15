SUBROUTINE fourn(data,nn,ndim,isign)
INTEGER isign,ndim,nn(ndim)
REAL data(*)
INTEGER i1,i2,i2rev,i3,i3rev,ibit,idim,ifp1,&
        ifp2,ip1,ip2,ip3,k1,k2,n,nprev,nrem,ntot
REAL tempi,tempr
DOUBLE PRECISION theta,wi,wpi,wpr,wr,wtemp
ntot=1
do idim=1,ndim
  ntot=ntot*nn(idim)
end do
nprev=1
do idim=1,ndim
  n=nn(idim)
  nrem=ntot/(n*nprev)
  ip1=2*nprev
  ip2=ip1*n
  ip3=ip2*nrem
  i2rev=1
  do i2=1,ip2,ip1
    if(i2<i2rev)then
      do i1=i2,i2+ip1-2,2
        do i3=i1,ip3,ip2
          i3rev=i2rev+i3-i2
          tempr=data(i3)
          tempi=data(i3+1)
          data(i3)=data(i3rev)
          data(i3+1)=data(i3rev+1)
          data(i3rev)=tempr
          data(i3rev+1)=tempi
        end do
      end do
    endif
    ibit=ip2/2
    do while((ibit>=ip1).and.(i2rev>ibit)) 
      i2rev=i2rev-ibit
      ibit=ibit/2
    end do
    i2rev=i2rev+ibit
  end do
  ifp1=ip1
  do while(ifp1<ip2)
    ifp2=2*ifp1
    theta=isign*6.28318530717959d0/(ifp2/ip1)
    wpr=-2.d0*sin(0.5d0*theta)**2
    wpi=sin(theta)
    wr=1.d0
    wi=0.d0
    do i3=1,ifp1,ip1
      do i1=i3,i3+ip1-2,2
        do i2=i1,ip3,ifp2
          k1=i2
          k2=k1+ifp1
          tempr=sngl(wr)*data(k2)-sngl(wi)*data(k2+1)
          tempi=sngl(wr)*data(k2+1)+sngl(wi)*data(k2)
          data(k2)=data(k1)-tempr
          data(k2+1)=data(k1+1)-tempi
          data(k1)=data(k1)+tempr
          data(k1+1)=data(k1+1)+tempi
        end do
      end do
      wtemp=wr
      wr=wr*wpr-wi*wpi+wr
      wi=wi*wpr+wtemp*wpi+wi
    end do
    ifp1=ifp2
  end do
  nprev=n*nprev
end do
END SUBROUTINE fourn
