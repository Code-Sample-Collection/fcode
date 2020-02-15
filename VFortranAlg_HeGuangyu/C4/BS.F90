FUNCTION bs(N,A)
DIMENSION b(20)
REAL a,del,r,eps,s,ak,a2,da,ajp,ajm,q1,q2
if (a==0.0) then
    if (n/2==float(n)/2.) then
        b(n)=0.0
        bs=b(n)
	    return
    endif
    b(n)=2./n
    bs=b(n)
	return
endif
if (abs(a)<8.) then
    del=1.e-8
    if (n/2/=float(n)/2.) then
        r=2./float(n)
        eps=r*del
        s=r
        ak=0.
        a2=a*a
		do
          ak=ak+2.
          r=r*a2*(n+ak-2.)/(ak*(ak-1.)*(n+ak))
          s=s+r
          if (.not.r>eps) exit
		end do
        b(n)=s+r
        bs=b(n)
		return
    endif
    r=2.*a/(n+1.)
    omeg=abs(r*del)
    s=r
    ak=1.
    a2=a*a
	do
      ak=ak+2.
      r=r*a2*(n+ak-2.)/(ak*(ak-1.)*(n+ak))
      s=s+r
      if (.not.abs(r)>omeg) exit
	end do
    b(n)=-(s+r)
    bs=b(n)
	return
endif
da=1./a
ajp=da*exp(a)
ajm=(da*da)/ajp
b(1)=ajp-ajm
if(n==1) then
  bs=b(n)
  return
end if
q1=-1.
q2=1.
do m=2,n
  b(m)=q1*ajp-ajm+q2*da*b(m-1)
  q1=-q1
  q2=q2+1.
end do
bs=b(n)
END FUNCTION bs
