FUNCTION brent(ax,bx,cx,f,tol,xmin)
INTEGER ITMAX
REAL brent,ax,bx,cx,tol,xmin,f,CGOLD,ZEPS
EXTERNAL f
PARAMETER (ITMAX=100,CGOLD=.3819660,ZEPS=1.0e-10)
INTEGER iter
REAL a,b,d,e,etemp,fu,fv,fw,fx,p,q,r,tol1,tol2,u,&
     v,w,x,xm
LOGICAL done
a=min(ax,cx)
b=max(ax,cx)
v=bx
w=v
x=v
e=0.
fx=f(x)
fv=fx
fw=fx
do iter=1,ITMAX
  xm=0.5*(a+b)
  tol1=tol*abs(x)+ZEPS
  tol2=2.*tol1
  if(abs(x-xm)<=(tol2-.5*(b-a))) exit
  done=-1
  if(abs(e)>tol1) then
    r=(x-w)*(fx-fv)
    q=(x-v)*(fx-fw)
    p=(x-v)*q-(x-w)*r
    q=2.*(q-r)
    if(q>0.) p=-p
    q=abs(q)
    etemp=e
    e=d
	dum=abs(.5*q*etemp)
    if(abs(p)>=dum.or.p<=q*(a-x).or.p>=q*(b-x)) then
      d=p/q
      u=x+d
      if(u-a<tol2.or.b-u<tol2) then
        d=sign(tol1,xm-x)
	  end if
	  done=0
	end if
  endif
  if(done) then
    if(x>=xm) then
      e=a-x
    else
      e=b-x
    endif
    d=CGOLD*e
  end if
  if(abs(d)>=tol1) then
    u=x+d
  else
    u=x+sign(tol1,d)
  endif
  fu=f(u)
  if(fu<=fx) then
    if(u>=x) then
      a=x
    else
      b=x
    endif
    v=w
    fv=fw
    w=x
    fw=fx
    x=u
    fx=fu
  else
    if(u<x) then
      a=u
    else
      b=u
    endif
    if(fu<=fw.or.w==x) then
      v=w
      fv=fw
      w=u
      fw=fu
    else if(fu<=fv.or.v==x.or.v==w) then
      v=u
      fv=fu
    endif
  end if
end do
if (iter>itmax) pause 'brent exceed maximum iterations'
xmin=x
brent=fx
END FUNCTION brent
