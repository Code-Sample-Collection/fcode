SUBROUTINE qrbksb(a,n,q,b,x)
REAL a(n,n),q(n,n),b(n),x(n)
INTEGER i,j
REAL sum
do i=1,n
  sum=0.
  do j=1,n
    sum=sum+q(i,j)*b(j)
  end do
  x(i)=sum
end do
do i=n,1,-1
  sum=x(i)
  do j=i+1,n
    sum=sum-a(i,j)*x(j)
  end do
  if (a(i,i)==0.0) pause 'a is singular matrix.'
  x(i)=sum/a(i,i)
end do
END SUBROUTINE qrbksb
