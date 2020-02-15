SUBROUTINE sor(a,b,c,d,e,f,u,jmax,rjac)
IMPLICIT real*8(a-h,o-z)
DIMENSION a(jmax,jmax),b(jmax,jmax),c(jmax,jmax),&
 d(jmax,jmax),e(jmax,jmax),f(jmax,jmax),u(jmax,jmax)
PARAMETER (maxits=1000,eps=1.d-5,zero=0.d0,half=.5d0,&
             qtr=0.25d0,one=1.d0)
REAL anormf,anorm,omega,rjac
INTEGER j,l,n,jmax
anormf=zero
do j=2,jmax-1
  do l=2,jmax-1
    anormf=anormf+abs(f(j,l))
  end do
end do
omega=one
do n=1,maxits
  anorm=zero
  do j=2,jmax-1
    do l=2,jmax-1
      if(mod(j+l,2)==mod(n,2)) then
        resid=a(j,l)*u(j+1,l)+b(j,l)*u(j-1,&
              l)+c(j,l)*u(j,l+1)+d(j,l)*u(j,&
			  l-1)+e(j,l)*u(j,l)-f(j,l)
        anorm=anorm+abs(resid)
        u(j,l)=u(j,l)-omega*resid/e(j,l)
      endif
    end do
  end do
  if(n==1) then
    omega=one/(one-half*rjac**2)
  else
    omega=one/(one-qtr*rjac**2*omega)
  endif
  if((n>1).and.(anorm<eps*anormf)) return
end do
pause 'maxits exceeded'
END SUBROUTINE sor
