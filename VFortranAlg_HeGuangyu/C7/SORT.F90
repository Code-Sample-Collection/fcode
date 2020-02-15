SUBROUTINE sort(n,ra)
REAL ra(n)
INTEGER i,ir,j,l
REAL a,aaa,rra
l=n/2+1
ir=n
do 
  if (l>1) then
    l=l-1
    rra=ra(l)
  else
    rra=ra(ir)
    ra(ir)=ra(1)
    ir=ir-1
    if (ir==1) then
      ra(1)=rra
      return
    endif
  endif
  i=l
  j=l+l
  do while(j<=ir) 
    aaa=1.
    if (j<ir) then
      if (ra(j)<ra(j+1)) j=j+1
    endif
    if (rra<ra(j)) then
      ra(i)=ra(j)
      i=j
      j=j+j
    else
      j=ir+1
    endif
  end do 
  ra(i)=rra
end do
END SUBROUTINE sort
