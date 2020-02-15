SUBROUTINE pendag(a,b,c,d,e,r,u,n)
PARAMETER (nmax=100)
REAL a(n),b(n),c(n),d(n),e(n),r(n),u(n),w(nmax),&
          beta(nmax),alpha(nmax),cg(nmax),h(nmax)
INTEGER k,n
w(1)=c(1)
beta(1)=0.0
beta(2)=d(1)/w(1)
alpha(1)=0.0
alpha(2)=e(1)/w(1)
alpha(n)=0.0
alpha(n+1)=0.0
do k=2,n
    cg(k)=b(k)-a(k)*beta(k-1)
    w(k)=c(k)-a(k)*alpha(k-1)-cg(k)*beta(k)
    if(w(k).eq.0.0) pause '    w(k)=0.0 in pendag'
    beta(k+1)=(d(k)-cg(k)*alpha(k))/w(k)
    alpha(k+1)=e(k)/w(k)
end do
    h(1)=0.0
    h(2)=r(1)/w(1)
do k=2,n
    h(k+1)=(r(k)-a(k)*h(k-1)-cg(k)*h(k))/w(k)
end do
    u(n)=h(n+1)
    u(n-1)=h(n)-beta(n)*u(n)
do k=n-2,1,-1
    u(k)=h(k+1)-beta(k+1)*u(k+1)-alpha(k+1)*u(k+2)
end do
END SUBROUTINE pendag
