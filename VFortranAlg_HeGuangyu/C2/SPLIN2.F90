SUBROUTINE splin2(x1a,x2a,ya,y2a,m,n,x1,x2,y)
INTEGER m,n,NN
REAL x1,x2,y,x1a(m),x2a(n),y2a(m,n),ya(m,n)
PARAMETER (NN=100)
!USES spline,splint
INTEGER j,k
REAL y2tmp(NN),ytmp(NN),yytmp(NN)
do j=1,m
  do k=1,n
    ytmp(k)=ya(j,k)
    y2tmp(k)=y2a(j,k)
  end do
  call splint(x2a,ytmp,y2tmp,n,x2,yytmp(j))
end do
call spline(x1a,yytmp,m,1.e30,1.e30,y2tmp)
call splint(x1a,yytmp,y2tmp,m,x1,y)
END SUBROUTINE splin2
