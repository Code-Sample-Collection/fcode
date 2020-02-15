SUBROUTINE balanc(a,n)
INTEGER n
REAL a(n,n),RADIX,SQRDX
PARAMETER (RADIX=2.,SQRDX=RADIX**2)
INTEGER i,j,last
REAL c,f,g,r,s
do
  last=1
  do i=1,n
    c=0.
    r=0.
    do j=1,n
      if(j/=i) then
        c=c+abs(a(j,i))
        r=r+abs(a(i,j))
      endif
    end do
    if(c/=0..and.r/=0.) then
      g=r/RADIX
      f=1.
      s=c+r
	  do while(c<g) 
          f=f*RADIX
          c=c*SQRDX
      end do
      g=r*RADIX
      do while(c>g) 
        f=f/RADIX
        c=c/SQRDX
      end do
      if((c+r)/f<0.95*s) then
        last=0
        g=1./f
        do j=1,n
          a(i,j)=a(i,j)*g
        end do
        do j=1,n
          a(j,i)=a(j,i)*f
        end do
      endif
    endif
  end do
  if(last/=0) exit
end do
END SUBROUTINE balanc
