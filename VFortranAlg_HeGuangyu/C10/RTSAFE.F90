FUNCTION rtsafe(funcd,x1,x2,xacc)
INTEGER MAXIT
REAL rtsafe,x1,x2,xacc
EXTERNAL funcd
PARAMETER (MAXIT=100)
INTEGER j
REAL df,dx,dxold,f,fh,fl,temp,xh,xl
call funcd(x1,fl,df)
call funcd(x2,fh,df)
if((fl>0..and.fh>0.).or.(fl<0..and.fh<0.))&
            pause 'root must be bracketed in rtsafe'
if(fl==0.) then
  rtsafe=x1
  return
else if(fh==0.) then
  rtsafe=x2
  return
else if(fl<0.) then
  xl=x1
  xh=x2
else
  xh=x1
  xl=x2
endif
rtsafe=.5*(x1+x2)
dxold=abs(x2-x1)
dx=dxold
call funcd(rtsafe,f,df)
do j=1,MAXIT
  if(((rtsafe-xh)*df-f)*((rtsafe-xl)*df-f)>0.&
                .or.abs(2.*f)>abs(dxold*df) ) then
    dxold=dx
    dx=0.5*(xh-xl)
    rtsafe=xl+dx
    if(xl==rtsafe) return
  else
    dxold=dx
    dx=f/df
    temp=rtsafe
    rtsafe=rtsafe-dx
    if(temp==rtsafe) return
  endif
  if(abs(dx)<xacc) return
  call funcd(rtsafe,f,df)
  if(f<0.) then
    xl=rtsafe
  else
    xh=rtsafe
  endif
end do
pause 'rtsafe exceeding maximum iterations'
END FUNCTION rtsafe
