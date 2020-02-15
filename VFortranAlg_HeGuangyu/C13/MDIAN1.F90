SUBROUTINE mdian1(x,n,xmed)
REAL x(n),xmed
INTEGER n2,n
!USES sort
call sort(n,x)
n2=n/2
if (2*n2==n) then
  xmed=0.5*(x(n2)+x(n2+1))
else
  xmed=x(n2+1)
endif
END SUBROUTINE mdian1
