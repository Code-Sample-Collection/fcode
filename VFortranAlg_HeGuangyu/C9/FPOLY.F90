SUBROUTINE fpoly(x,p,np)
INTEGER np
REAL x,p(np)
INTEGER j
p(1)=1.
do j=2,np
  p(j)=p(j-1)*x
end do
END SUBROUTINE fpoly
