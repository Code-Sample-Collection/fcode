SUBROUTINE sparse(b,n,asub,atsub,x,rsq)
PARAMETER (nmax=500,eps=1.e-6)
DIMENSION b(n),x(n),g(nmax),h(nmax),xi(nmax),xj(nmax)
LOGICAL done
eps2=n*eps**2
irst=0
do
  done=-1
  irst=irst+1
  call asub(x,xi)
  rp=0.0
  bsq=0.0
  do j=1,n
    bsq=bsq+b(j)**2
    xi(j)=xi(j)-b(j)
    rp=rp+xi(j)**2
  end do
  call atsub(xi,g)
  do j=1,n
    g(j)=-g(j)
    h(j)=g(j)
  end do
  do iter=1,10*n
    call asub(h,xi)
    anum=0.
    aden=0.
    do j=1,n
      anum=anum+g(j)*h(j)
      aden=aden+xi(j)**2
    end do
    if(aden==0.0 ) pause 'very singular matrix'
    anum=anum/aden
    do j=1,n
      xi(j)=x(j)
      x(j)=x(j)+anum*h(j)
    end do
    call asub(x,xj)
    rsq=0.
    do j=1,n
      xj(j)=xj(j)-b(j)
      rsq=rsq+xj(j)**2
    end do
    if(rsq==rp.or.rsq<=bsq*eps2) return
    if(rsq>rp) then
      do j=1,n
        x(j)=xi(j)
      end do
      if(irst>=3) return
      done=0
    end if
	if(.not.done) exit
    rp=rsq
    call atsub(xj,xi)
    gg=0.0
    dgg=0.0
    do j=1,n
      gg=gg+g(j)**2
      dgg=dgg+(xi(j)+g(j))*xi(j)
    end do
    if(gg==0.) return
    gam=dgg/gg
    do j=1,n
      g(j)=-xi(j)
      h(j)=g(j)+gam*h(j)
    end do
  end do
  if(.not.done) exit
end do
PAUSE 'too many iterations'
END SUBROUTINE sparse
