FUNCTION dbrent(ax,bx,cx,f,df,tol,xmin)
INTEGER ITMAX
REAL dbrent,ax,bx,cx,tol,xmin,ZEPS
EXTERNAL df,f
PARAMETER (ITMAX=100,ZEPS=1.0e-10)
INTEGER iter
REAL a,b,d,d1,d2,du,dv,dw,dx,e,fu,fv,fw,fx,olde,&
     tol1,tol2,u,u1,u2,v,w,x,xm
LOGICAL ok1,ok2,done
a=min(ax,cx)
b=max(ax,cx)
v=bx
w=v
x=v
e=0.
fx=f(x)
fv=fx
fw=fx
dx=df(x)
dv=dx
dw=dx
do iter=1,ITMAX
  xm=0.5*(a+b)
  tol1=tol*abs(x)+ZEPS
  tol2=2.*tol1
  if(abs(x-xm)<=(tol2-.5*(b-a))) then
    done=-1
	exit
  else
    done=0
  end if
  if(abs(e)>tol1) then
    d1=2.*(b-a)
    d2=d1
    if(dw/=dx) d1=(w-x)*dx/(dx-dw)
    if(dv/=dx) d2=(v-x)*dx/(dx-dv)
    u1=x+d1
    u2=x+d2
    ok1=((a-u1)*(u1-b)>0.).and.(dx*d1<=0.)
    ok2=((a-u2)*(u2-b)>0.).and.(dx*d2<=0.)
    olde=e
    e=d
    if(ok1.or.ok2) then
      if (ok1.and.ok2) then
        d=d1
      else
        d=d2
      endif
    else if(ok1) then
      d=d1
    else
      d=d2
    endif
    if(abs(d)>abs(0.5*olde)) then
      u=x+d
      if(u-a<tol2.or.b-u<tol2) d=sign(tol1,xm-x)
    end if
  endif
  if(dx>=0.) then
    e=a-x
  else
    e=b-x
  endif
  d=0.5*e
  if(abs(d)>=tol1) then
    u=x+d
    fu=f(u)
  else
    u=x+sign(tol1,d)
    fu=f(u)
    if(fu>fx) then
	  done=-1
	  exit
	else
	  done=0
	end if
  endif
  du=df(u)
  if(fu<=fx) then
    if(u>=x) then
      a=x
    else
      b=x
    endif
    v=w
    fv=fw
    dv=dw
    w=x
    fw=fx
    dw=dx
    x=u
    fx=fu
    dx=du
  else
    if(u<x) then
      a=u
    else
      b=u
    endif
    if(fu<=fw.or.w==x) then
      v=w
      fv=fw
      dv=dw
      w=u
      fw=fu
      dw=du
    else if(fu<=fv.or.v==x.or.v==w) then
      v=u
      fv=fu
      dv=du
    endif
  endif
end do
if (.not.done) then
  pause 'dbrent exceeded maximum iterations'
else
  xmin=x
  dbrent=fx
end if
END FUNCTION dbrent
