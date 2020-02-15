SUBROUTINE shoot(nvar,v,delv,n2,x1,x2,eps,h1,hmin,&
                 f,dv)
EXTERNAL derivs,rkqc
PARAMETER (np=20)
!USES ideint,score,load,ludcmp,lubksb
DIMENSION v(n2),delv(n2),f(n2),dv(n2),y(np),&
          dfdv(np,np),indx(np)
REAL sav,x1,x2,eps,h1,hmin
INTEGER n2,iv,i
call load(x1,v,y)
call odeint(y,nvar,x1,x2,eps,h1,hmin,nok,nbad,&
            derivs,rkqc)
call score(x2,y,f)
do iv=1,n2
  sav=v(iv)
  v(iv)=v(iv)+delv(iv)
  call load(x1,v,y)
  call odeint(y,nvar,x1,x2,eps,h1,hmin,nok,nbad,&
              derivs,rkqc)
  call score(x2,y,dv)
  do i=1,n2
    dfdv(i,iv)=(dv(i)-f(i))/delv(iv)
  end do
  v(iv)=sav
end do
do iv=1,n2
  dv(iv)=-f(iv)
end do
call ludcmp(dfdv,n2,np,indx,det)
call lubksb(dfdv,n2,np,indx,dv)
do iv=1,n2
  v(iv)=v(iv)+dv(iv)
end do
END SUBROUTINE shoot
