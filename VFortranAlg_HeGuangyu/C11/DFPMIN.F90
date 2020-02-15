SUBROUTINE dfpmin(p,n,ftol,iter,fret)
PARAMETER (nmax=50,itmax=200,eps=1.e-10)
!USES linmin
REAL p(n),hessin(nmax,nmax),xi(nmax),g(nmax),&
          dg(nmax),hdg(nmax)
INTEGER i,j,its
REAL fac,fae,fad,fp
fp=func(p)
call dfunc(p,g)
do i=1,n
  do j=1,n
    hessin(i,j)=0.
  end do
  hessin(i,i)=1.
  xi(i)=-g(i)
end do
do its=1,itmax
  iter=its
  call linmin(p,xi,n,fret)
  if(2.*abs(fret-fp)<=ftol*(abs(fret)+abs(fp)+eps))&
                           return
  fp=fret
  do i=1,n
      dg(i)=g(i)
  end do
  fret=func(p)
  call dfunc(p,g)
  do i=1,n
    dg(i)=g(i)-dg(i)
  end do
  do i=1,n
    hdg(i)=0.
    do j=1,n
      hdg(i)=hdg(i)+hessin(i,j)*dg(j)
    end do
  end do
  fac=0.
  fae=0.
  do i=1,n
    fac=fac+dg(i)*xi(i)
    fae=fae+dg(i)*hdg(i)
  end do
  fac=1./fac
  fad=1./fae
  do i=1,n
    dg(i)=fac*xi(i)-fad*hdg(i)
  end do
  do i=1,n
    do j=1,n
      hessin(i,j)=hessin(i,j)+fac*xi(i)*xi(j)&
           -fad*hdg(i)*hdg(j)+fae*dg(i)*dg(j)
    end do
  end do
  do i=1,n
    xi(i)=0.
    do j=1,n
      xi(i)=xi(i)-hessin(i,j)*g(j)
    end do
  end do
end do
PAUSE 'too many iterations in DFPMIN'
END SUBROUTINE dfpmin
