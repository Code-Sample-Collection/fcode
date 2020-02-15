SUBROUTINE eclazz(nf,n,equiv)
INTEGER n,nf(n)
LOGICAL equiv
EXTERNAL equiv
INTEGER jj,kk
nf(1)=1
do jj=2,n
  nf(jj)=jj
  do kk=1,jj-1
    nf(kk)=nf(nf(kk))
    if (equiv(jj,kk)) nf(nf(nf(kk)))=jj
  end do
end do
do jj=1,n
  nf(jj)=nf(nf(jj))
end do
END SUBROUTINE eclazz
