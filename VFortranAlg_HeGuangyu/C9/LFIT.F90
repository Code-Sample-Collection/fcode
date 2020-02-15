SUBROUTINE lfit(x,y,sig,ndata,a,ma,lista,mfit,covar,&
                ncvm,chisq,funcs)
PARAMETER (mmax=50)
!USES gaussj,covsrt
REAL x(ndata),y(ndata),sig(ndata),a(ma),beta(mfit),&
     covar(mfit,mfit),afunc(mmax)
INTEGER lista(ma),j,k,i,kk,ihit
REAL sum,ym,wt,sig2i
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
        pause 'improper set in lista'
    endif
end do
if(kk/=(ma+1)) pause 'improper set in lista'
do j=1,mfit
  do k=1,mfit
    covar(j,k)=0.
  end do
  beta(j)=0.
end do
do i=1,ndata
  call funcs(x(i),afunc,ma)
  ym=y(i)
  if(mfit<ma) then
    do j=mfit+1,ma
      ym=ym-a(lista(j))*afunc(lista(j))
    end do
  endif
  sig2i=1./sig(i)**2
  do j=1,mfit
    wt=afunc(lista(j))*sig2i
    do k=1,j
      covar(j,k)=covar(j,k)+wt*afunc(lista(k))
    end do
    beta(j)=beta(j)+ym*wt
   end do
end do
if(mfit>1) then
  do j=2,mfit
    do k=1,j-1
      covar(k,j)=covar(j,k)
    end do
  end do
endif
call gaussj(covar,mfit,beta)
do j=1,mfit
  a(lista(j))=beta(j)
end do
chisq=0.
do i=1,ndata
  call funcs(x(i),afunc,ma)
  sum=0.
  do j=1,ma
    sum=sum+a(j)*afunc(j)
  end do
  chisq=chisq+((y(i)-sum)/sig(i))**2
end do
call covsrt(covar,ncvm,ma,lista,mfit)
END SUBROUTINE lfit

