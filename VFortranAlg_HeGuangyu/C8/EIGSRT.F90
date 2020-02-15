SUBROUTINE eigsrt(d,v,n)
INTEGER n,np
REAL d(n),v(n,n)
INTEGER i,j,k
REAL p
do i=1,n-1
  k=i
  p=d(i)
  do j=i+1,n
    if(d(j)>=p) then
      k=j
      p=d(j)
    endif
  end do
  if(k/=i) then
    d(k)=d(i)
    d(i)=p
    do j=1,n
      p=v(j,i)
      v(j,i)=v(j,k)
      v(j,k)=p
    end do
  endif
end do
END SUBROUTINE eigsrt
