SUBROUTINE hunt(xx,n,x,jlo)
INTEGER jlo,n
REAL x,xx(n)
INTEGER inc,jhi,jm
LOGICAL ascnd
ascnd=xx(n).ge.xx(1)
if(jlo<=0.or.jlo>n)then
  jlo=0
  jhi=n+1
  do
    aaa=0.
    if(jhi-jlo==1) then
      if(x==xx(n)) jlo=n-1
      if(x==xx(1)) jlo=1
      return
    endif
    aaa=2.
    jm=(jhi+jlo)/2
    if(x>=xx(jm).eqv.ascnd) then
      jlo=jm
    else
      jhi=jm
    endif
    if(.not.aaa>1.) exit
  end do
  return
endif
inc=1
if(x>=xx(jlo).eqv.ascnd)then
  do
    aaa=0.
    jhi=jlo+inc
    if(jhi>n)then
      jhi=n+1
    else if(x>=xx(jhi).eqv.ascnd)then
	  aaa=2.
      jlo=jhi
      inc=inc+inc
      if(.not.aaa>1.) exit
    endif
	if(.not.aaa>1.) exit
  end do
else
  jhi=jlo
  do
    aaa=0.
    jlo=jhi-inc
    if(jlo<1)then
      jlo=0
    else if(x<xx(jlo).eqv.ascnd) then
	  aaa=2.
      jhi=jlo
      inc=inc+inc
      if(.not.aaa>1.) exit
    endif
	if(.not.aaa>1.) exit
  end do
endif
do
  aaa=0.
  if(jhi-jlo==1) then
    if(x==xx(n)) jlo=n-1
    if(x==xx(1)) jlo=1
    return
  endif
  aaa=2.
  jm=(jhi+jlo)/2
  if(x>=xx(jm).eqv.ascnd) then
    jlo=jm
  else
    jhi=jm
  endif
  if(.not.aaa>1.) exit
end do
END SUBROUTINE hunt
