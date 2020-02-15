FUNCTION rofunc(b)
PARAMETER (nmax=1000)
!USES sort
COMMON /arrays/ ndata,x(nmax),y(nmax),arr(nmax),aa,abdev
n1=ndata+1
nml=n1/2
nmh=n1-nml
do j=1,ndata
    arr(j)=y(j)-b*x(j)
end do
call sort(ndata,arr)
aa=0.5*(arr(nml)+arr(nmh))
sum=0.
abdev=0.
do j=1,ndata
    d=y(j)-(b*x(j)+aa)
    abdev=abdev+abs(d)
    sum=sum+x(j)*sign(1.0,d)
end do
rofunc=sum
END FUNCTION rofunc
