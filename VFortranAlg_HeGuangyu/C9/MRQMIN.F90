SUBROUTINE mrqmin(X,Y,SIG,NDATA,A,MA,LISTA,MFIT,&
           COVAR,ALPHA,NCA,CHISQ,FUNCS,ALAMDA)
INTEGER ma,nca,ndata,lista(ma),MMAX
REAL alamda,chisq,funcs,a(ma),alpha(nca,nca),&
     covar(nca,nca),sig(ndata),x(ndata),y(ndata)
PARAMETER (MMAX=20)
!USES covsrt,gaussj,mrqcof
INTEGER j,k,l,mfit
REAL ochisq,atry(MMAX),beta(MMAX),da(MMAX)
if(alamda<0.) then
  kk=mfit+1
  do j=1,ma
    ihit=0
    do k=1,mfit
      if(lista(k)==j) ihit=ihit+1
    end do
    if(ihit==0) then
      lista(kk)=j
      kk=kk+1
    else if(ihit>1) then
      pause 'improper permutation in lista'
    endif
  end do
  if(kk/=(ma+1)) pause 'improper permutation in lista'
  alamda=0.001
  call mrqcof(x,y,sig,ndata,a,ma,lista,mfit,alpha,&
                     beta,nca,chisq,funcs)
  ochisq=chisq
  do j=1,ma
    atry(j)=a(j)
  end do
endif
do j=1,mfit
  do k=1,mfit
    covar(j,k)=alpha(j,k)
  end do
  covar(j,j)=alpha(j,j)*(1.+alamda)
  da(j)=beta(j)
end do
call gaussj(covar,mfit,da)
if(alamda==0.) then
  call covsrt(covar,nca,ma,lista,mfit)
  return
endif
do j=1,mfit
  atry(lista(j))=a(lista(j))+da(j)
end do
call mrqcof(x,y,sig,ndata,atry,ma,lista,mfit,covar,da,&
                nca,chisq,funcs)
if(chisq<ochisq) then
  alamda=0.1*alamda
  ochisq=chisq
  do j=1,mfit
    do k=1,mfit
      alpha(j,k)=covar(j,k)
    end do
    beta(j)=da(j)
    a(lista(j))=atry(lista(j))
  end do
else
  alamda=10.*alamda
  chisq=ochisq
endif
END SUBROUTINE mrqmin
