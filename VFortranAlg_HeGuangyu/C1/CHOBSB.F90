SUBROUTINE chobsb(a,n,d,b)
REAL a(n,n),d(n),b(n)
INTEGER i,j
do i=1,n
  sum=b(i)
  do j=1,i-1
    sum=sum-a(i,j)*b(j)
  end do
  b(i)=sum
end do
do i=n,1,-1
  if (d(i)==0.) then
    pause  'singular matrix'
    return
  else
    sum=b(i)/d(i)
  endif
  do j=i+1,n
    sum=sum-a(j,i)*b(j)
  end do
  b(i)=sum
end do
END SUBROUTINE chobsb
