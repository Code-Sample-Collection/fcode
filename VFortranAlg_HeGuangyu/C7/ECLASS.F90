SUBROUTINE eclass(nf,n,lista,listb,m)
INTEGER m,n,lista(m),listb(m),nf(n)
INTEGER j,k,l
do k=1,n
  nf(k)=k
end do
do l=1,m
  j=lista(l)
  do while (nf(j)/=j)
    j=nf(j)
  end do
  k=listb(l)
  do while(nf(k)/=k)
    k=nf(k)
  end do
  if(j/=k)nf(j)=k
end do
do j=1,n
  do while(nf(j)/=nf(nf(j))) 
    nf(j)=nf(nf(j))
  end do
end do
END SUBROUTINE eclass
