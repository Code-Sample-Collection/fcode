SUBROUTINE zbrac(func,x1,x2,succes)
INTEGER NTRY
REAL x1,x2,func,FACTOR
EXTERNAL func
PARAMETER (FACTOR=1.6,NTRY=50)
INTEGER j
REAL f1,f2
LOGICAL succes
if(x1==x2) &
  pause 'you have to guess an initial range in zbrac'
f1=func(x1)
f2=func(x2)
succes=.true.
do j=1,NTRY
  if(f1*f2<0.) return
  if(abs(f1)<abs(f2)) then
    x1=x1+FACTOR*(x1-x2)
    f1=func(x1)
  else
    x2=x2+FACTOR*(x2-x1)
    f2=func(x2)
  endif
end do
succes=.false.
END SUBROUTINE zbrac
