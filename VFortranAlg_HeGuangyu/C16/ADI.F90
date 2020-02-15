SUBROUTINE adi(a,b,c,d,e,f,g,u,jmax,k,alpha,beta,eps)
IMPLICIT REAL*8(a-h,o-z)
PARAMETER (jj=100,kk=6,nrr=2**(kk-1),maxits=100,&
           zero=0.d0,two=2.d0,half=0.5d0)
DIMENSION a(jmax,jmax),b(jmax,jmax),c(jmax,jmax),d(jm&
     ax,jmax),e(jmax,jmax),f(jmax,jmax),g(jmax,jmax),&
     u(jmax,jmax),aa(jj),bb(jj),cc(jj),rr(jj),uu(jj),&
     psi(jj,jj),alph(kk),bet(kk),r(nrr),s(nrr,kk)
INTEGER j,k1,k,n,kits,l,nr,nits,next,jmax
if(jmax>jj) pause 'increase jj'
if(k>kk-1) pause 'increase kk'
k1=k+1
nr=2**k
alph(1)=alpha
bet(1)=beta
do j=1,k
  alph(j+1)=sqrt(alph(j)*bet(j))
  bet(j+1)=half*(alph(j)+bet(j))
end do
s(1,1)=sqrt(alph(k1)*bet(k1))
do j=1,k
  ab=alph(k1-j)*bet(k1-j)
  do n=1,2**(j-1)
    disc=sqrt(s(n,j)**2-ab)
    s(2*n,j+1)=s(n,j)+disc
    s(2*n-1,j+1)=ab/s(2*n,j+1)
  end do
end do
do n=1,nr
  r(n)=s(n,k1)
end do
anormg=zero
do j=2,jmax-1
  do l=2,jmax-1
    anormg=anormg+abs(g(j,l))
    psi(j,l)=-d(j,l)*u(j,l-1)+(r(1)-e(j,l))*u(j,l)&
             -f(j,l)*u(j,l+1)
  end do
end do
nits=maxits/nr
do kits=1,nits
  do n=1,nr
    if(n==nr) then
      next=1
    else
      next=n+1
    endif
    rfact=r(n)+r(next)
    do l=2,jmax-1
      do j=2,jmax-1
        aa(j-1)=a(j,l)
        bb(j-1)=b(j,l)+r(n)
        cc(j-1)=c(j,l)
        rr(j-1)=psi(j,l)-g(j,l)
      end do
      call tridag(aa,bb,cc,rr,uu,jmax-2)
      do j=2,jmax-1
        psi(j,l)=-psi(j,l)+two*r(n)*uu(j-1)
      end do
    end do
    do j=2,jmax-1
      do l=2,jmax-1
        aa(l-1)=d(j,l)
        bb(l-1)=e(j,l)+r(n)
        cc(l-1)=f(j,l)
        rr(l-1)=psi(j,l)
      end do
      call tridag(aa,bb,cc,rr,uu,jmax-2)
      do l=2,jmax-1
        u(j,l)=uu(l-1)
        psi(j,l)=-psi(j,l)+rfact*uu(l-1)
      end do
    end do
  end do
  anorm=zero
  do j=2,jmax-1
    do l=2,jmax-1
      resid=a(j,l)*u(j-1,l)+(b(j,l)+e(j,l))*u(j,&
            l)+c(j,l)*u(j+1,l)+d(j,l)*u(j,l-1)&
            *u(j,l-1)+f(j,l)*u(j,l+1)+g(j,l)
      anrom=anorm+abs(resid)
    end do
  end do
  if(anorm<eps*anormg) return
end do
pause 'maxits exceeded'
END SUBROUTINE adi
