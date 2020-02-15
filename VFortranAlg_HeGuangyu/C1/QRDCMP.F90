SUBROUTINE qrdcmp(a,m,n,q)
REAL a(n,n),q(m,m)
INTEGER i,k,j
REAL s,t,f,h
do i=1,m
  do j=1,m
    q(i,j)=0.
  end do
  q(i,i)=1.
end do
do k=1,m-1
  s=0.
  do i=k,m
    s=s+abs(a(i,k))
  end do
  if (s/=0.) then
    t=0.
    do i=k,m
      a(i,k)=a(i,k)/s
      t=t+a(i,k)*a(i,k)
    end do
    t=-sign(sqrt(t),a(k,k))
    a(k,k)=a(k,k)-t
    h=-t*a(k,k)
    do j=k+1,n
      f=0.
      do i=k,m
        f=f+a(i,k)*a(i,j)
      end do
      f=f/h
      do i=k,m
        a(i,j)=a(i,j)-a(i,k)*f
      end do
    end do
    do j=1,m
      f=0.
      do i=k,m
        f=f+a(i,k)*q(i,j)
      end do
      f=f/h
      do i=k,m
        q(i,j)=q(i,j)-a(i,k)*f
      end do
    end do
    a(k,k)=t*s
    do i=k+1,m
      a(i,k)=0.
    end do
  endif
end do
END SUBROUTINE qrdcmp
