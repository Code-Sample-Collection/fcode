SUBROUTINE svdfit(x,y,sig,ndata,a,ma,u,v,w,mp,&
                  np,chisq,funcs)
INTEGER ma,mp,ndata,np,NMAX,MMAX
REAL chisq,a(ma),sig(ndata),u(mp,np),v(np,np),&
     w(np),x(ndata),y(ndata),TOL
EXTERNAL funcs
PARAMETER (NMAX=1000,MMAX=50,TOL=1.e-5)
!USES svbksb,svdcmp
INTEGER i,j
REAL sum,thresh,tmp,wmax,afunc(MMAX),b(NMAX)
do i=1,ndata
  call funcs(x(i),afunc,ma)
  tmp=1./sig(i)
  do j=1,ma
    u(i,j)=afunc(j)*tmp
  end do
  b(i)=y(i)*tmp
end do
call svdcmp(u,ndata,ma,w,v)
wmax=0.
do j=1,ma
  if(w(j)>wmax) wmax=w(j)
end do
thresh=TOL*wmax
do j=1,ma
  if(w(j)<thresh)w(j)=0.
end do
call svbksb(u,w,v,ndata,ma,b,a)
chisq=0.
do i=1,ndata
  call funcs(x(i),afunc,ma)
  sum=0.
  do j=1,ma
    sum=sum+a(j)*afunc(j)
  end do
  chisq=chisq+((y(i)-sum)/sig(i))**2
end do
END SUBROUTINE svdfit
