SUBROUTINE mrqcof(x,y,sig,ndata,a,ma,lista,mfit,&
             alpha,beta,nalp,chisq,funcs)
PARAMETER (mmax=20)
DIMENSION x(ndata),y(ndata),alpha(nalp,nalp),&
   beta(ma),dyda(mmax),lista(mfit),sig(ndata),a(ma)
do j=1,mfit
  do k=1,j
    alpha(j,k)=0.
  end do
  beta(j)=0.
end do
chisq=0.
do i=1,ndata
  call funcs(x(i),a,ymod,dyda,ma)
  sig2i=1./(sig(i)*sig(i))
  dy=y(i)-ymod
  do j=1,mfit
    wt=dyda(lista(j))*sig2i
    do k=1,j
      alpha(j,k)=alpha(j,k)+wt*dyda(lista(k))
    end do
    beta(j)=beta(j)+dy*wt
  end do
  chisq=chisq+dy*dy*sig2i
end do
do j=2,mfit
  do k=1,j-1
    alpha(k,j)=alpha(j,k)
  end do
end do
END SUBROUTINE mrqcof
