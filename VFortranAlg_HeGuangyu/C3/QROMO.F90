SUBROUTINE qromo(func,a,b,ss,choose)
INTEGER JMAX,JMAXP,K,KM
REAL a,b,func,ss,EPS
EXTERNAL func,choose
PARAMETER (EPS=1.e-6, JMAX=14, JMAXP=JMAX+1, K=5, KM=K-1)
!USES polint
INTEGER j
REAL dss,h(JMAXP),s(JMAXP)
h(1)=1.
do j=1,JMAX
  call choose(func,a,b,s(j),j)
  if (j>=K) then
    call polint(h(j-KM),s(j-KM),K,0.,ss,dss)
    if (abs(dss)<=EPS*abs(ss)) return
  endif
  s(j+1)=s(j)
  h(j+1)=h(j)/9.
end do
pause 'too many steps in qromo'
END SUBROUTINE qromo
