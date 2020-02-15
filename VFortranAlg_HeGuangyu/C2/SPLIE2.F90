SUBROUTINE splie2(x1a,x2a,ya,m,n,y2a)
INTEGER m,n,NN
REAL x1a(m),x2a(n),y2a(m,n),ya(m,n)
PARAMETER (NN=100)
!USES spline
INTEGER j,k
REAL y2tmp(NN),ytmp(NN)
do j=1,m
  do k=1,n
    ytmp(k)=ya(j,k)
  end do
  call spline(x2a,ytmp,n,1.e30,1.e30,y2tmp)
  do k=1,n
    y2a(j,k)=y2tmp(k)
  end do
end do
END SUBROUTINE splie2
