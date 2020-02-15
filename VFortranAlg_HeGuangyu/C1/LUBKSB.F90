SUBROUTINE lubksb(a,n,np,indx,b)
DIMENSION a(np,np),indx(n),b(n)
ii=0
do i=1,n
    ll=indx(i)
    sum=b(ll)
    b(ll)=b(i)
    if (ii/=0) then
        do j=ii,i-1
            sum=sum-a(i,j)*b(j)
        end do
    else if (sum/=0.) then
        ii=i
    endif
    b(i)=sum
end do
do i=n,1,-1
    sum=b(i)
    if(i<n) then
        do j=i+1,n
            sum=sum-a(i,j)*b(j)
        end do
    endif
    b(i)=sum/a(i,i)
end do
END SUBROUTINE lubksb
