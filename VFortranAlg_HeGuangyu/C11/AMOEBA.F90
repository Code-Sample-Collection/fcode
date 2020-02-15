SUBROUTINE amoeba(p,y,mp,np,ndim,ftol,funk,iter)
PARAMETER (nmax=20,alpha=1.0,beta=0.5,gamma=2.0,&
           itmax=500)
REAL p(mp,np),y(mp),pr(nmax),prr(nmax),pbar(nmax)
INTEGER i,j,ihi,inhi,ilo,mpts,iter
REAL rtol
mpts=ndim+1
iter=0
do
  ilo=1
  if (y(1)>y(2)) then
    ihi=1
    inhi=2
  else
    ihi=2
    inhi=1
  endif
  do i=1,mpts
    if (y(i)<y(ilo)) ilo=i
    if (y(i)>y(ihi)) then
        inhi=ihi
        ihi=i
    else if (y(i)>y(inhi)) then
        if (i/=ihi) inhi=i
    endif
  end do
  rtol=2.*abs(y(ihi)-y(ilo))/(abs(y(ihi))+abs(y(ilo)))
  if (rtol<ftol) return
  if (iter==itmax)&
           pause 'amoeba exceeding maximum iterations.'
  iter=iter+1
  do j=1,ndim
    pbar(j)=0.
  end do
  do i=1,mpts
    if (i/=ihi) then
      do j=1,ndim
        pbar(j)=pbar(j)+p(i,j)
      end do
    endif
  end do
  do j=1,ndim
    pbar(j)=pbar(j)/ndim
    pr(j)=(1.+alpha)*pbar(j)-alpha*p(ihi,j)
  end do
  ypr=funk(pr)
  if(ypr<=y(ilo)) then
    do j=1,ndim
      prr(j)=gamma*pr(j)+(1.-gamma)*pbar(j)
    end do
    yprr=funk(prr)
    if (yprr<y(ilo)) then
      do j=1,ndim
        p(ihi,j)=prr(j)
      end do
      y(ihi)=yprr
    else
      do j=1,ndim
        p(ihi,j)=pr(j)
      end do
      y(ihi)=ypr
    endif
  else if (ypr>=y(inhi)) then
    if (ypr<y(ihi)) then
      do j=1,ndim
        p(ihi,j)=pr(j)
      end do
      y(ihi)=ypr
    endif
    do j=1,ndim
      prr(j)=beta*p(ihi,j)+(1.-beta)*pbar(j)
    end do
    yprr=funk(prr)
    if(yprr<y(ihi)) then
      do j=1,ndim
        p(ihi,j)=prr(j)
      end do
      y(ihi)=yprr
    else
      do i=1,mpts
        if (i/=ilo) then
          do j=1,ndim
            pr(j)=0.5*(p(i,j)+p(ilo,j))
            p(i,j)=pr(j)
          end do
          y(i)=funk(pr)
        endif
      end do
    endif
  else
    do j=1,ndim
      p(ihi,j)=pr(j)
    end do
    y(ihi)=ypr
  endif
end do
END SUBROUTINE amoeba
