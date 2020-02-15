SUBROUTINE svbksb(u,w,v,m,n,b,x)
PARAMETER (nmax=100)
REAL u(m,n),w(n),v(n,n),b(n),x(n),tnmax(nmax),s
INTEGER j,jj
do j=1,n
  s=0.0
  if (w(j)/=0.0) then
    do i=1,m
      s=s+u(i,j)*b(i)
    end do
    s=s/w(j)
  end if
  tnmax(j)=s
end do
do j=1,n
  s=0.0
  do jj=1,n
    s=s+v(j,jj)*tnmax(jj)
  end do
  x(j)=s
end do
END SUBROUTINE svbksb
