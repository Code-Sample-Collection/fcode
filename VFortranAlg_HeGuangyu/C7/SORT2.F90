SUBROUTINE sort2(n,ra,rb)
DIMENSION ra(n),rb(n)
l=n/2+1
ir=n
do
  if(l>1) then
    l=l-1
    rra=ra(l)
    rrb=rb(l)
  else
    rra=ra(ir)
    rrb=rb(ir)
    ra(ir)=ra(1)
    rb(ir)=rb(1)
    ir=ir-1
    if(ir==1) then
      ra(1)=rra
      rb(1)=rrb
      return
    endif
  endif
  i=l
  j=l+l
  do while(j<=ir) 
    if(j.lt.ir) then
      if(ra(j)<ra(j+1)) j=j+1
    endif
    if(rra<ra(j)) then
      ra(i)=ra(j)
      rb(i)=rb(j)
      i=j
      j=j+j
    else
      j=ir+1
    endif
  end do
  ra(i)=rra
  rb(i)=rrb
end do
END SUBROUTINE sort2
