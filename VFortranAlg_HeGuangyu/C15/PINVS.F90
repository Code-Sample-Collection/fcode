SUBROUTINE pinvs(ie1,ie2,je1,jsf,jc1,k,c,nci,ncj,nck,&
           s,nsi,nsj)
PARAMETER (zero=0.,one=1.,nmax=10)
DIMENSION c(nci,ncj,nck),s(nsi,nsj),pscl(nmax),&
           indxr(nmax)
INTEGER ie1,ie2,je1,jsf,jc1,k,nci,ncj,nck,nsi,nsj
INTEGER je2,js1,i,id,jp,ipiv,jpiv
REAL big,piv,pivinv,c
je2=je1+ie2-ie1
js1=je2+1
do i=ie1,ie2
  big=zero
  do j=je1,je2
    if(abs(s(i,j))>big) big=abs(s(i,j))
  end do
  if(big==zero)pause 'singular matrix, row all 0'
  pscl(i)=one/big
  indxr(i)=0
end do
do id=ie1,ie2
  piv=zero
  do i=ie1,ie2
    if(indxr(i)==0) then
      big=zero
      do j=je1,je2
        if(abs(s(i,j))>big) then
          jp=j
          big=abs(s(i,j))
        endif
      end do
      if(big*pscl(i)>piv) then
        ipiv=i
        jpiv=jp
        piv=big*pscl(i)
      endif
    endif
  end do
  if(s(ipiv,jpiv)==zero) pause 'singular matrix'
  indxr(ipiv)=jpiv
  pivinv=one/s(ipiv,jpiv)
  do j=je1,jsf
    s(ipiv,j)=s(ipiv,j)*pivinv
  end do
  s(ipiv,jpiv)=one
  do i=ie1,ie2
    if(indxr(i)/=jpiv) then
      if(s(i,jpiv)/=zero) then
        dum=s(i,jpiv)
        do j=je1,jsf
          s(i,j)=s(i,j)-dum*s(ipiv,j)
        end do
        s(i,jpiv)=zero
      endif
    endif
  end do
end do
jcoff=jc1-js1
icoff=ie1-je1
do i=ie1,ie2
  irow=indxr(i)+icoff
  do j=js1,jsf
    c(irow,j+jcoff,k)=s(i,j)
  end do
end do
END SUBROUTINE pinvs
