SUBROUTINE rank(n,indx,irank)
INTEGER n,indx(n),irank(n),j
do j=1,n
  irank(indx(j))=j
end do
END SUBROUTINE rank
