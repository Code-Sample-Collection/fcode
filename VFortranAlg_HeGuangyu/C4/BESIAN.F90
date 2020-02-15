SUBROUTINE besian(x,a,nm,ih,f)
DIMENSION f(0:nm)
if (ih==1) then
    call iap(x,a,nm,f)
    return
else
    call iap(x,a,1,f)
    f(1)=2.*a*f(0)/x+f(1)
    do i=1,nm-1
        f(i+1)=2.*(a-i)*f(i)/x+f(i-1)
    end do
    return
endif
END SUBROUTINE besian
SUBROUTINE iap(x,a,nmax,f)
!USE gammln
PARAMETER (mmax=10,eps=0.00005)
DIMENSION f(0:nmax),fa(0:mmax),rr(0:mmax)
do n=0,nmax
    fa(n)=0.0
end do
sum=exp(gammln(1.+a))
sum=exp(a*log(x/2.))*exp(x)/sum
d1=2.3026*e+1.3863
if(nmax>0) then
  r=t(0.5*d1/nmax)*nmax
else
  r=0.0
endif
if(x<d1) then
  s=t(0.73576*(d1-x)/x)*1.3591*x
else
  s=1.3591*x
endif
if(r<=s) then
  nu=1+int(s)
else
  nu=1+int(r)
endif
do
  n=0
  al=1.
  do
    n=n+1
    al=al*(n+2.*a)/(n+1.)
    if (.not.n<nu) exit
  end do
  r=0.0
  s=0.0
  do
    r=1./(2.*(a+n)/x+r)
    al=al*(n+1.)/(n+2.*a)
    am=2.*(n+a)*al
    s=r*(am+s)
    if (n<=nmax) rr(n-1)=r
    n=n-1
    if (.not.n>=1) exit
  end do
  f(0)=sum/(1.+s)
  do n=0,nmax-1
    f(n+1)=rr(n)*f(n)
  end do
  do n=0,nmax
    aaa=1.
    if(abs((f(n)-fa(n))/f(n))>eps) then
	  aaa=-1.
      do m=0,nmax
        fa(m)=f(m)
      end do
      nu=nu+5
      if (.not.aaa>0.) exit
    endif
  end do
  if (.not.aaa==-1.) exit
end do
END SUBROUTINE iap
FUNCTION t(y)
if(y<=10.) then
    t=((((0.000057941*y-0.00176148)*y+0.0208645)*y-&
      0.129013)*y+0.85777)*y+1.0125
else
    z=log(y)-0.775
    p=(0.775-log(z))/(1.+z)
    t=y/(p+1.)/z
endif
END FUNCTION t
