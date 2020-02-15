SUBROUTINE qtrap(func,a,b,s)
INTEGER JMAX
REAL a,b,func,s,EPS
EXTERNAL func
PARAMETER (EPS=1.e-6, JMAX=20)
!USES trapzd
INTEGER j
REAL olds
olds=-1.e30
do j=1,JMAX
  call trapzd(func,a,b,s,j)
  if (abs(s-olds)<EPS*abs(olds)) return
  if (s==0..and.olds==0..and.j>6) return
  olds=s
end do
pause 'too many steps in qtrap'
END SUBROUTINE qtrap
