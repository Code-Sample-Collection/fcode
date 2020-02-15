SUBROUTINE laguer(a,m,x,eps,polish)
COMPLEX a,x,dx,x1,b,d,f,g,h,sq,gp,gm,g2,zero
!dimension a(m+1)
DIMENSION a(*)
LOGICAL polish
PARAMETER (zero=(0.,0.),epss=6.e-8,maxit=100)
INTEGER iter,j
dxold=cabs(x)
do iter=1,maxit
  b=a(m+1)
  err=cabs(b)
  d=zero
  f=zero
  abx=cabs(x)
  do j=m,1,-1
    f=x*f+d
    d=x*d+b
    b=x*b+a(j)
    err=cabs(b)+abx*err
  end do
  err=epss*err
  if(cabs(b)<=err) then
    dx=zero
    return
  else
    g=d/b
    g2=g*g
    h=g2-2.*f/b
    sq=csqrt((m-1)*(m*h-g2))
    gp=g+sq
    gm=g-sq
    if(cabs(gp)<cabs(gm)) gp=gm
    dx=m/gp
  endif
  x1=x-dx
  if(x==x1) return
  x=x1
  cdx=cabs(dx)
  if(iter>6.and.cdx>=dxold) return
  dxold=cdx
  if(.not.polish) then
    if(cabs(dx)<=eps*cabs(x)) return
  endif
end do
PAUSE 'too many iterations'
END SUBROUTINE laguer
