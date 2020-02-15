FUNCTION rtbis(func,x1,x2,xacc)
INTEGER JMAX
REAL rtbis,x1,x2,xacc,func
EXTERNAL func
PARAMETER (JMAX=40)
INTEGER j
REAL dx,f,fmid,xmid
fmid=func(x2)
f=func(x1)
if(f*fmid>=0.)&
          pause 'root must be bracketed in rtbis'
if(f<0.)then
  rtbis=x1
  dx=x2-x1
else
  rtbis=x2
  dx=x1-x2
endif
do j=1,JMAX
  dx=dx*.5
  xmid=rtbis+dx
  fmid=func(xmid)
  if(fmid<=0.)rtbis=xmid
  if(abs(dx)<xacc .or. fmid==0.) return
end do
pause 'too many bisections in rtbis'
END FUNCTION rtbis
