SUBROUTINE mmid(y,dydx,nvar,xs,htot,nstep,yout,&
               derivs)
PARAMETER (nmax=10)
DIMENSION y(nvar),dydx(nvar),yout(nvar),ym(nmax),&
          yn(nmax)
REAL xs,htot,x,swap,h
INTEGER nstep,nvar,n,i
h=htot/nstep
do i=1,nvar
  ym(i)=y(i)
  yn(i)=y(i)+h*dydx(i)
end do
x=xs+h
call derivs(x,yn,yout)
h2=2.*h
do n=2,nstep
  do i=1,nvar
    swap=ym(i)+h2*yout(i)
    ym(i)=yn(i)
    yn(i)=swap
  end do
  x=x+h
  call derivs(x,yn,yout)
end do
do i=1,nvar
  yout(i)=0.5*(ym(i)+yn(i)+h*yout(i))
end do
END SUBROUTINE mmid
