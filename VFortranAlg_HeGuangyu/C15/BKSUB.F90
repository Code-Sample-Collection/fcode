SUBROUTINE bksub(ne,nb,jf,k1,k2,c,nci,ncj,nck)
DIMENSION c(nci,ncj,nck)
REAL xx 
INTEGER k,k2,k1,j,i,kp,nb,ne
nbf=ne-nb
do k=k2,k1,-1
  kp=k+1
  do j=1,nbf
    xx=c(j,jf,kp)
    do i=1,ne
      c(i,jf,k)=c(i,jf,k)-c(i,j,k)*xx
    end do
  end do
end do
do k=k1,k2
  kp=k+1
  do i=1,nb
    c(i,1,k)=c(i+nbf,jf,k)
  end do
  do i=1,nbf
    c(i+nb,1,k)=c(i,jf,kp)
  end do
end do
END SUBROUTINE bksub
