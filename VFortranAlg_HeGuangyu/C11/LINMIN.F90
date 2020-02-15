SUBROUTINE linmin(p,xi,n,fret)
INTEGER n,NMAX
REAL fret,p(n),xi(n),tol
PARAMETER (nmax=50,TOL=1.e-4)
!USES brent,f1dim,mnbrak,df1dim
INTEGER j,ncom
REAL ax,bx,fa,fb,fx,xmin,xx,pcom(nmax),&
     xicom(nmax),brent
COMMON /f1com/ pcom,xicom,ncom
EXTERNAL f1dim  !Powell 法
!EXTERNAL df1dim !共轭梯度法
ncom=n
do j=1,n
  pcom(j)=p(j)
  xicom(j)=xi(j)
end do
ax=0.
xx=1.
call mnbrak(ax,xx,bx,fa,fx,fb,f1dim)
fret=brent(ax,xx,bx,f1dim,tol,xmin)  !Powell 法
!fret=dbrent(ax,xx,bx,f1dim,df1dim,tol,xmin) !共轭梯度法
do j=1,n
  xi(j)=xmin*xi(j)
  p(j)=p(j)+xi(j)
end do
END SUBROUTINE linmin
