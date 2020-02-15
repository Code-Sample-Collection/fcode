SUBROUTINE vander(x,w,q,n)
PARAMETER (nmax=100,zero=0.0,one=1.0)
REAL x(n),w(n),q(n),c(nmax)
REAL xx,t,b,s
INTEGER i,n,j,k,k1
if(n==1) then
    w(1)=q(1)
else
    do i=1,n
        c(i)=zero
    end do
    c(n)=-x(1)
    do i=2,n
        xx=-x(i)
        do j=n+1-i,n-1
            c(j)=c(j)+xx*c(j+1)
        end do
        c(n)=c(n)+xx
    end do
    do i=1,n
        xx=x(i)
        t=one
        b=one
        s=q(n)
        k=n
        do j=2,n
            k1=k-1
            b=c(k)+xx*b
            s=s+q(k1)*b
            t=xx*t+b
            k=k1
        end do
        w(i)=s/t
    end do
end if
END SUBROUTINE vander
