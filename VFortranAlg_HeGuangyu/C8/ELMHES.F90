SUBROUTINE elmhes(a,n)
INTEGER n
REAL a(n,n)
INTEGER i,j,m
REAL x,y
do m=2,n-1
  x=0.
  i=m
  do j=m,n
    if(abs(a(j,m-1))>abs(x)) then
      x=a(j,m-1)
      i=j
    endif
  end do
  if(i/=m) then
    do j=m-1,n
      y=a(i,j)
      a(i,j)=a(m,j)
      a(m,j)=y
    end do
    do j=1,n
      y=a(j,i)
      a(j,i)=a(j,m)
      a(j,m)=y
    end do
  endif
  if(x/=0.) then
    do i=m+1,n
      y=a(i,m-1)
      if(y/=0.) then
        y=y/x
        a(i,m-1)=y
        do j=m,n
          a(i,j)=a(i,j)-y*a(m,j)
        end do
        do j=1,n
          a(j,m)=a(j,m)+y*a(j,i)
        end do
      endif
    end do
  endif
end do
END SUBROUTINE elmhes
