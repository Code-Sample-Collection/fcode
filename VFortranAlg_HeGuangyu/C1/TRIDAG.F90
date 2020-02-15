SUBROUTINE tridag(a,b,c,r,u,n)
PARAMETER (nmax=100)
REAL gam(nmax),a(n),b(n),c(n),u(n),r(n)
INTEGER j,n
if (b(1)==0.) pause 'b(1)=0 in tridag'
bet=b(1)
u(1)=r(1)/bet
do j=2,n
    gam(j)=c(j-1)/bet
    bet=b(j)-a(j)*gam(j)
    if (bet==0.) pause 'bet=0 in tridag'
    u(j)=(r(j)-a(j)*u(j-1))/bet
end do
do j=n-1,1,-1
    u(j)=u(j)-gam(j+1)*u(j+1)
end do
END SUBROUTINE tridag
