SUBROUTINE svdvar(v,ma,np,w,cvm,ncvm)
INTEGER ma,ncvm,np,MMAX
REAL cvm(ncvm,ncvm),v(np,np),w(np)
PARAMETER (MMAX=20)
INTEGER i,j,k
REAL sum,wti(MMAX)
do i=1,ma
  wti(i)=0.
  if(w(i)/=0.) wti(i)=1./(w(i)*w(i))
end do
do i=1,ma
  do j=1,i
    sum=0.
    do k=1,ma
      sum=sum+v(i,k)*v(j,k)*wti(k)
    end do
    cvm(i,j)=sum
    cvm(j,i)=sum
  end do
end do
END SUBROUTINE svdvar
