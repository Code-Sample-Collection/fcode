SUBROUTINE frprmn(p,n,ftol,iter,fret)
INTEGER iter,n,NMAX,ITMAX
REAL fret,ftol,p(n),EPS,func
EXTERNAL func
PARAMETER (NMAX=50,ITMAX=200,EPS=1.e-10)
!USES dfunc,func,linmin
INTEGER its,j
REAL dgg,fp,gam,gg,g(NMAX),h(NMAX),xi(NMAX)
fp=func(p)
call dfunc(p,xi)
do j=1,n
  g(j)=-xi(j)
  h(j)=g(j)
  xi(j)=h(j)
end do
do its=1,ITMAX
  iter=its
  call linmin(p,xi,n,fret)
  if(2.*abs(fret-fp)<=ftol*(abs(fret)+abs(fp)+EPS))&
          return
  fp=func(p)
  call dfunc(p,xi)
  gg=0.
  dgg=0.
  do j=1,n
    gg=gg+g(j)**2
    dgg=dgg+xi(j)**2   !polak-ribiere ·¨
!    dgg=dgg+(xi(j)+g(j))*xi(j) !Fletcker-Reeves ·¨
  end do
  if(gg==0.) return
  gam=dgg/gg
  do j=1,n
    g(j)=-xi(j)
    h(j)=g(j)+gam*h(j)
    xi(j)=h(j)
  end do
end do
pause 'frprmn maximum iterations exceeded'
END SUBROUTINE frprmn
