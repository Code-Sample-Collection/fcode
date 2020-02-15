SUBROUTINE mprove(a,alud,n,np,indx,b,x)
PARAMETER (nmax=100)
!USES lubksb
REAL a(np,np),alud(np,np),b(n),x(n),r(nmax)
INTEGER i,n,indx(np)
REAL*8 sdp
do i=1,n
    sdp=-b(i)
    do j=1,n
        sdp=sdp+dble(a(i,j))*dble(x(j))
    end do
    r(i)=sdp
end do
call lubksb(alud,n,np,indx,r)
do i=1,n
    x(i)=x(i)-r(i)
end do
END SUBROUTINE mprove
