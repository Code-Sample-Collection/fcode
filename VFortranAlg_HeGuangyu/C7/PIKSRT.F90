SUBROUTINE piksrt(n,arr)
INTEGER n
REAL arr(n)
INTEGER i,j
REAL a
do j=2,n
  a=arr(j)
  do i=j-1,1,-1
    if(arr(i)<=a) exit
    arr(i+1)=arr(i)
  end do
  if(arr(i)<=a) then
    arr(i+1)=a
  else
    i=0
    arr(i+1)=a
  end if
end do
END SUBROUTINE piksrt
