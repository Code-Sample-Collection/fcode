SUBROUTINE ksone(data1,n,func,d,prob)
DIMENSION data1(n)
!USES sort
REAL en,d,fo,fn,ff,dt,prob
INTEGER j,n
call sort(n,data1)
en=n
d=0.
fo=0.
do j=1,n
  fn=j/en
  ff=func(data1(j))
  dt=amax1(abs(fo-ff),abs(fn-ff))
  if(dt>d) d=dt
  fo=fn
end do
prob=probks(sqrt(en)*d)
END SUBROUTINE ksone
