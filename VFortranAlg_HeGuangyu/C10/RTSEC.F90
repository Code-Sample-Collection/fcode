FUNCTION rtsec(func,x1,x2,xacc)
INTEGER MAXIT
REAL rtsec,x1,x2,xacc,func
EXTERNAL func
PARAMETER (MAXIT=30)
INTEGER j
REAL dx,f,fl,swap,xl
fl=func(x1)
f=func(x2)
if(abs(fl)<abs(f)) then
  rtsec=x1
  xl=x2
  swap=fl
  fl=f
  f=swap
else
  xl=x1
  rtsec=x2
endif
do j=1,MAXIT
  dx=(xl-rtsec)*f/(f-fl)
  xl=rtsec
  fl=f
  rtsec=rtsec+dx
  f=func(rtsec)
  if(abs(dx)<xacc.or.f==0.) return
end do
pause 'rtsec exceed maximum iterations'
END FUNCTION rtsec
