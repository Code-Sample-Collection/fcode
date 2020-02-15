SUBROUTINE eulsum(sum,term,jterm,wksp)
INTEGER jterm
REAL sum,term,wksp(jterm)
INTEGER j,nterm
REAL dum,tmp
SAVE nterm
if(jterm==1)then
  nterm=1
  wksp(1)=term
  sum=0.5*term
else
  tmp=wksp(1)
  wksp(1)=term
  do j=1,nterm-1
    dum=wksp(j+1)
    wksp(j+1)=0.5*(wksp(j)+tmp)
    tmp=dum
  end do
  wksp(nterm+1)=0.5*(wksp(nterm)+tmp)
  if(abs(wksp(nterm+1))<=abs(wksp(nterm))) then
    sum=sum+0.5*wksp(nterm+1)
    nterm=nterm+1
  else
    sum=sum+wksp(nterm+1)
  endif
endif
END SUBROUTINE eulsum
