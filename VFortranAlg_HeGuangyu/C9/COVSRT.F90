SUBROUTINE covsrt(covar,ncvm,ma,lista,mfit)
INTEGER ma,mfit,ncvm,lista(mfit)
REAL covar(ncvm,ncvm)
INTEGER i,j,k
REAL swap
do j=1,ma-1
  do i=j+1,ma
    covar(i,j)=0.
  end do
end do
do i=1,mfit-1
  do j=i+1,mfit
    if(lista(j)>lista(i)) then
      covar(lista(j),lista(i))=covar(i,j)
    else
      covar(lista(i),lista(j))=covar(i,j)
    endif
  end do
end do
swap=covar(1,1)
do j=1,ma
  covar(1,j)=covar(j,j)
  covar(j,j)=0.
end do
covar(lista(1),lista(1))=swap
do j=2,mfit
  covar(lista(j),lista(j))=covar(1,j)
end do
do j=2,ma
  do i=1,j-1
    covar(i,j)=covar(j,i)
  end do
end do
END SUBROUTINE covsrt
