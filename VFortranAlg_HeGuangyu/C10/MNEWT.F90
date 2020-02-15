SUBROUTINE mnewt(ntrial,x,n,tolx,tolf)
INTEGER n,ntrial,NP
REAL tolf,tolx,x(n)
PARAMETER (NP=15)
!USES lubksb,ludcmp,usrfun
INTEGER i,k,indx(n)
REAL d,errf,errx,fjac(NP,NP),fvec(NP),p(NP)
do k=1,ntrial
  call usrfun(x,n,np,fjac,fvec)
  errf=0.
  do i=1,n
    errf=errf+abs(fvec(i))
  end do
  if(errf<=tolf) return
  call ludcmp(fjac,n,np,indx,d)
  call lubksb(fjac,n,np,indx,fvec)
  errx=0.
  do i=1,n
    errx=errx+abs(fvec(i))
    x(i)=x(i)+fvec(i)
  end do
  if(errx<=tolx) return
end do
END SUBROUTINE mnewt
