SUBROUTINE tred2(a,n,d,e)
INTEGER n
REAL a(n,n),d(n),e(n)
INTEGER i,j,k,l
REAL f,g,h,hh,scale
do i=n,2,-1
  l=i-1
  h=0.
  scale=0.
  if(l>1)then
    do k=1,l
      scale=scale+abs(a(i,k))
    end do
    if(scale==0.) then
      e(i)=a(i,l)
    else
      do k=1,l
        a(i,k)=a(i,k)/scale
        h=h+a(i,k)**2
      end do
      f=a(i,l)
      g=-sign(sqrt(h),f)
      e(i)=scale*g
      h=h-f*g
      a(i,l)=f-g
      f=0.
      do j=1,l
!Omit following line if finding only eigenvalues
        a(j,i)=a(i,j)/h
        g=0.
        do k=1,j
          g=g+a(j,k)*a(i,k)
        end do
        do k=j+1,l
          g=g+a(k,j)*a(i,k)
        end do
        e(j)=g/h
        f=f+e(j)*a(i,j)
      end do
      hh=f/(h+h)
      do j=1,l
        f=a(i,j)
        g=e(j)-hh*f
        e(j)=g
        do k=1,j
          a(j,k)=a(j,k)-f*e(k)-g*a(i,k)
        end do
      end do
    endif
  else
    e(i)=a(i,l)
  endif
  d(i)=h
end do
!Omit following line if finding only eigenvalues.
d(1)=0.
e(1)=0.
do i=1,n
!Delete lines from here ...
  l=i-1
  if(d(i)/=0.)then
    do j=1,l
      g=0.
      do k=1,l
        g=g+a(i,k)*a(k,j)
      end do
      do k=1,l
        a(k,j)=a(k,j)-g*a(k,i)
      end do
    end do
  endif
!... to here when finding only eigenvalues.
  d(i)=a(i,i)
!Also delete lines from here ...
  a(i,i)=1.
  do j=1,l
    a(i,j)=0.
    a(j,i)=0.
  end do
!... to here when finding only eigenvalues.
end do
END SUBROUTINE tred2 
