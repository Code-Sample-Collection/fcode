SUBROUTINE qroot(p,n,b,c,eps)
INTEGER n,NMAX,ITMAX
REAL b,c,eps,p(n),TINY
PARAMETER (NMAX=20,ITMAX=20,TINY=1.0e-6)
!USES poldiv
INTEGER iter
REAL delb,delc,div,r,rb,rc,s,sb,sc,d(3),q(NMAX),&
     qq(NMAX),rem(NMAX)
d(3)=1.
do iter=1,ITMAX
  d(2)=b
  d(1)=c
  call poldiv(p,n,d,3,q,rem)
  s=rem(1)
  r=rem(2)
  call poldiv(q,n-1,d,3,qq,rem)
  sc=-rem(1)
  rc=-rem(2)
  sb=-c*rc
  rb=sc-b*rc
  div=1./(sb*rc-sc*rb)
  delb=(r*sc-s*rc)*div
  delc=(-r*sb+s*rb)*div
  b=b+delb
  c=c+delc
  if((abs(delb)<=eps*abs(b).or.abs(b)<TINY).and.&
      (abs(delc)<=eps*abs(c).or.abs(c)<TINY)) return
end do
pause 'too many iterations in qroot'
END SUBROUTINE qroot
