SUBROUTINE poldiv(u,n,v,nv,q,r)
INTEGER n,nv
REAL q(n),r(n),u(n),v(nv)
INTEGER j,k
do j=1,n
  r(j)=u(j)
  q(j)=0.
end do
do k=n-nv,0,-1
  q(k+1)=r(nv+k)/v(nv)
  do j=nv+k-1,k+1,-1
    r(j)=r(j)-q(k+1)*v(j-k)
  end do
end do
do j=nv,n
  r(j)=0.
end do
END SUBROUTINE poldiv
