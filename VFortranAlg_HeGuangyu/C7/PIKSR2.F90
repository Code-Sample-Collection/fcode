SUBROUTINE piksr2(n,arr,brr)
INTEGER n
REAL arr(n),brr(n)
INTEGER i,j
REAL a,b
do j=2,n
  a=arr(j)
  b=brr(j)
  do i=j-1,1,-1
    if(arr(i)<=a) exit
    arr(i+1)=arr(i)
    brr(i+1)=brr(i)
  end do
  if(arr(i)<=a) then
    arr(i+1)=a
  else
    i=0
    arr(i+1)=a
  end if
  brr(i+1)=b
end do
END SUBROUTINE piksr2
