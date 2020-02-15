FUNCTION zbrent(func,x1,x2,tol)
INTEGER ITMAX
REAL zbrent,tol,x1,x2,func,EPS
EXTERNAL func
PARAMETER (ITMAX=100,EPS=3.e-8)
INTEGER iter
REAL a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm
a=x1
b=x2
fa=func(a)
fb=func(b)
if((fa>0..and.fb>0.).or.(fa<0..and.fb<0.))&
        pause 'root must be bracketed for zbrent'
c=b
fc=fb
do iter=1,ITMAX
  if((fb>0..and.fc>0.).or.(fb<0..and.fc<0.)) then
    c=a
    fc=fa
    d=b-a
    e=d
  endif
  if(abs(fc)<abs(fb)) then
    a=b
    b=c
    c=a
    fa=fb
    fb=fc
    fc=fa
  endif
  tol1=2.*EPS*abs(b)+0.5*tol
  xm=.5*(c-b)
  if(abs(xm)<=tol1.or.fb==0.)then
    zbrent=b
    return
  endif
  if(abs(e)>=tol1 .and. abs(fa)>abs(fb)) then
    s=fb/fa
    if(a==c) then
      p=2.*xm*s
      q=1.-s
    else
      q=fa/fc
      r=fb/fc
      p=s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
      q=(q-1.)*(r-1.)*(s-1.)
    endif
    if(p>0.) q=-q
    p=abs(p)
    if(2.*p<min(3.*xm*q-abs(tol1*q),abs(e*q))) then
      e=d
      d=p/q
    else
      d=xm
      e=d
    endif
  else
    d=xm
    e=d
  endif
  a=b
  fa=fb
  if(abs(d)>tol1) then
    b=b+d
  else
    b=b+sign(tol1,xm)
  endif
  fb=func(b)
end do
pause 'zbrent exceeding maximum iterations'
zbrent=b
END FUNCTION zbrent
