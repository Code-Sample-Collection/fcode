SUBROUTINE locate(xx,n,x,j)
INTEGER j,n
REAL aaa,x,xx(n)
INTEGER jl,jm,ju
jl=0
ju=n+1
do
  aaa=0.
  if(ju-jl>1) then
    aaa=2.
    jm=(ju+jl)/2
    if((xx(n)>=xx(1)).eqv.(x>=xx(jm))) then
      jl=jm
    else
      ju=jm
    endif
    if(.not.aaa>1.) exit
  endif
  if(.not.aaa>1.) exit
end do
if(x==xx(1)) then
  j=1
else if(x==xx(n)) then
  j=n-1
else
  j=jl
endif
END SUBROUTINE locate
