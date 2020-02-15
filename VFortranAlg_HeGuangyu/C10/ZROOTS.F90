SUBROUTINE zroots(a,m,roots,polish)
INTEGER m,MAXM
REAL EPS
COMPLEX a(m+1),roots(m)
LOGICAL polish
PARAMETER (EPS=1.e-6,MAXM=101)
!USES laguer
INTEGER i,j,jj,its
COMPLEX ad(MAXM),x,b,c
do j=1,m+1
  ad(j)=a(j)
end do
do j=m,1,-1
  x=cmplx(0.,0.)
  call laguer(ad,j,x,eps,.false.)
  if(abs(aimag(x))<=2.*EPS**2*abs(real(x)))&
                               x=cmplx(real(x),0.)
  roots(j)=x
  b=ad(j+1)
  do jj=j,1,-1
    c=ad(jj)
    ad(jj)=b
    b=x*b+c
  end do
end do
if (polish) then
  do j=1,m
    call laguer(a,m,roots(j),eps,.true.)
  end do
endif
do j=2,m
  x=roots(j)
  do i=j-1,1,-1
    if(real(roots(i))<=real(x)) exit
    roots(i+1)=roots(i)
  end do
  if(real(roots(i))>real(x)) i=0
  roots(i+1)=x
end do
END SUBROUTINE zroots
