SUBROUTINE qsimp(func,a,b,s)
INTEGER JMAX
REAL a,b,func,s,EPS
EXTERNAL func
PARAMETER (EPS=1.e-6, JMAX=20)
!USES trapzd
INTEGER j
REAL os,ost,st
ost=-1.e30
os= -1.e30
do j=1,JMAX
  call trapzd(func,a,b,st,j)
  s=(4.*st-ost)/3.
  if (abs(s-os)<EPS*abs(os)) return
  if (s==0..and.os==0..and.j>6) return
  os=s
  ost=st
end do
pause 'too many steps in qsimp'
END SUBROUTINE qsimp
