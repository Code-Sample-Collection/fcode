SUBROUTINE kstwo(data1,n1,data2,n2,d,prob)
DIMENSION data1(n1),data2(n2)
!USES probks,sort
REAL en1,en2,fo1,fo2,fn1,dt
INTEGER j1,j2,n1,n2
call sort(n1,data1)
call sort(n2,data2)
en1=n1
en2=n2
j1=1
j2=1
fo1=0.
fo2=0.
d=0.
do while(j1<=n1.and.j2<=n2)
  if(data1(j1)<data2(j2)) then
    fn1=j1/en1
    dt=amax1(abs(fn1-fo2),abs(fo1-fo2))
    if(dt>d) d=dt
    fo1=fn1
    j1=j1+1
  else
    fn2=j2/en2
    dt=amax1(abs(fn2-fo1),abs(fo2-fo1))
    if(dt>d) d=dt
    fo2=fn2
    j2=j2+1
  endif
end do
prob=probks(sqrt(en1*en2/(en1+en2))*d)
END SUBROUTINE kstwo
