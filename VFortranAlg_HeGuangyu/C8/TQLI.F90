SUBROUTINE tqli(d,e,n,z)
INTEGER n
REAL d(n),e(n),z(n,n)
INTEGER i,iter,k,l,m
LOGICAL done
REAL b,c,dd,f,g,p,r,s
do i=2,n
  e(i-1)=e(i)
end do
e(n)=0.
do l=1,n
  iter=0
  do
    done=0
    do m=l,n-1
      dd=abs(d(m))+abs(d(m+1))
      if (abs(e(m))+dd==dd) exit
    end do
	if((abs(e(m))+dd)/=dd)  m=n
    if(m/=l) then
      if(iter==30) pause 'too many iterations in tqli'
      iter=iter+1
      g=(d(l+1)-d(l))/(2.*e(l))
      r=sqrt(g**2+1.)
      g=d(m)-d(l)+e(l)/(g+sign(r,g))
      s=1.
      c=1.
      p=0.
      do i=m-1,l,-1
        f=s*e(i)
        b=c*e(i)
        if(abs(f)>=abs(g)) then
          c=g/f
		  r=sqrt(c**2+1.)
		  e(i+1)=f*r
		  s=1/r
		  c=c*s
		else
          s=f/g
		  r=sqrt(s**2+1.)
		  e(i+1)=g*r
		  c=1/r
		  s=c*s
        endif
        g=d(i+1)-p
        r=(d(i)-g)*s+2.*c*b
        p=s*r
        d(i+1)=g+p
        g=c*r-b
!Omit lines from here ...
        do k=1,n
          f=z(k,i+1)
          z(k,i+1)=s*z(k,i)+c*f
          z(k,i)=c*z(k,i)-s*f
        end do
!... to here when finding only eigenvalues.
      end do
      d(l)=d(l)-p
      e(l)=g
      e(m)=0.
      done=-1
    endif
	if (.not.done) exit
  end do
end do
END SUBROUTINE tqli

