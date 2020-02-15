SUBROUTINE indexx(n,arrin,indx)
DIMENSION arrin(n),indx(n)
do j=1,n
  indx(j)=j
end do
l=n/2+1
ir=n
do
  if(l>1)then
    l=l-1
    indxt=indx(l)
    q=arrin(indxt)
  else
    indxt=indx(ir)
    q=arrin(indxt)
    indx(ir)=indx(1)
    ir=ir-1
    if(ir==1) then
      indx(1)=indxt
      return
    endif
  endif
  i=l
  j=l+l
  do while(j<=ir) 
    if(j<ir) then
      if(arrin(indx(j))<arrin(indx(j+1))) j=j+1
    endif
    if(q<arrin(indx(j))) then
      indx(i)=indx(j)
      i=j
      j=j+j
    else
      j=ir+1
    endif
  end do
  indx(i)=indxt
end do
END SUBROUTINE indexx
