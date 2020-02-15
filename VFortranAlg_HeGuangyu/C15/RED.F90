SUBROUTINE red(iz1,iz2,jz1,jz2,jm1,jm2,jmf,ic1,jc1,&
     jcf,kc,c,nci,ncj,nck,s,nsi,nsj)
DIMENSION c(nci,ncj,nck),s(nsi,nsj)
REAL vx
INTEGER iz1,iz2,jz1,jz2,jm2,jmf,ic1,jc1,jcf,kc,nci
INTEGER ncj,nck,nsi,nsj,loff,ic,l,i
loff=jc1-jm1
ic=ic1
do j=jz1,jz2
  do l=jm1,jm2
    vx=c(ic,l+loff,kc)
    do i=iz1,iz2
      s(i,l)=s(i,l)-s(i,j)*vx
    end do
  end do
  vx=c(ic,jcf,kc)
  do i=iz1,iz2
    s(i,jmf)=s(i,jmf)-s(i,j)*vx
  end do
  ic=ic+1
end do
END SUBROUTINE red
