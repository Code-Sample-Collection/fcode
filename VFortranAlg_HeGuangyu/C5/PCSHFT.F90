SUBROUTINE pcshft(a,b,d,n)
INTEGER n
REAL a,b,d(n)
INTEGER j,k
REAL const,fac
const=2./(b-a)
fac=const
do j=2,n
  d(j)=d(j)*fac
  fac=fac*const
end do
const=0.5*(a+b)
do j=1,n-1
  do k=n-1,j,-1
    d(k)=d(k)-const*d(k+1)
  end do
end do
END SUBROUTINE pcshft
