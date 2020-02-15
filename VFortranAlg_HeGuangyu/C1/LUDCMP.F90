SUBROUTINE ludcmp(a,n,np,indx,d)
PARAMETER (nmax=100,tiny=1.0e-20)
DIMENSION a(np,np),indx(n),vv(nmax)
d=1.
do i=1,n
    aamax=0.
    do j=1,n
        if (abs(a(i,j))>aamax) aamax=abs(a(i,j))
    end do
    if (aamax==0.) pause 'singular matrix.'
    vv(i)=1./aamax
end do
do j=1,n
    if (j>1) then
        do i=1,j-1
            sum=a(i,j)
            if (i>1) then
                do k=1,i-1
                    sum=sum-a(i,k)*a(k,j)
                end do
                a(i,j)=sum
            endif
        end do
    endif
    aamax=0.
    do i=j,n
        sum=a(i,j)
        if (j>1) then
            do k=1,j-1
                sum=sum-a(i,k)*a(k,j)
            end do
            a(i,j)=sum
        endif
        dum=vv(i)*abs(sum)
        if (dum>=aamax) then
            imax=i
            aamax=dum
        endif
    end do
    if (j/=imax) then
        do k=1,n
            dum=a(imax,k)
            a(imax,k)=a(j,k)
            a(j,k)=dum
        end do
        d=-d
        vv(imax)=vv(j)
    endif
    indx(j)=imax
    if (j/=n) then
        if (a(j,j)==0.) a(j,j)=tiny
        dum=1./a(j,j)
        do i=j+1,n
            a(i,j)=a(i,j)*dum
        end do
    endif
end do
if(a(n,n)==0.) a(n,n)=tiny
END SUBROUTINE ludcmp
