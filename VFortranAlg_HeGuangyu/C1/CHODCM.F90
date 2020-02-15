SUBROUTINE chodcm(a,n,d,t)
REAL a(n,n),d(n),t(n)
INTEGER i,j
do i=1,n
  sum=a(i,i)
  do j=1,i-1
    t(j)=a(j,i)
    do k=1,j-1
      t(j)=t(j)-t(k)*a(j,k)
    end do
    if (d(j)==0.) then
      if (t(j)/=0.) then
        pause 'no cholesky decomposition'
      else
        a(i,j)=1.0
      endif
    else
      a(i,j)=t(j)/d(j)
    endif
    sum=sum-t(j)*a(i,j)
  end do
  d(i)=sum
end do
END SUBROUTINE chodcm
