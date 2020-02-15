FUNCTION as(n,b)
DIMENSION a(15)
INTEGER n,i
REAL db
a(1)=exp(-b)/b
if (n==1) then
  as=a(n)
else
  db=1./b
  do i=2,n
    a(i)=a(1)+db*(i-1)*a(i-1)
  end do
  as=a(n)
end if
END FUNCTION as
