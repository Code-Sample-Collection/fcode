FUNCTION rtflsp(func,x1,x2,xacc)
INTEGER MAXIT
REAL rtflsp,x1,x2,xacc,func
EXTERNAL func
PARAMETER (MAXIT=30)
INTEGER j
REAL del,dx,f,fh,fl,swap,xh,xl
fl=func(x1)
fh=func(x2)
if(fl*fh>0.) pause 'root must be bracketed in rtflsp'
if(fl<0.)then
  xl=x1
  xh=x2
else
  xl=x2
  xh=x1
  swap=fl
  fl=fh
  fh=swap
endif
dx=xh-xl
do j=1,MAXIT
  rtflsp=xl+dx*fl/(fl-fh)
  f=func(rtflsp)
  if(f<0.) then
    del=xl-rtflsp
    xl=rtflsp
    fl=f
  else
    del=xh-rtflsp
    xh=rtflsp
    fh=f
  endif
  dx=xh-xl
  if(abs(del)<xacc.or.f==0.)return
end do
pause 'rtflsp exceed maximum iterations'
END FUNCTION rtflsp
