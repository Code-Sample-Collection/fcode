SUBROUTINE shootf(nvar,v1,v2,delv1,delv2,n1,n2,x1,&
        x2,xf,eps,h1,hmin,f,dv1,dv2)
EXTERNAL derivs,rkqc
PARAMETER (np=20)
!USES load1,odeint,score,load2,ludcmp,lubksb
DIMENSION v1(n2),delv1(n2),v2(n1),delv2(n1),f(nvar),&
     dv1(n2),dv2(n1),y(np),f1(np),f2(np),dfdv(np,np)&
     ,indx(np)
REAL sav,x1,h1,eps,xf,hmin
INTEGER iv,j,n2,i,nvar
call load1(x1,v1,y)
call odeint(y,nvar,x1,xf,eps,h1,hmin,nok,nbad,&
            derivs,rkqc)
call score(xf,y,f1)
call load2(x2,v2,y)
call odeint(y,nvar,x2,xf,eps,h1,hmin,nok,nbad,&
            derivs,rkqc)
call score(xf,y,f2)
j=0
do iv=1,n2
  j=j+1
  sav=v1(iv)
  v1(iv)=v1(iv)+delv1(iv)
  call load1(x1,v1,y)
  call odeint(y,nvar,x1,xf,eps,h1,hmin,nok,nbad,&
              derivs,rkqc)
  call score(xf,y,f)
  do i=1,nvar
    dfdv(i,j)=(f(i)-f1(i))/delv1(iv)
  end do
  v1(iv)=sav
end do
do iv=1,n1
  j=j+1
  sav=v2(iv)
  v2(iv)=v2(iv)+delv2(iv)
  call load2(x2,v2,y)
  call odeint(y,nvar,x2,xf,eps,h1,hmin,nok,nbad,&
              derivs,rkqc)
  call score(xf,y,f)
  do i=1,nvar
    dfdv(i,j)=(f2(i)-f(i))/delv2(iv)
  end do
  v2(iv)=sav
end do
do i=1,nvar
  f(i)=f1(i)-f2(i)
  f1(i)=-f(i)
end do
call ludcmp(dfdv,nvar,np,indx,det)
call lubksb(dfdv,nvar,np,indx,f1)
j=0
do iv=1,n2
  j=j+1
  v1(iv)=v1(iv)+f1(j)
  dv1(iv)=f1(j)
end do
do iv=1,n1
  j=j+1
  v2(iv)=v2(iv)+f1(j)
  dv2(iv)=f1(j)
end do
END SUBROUTINE shootf
