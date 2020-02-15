SUBROUTINE chder(a,b,c,cder,n)
INTEGER n
REAL a,b,c(n),cder(n)
INTEGER j
REAL con
cder(n)=0.
cder(n-1)=2*(n-1)*c(n)
do j=n-2,1,-1
  cder(j)=cder(j+2)+2*j*c(j+1)
end do
con=2./(b-a)
do j=1,n
  cder(j)=cder(j)*con
end do
END SUBROUTINE chder
