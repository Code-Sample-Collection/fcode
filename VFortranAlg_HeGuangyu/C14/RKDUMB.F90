SUBROUTINE rkdumb(vstart,nvar,x1,x2,nstep,derivs)
PARAMETER (nmax=10)
COMMON /path/ xx(200),y(10,200)
!USES rk4
DIMENSION vstart(nvar),v(nmax),dv(nmax)
REAL x,x1,x2,h
INTEGER i,nstep,k
EXTERNAL derivs
do i=1,nvar
  v(i)=vstart(i)
  y(i,1)=v(i)
end do
xx(1)=x1
x=x1
h=(x2-x1)/nstep
do k=1,nstep
  call derivs(x,v,dv)
  call rk4(v,dv,nvar,x,h,v,derivs)
  if(x+h==x)&
         pause 'stepsize not signficant in rkdumb.'
  x=x+h
  xx(k+1)=x
  do i=1,nvar
    y(i,k+1)=v(i)
  end do
end do
END SUBROUTINE rkdumb
