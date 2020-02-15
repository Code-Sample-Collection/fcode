SUBROUTINE solvde(itmax,conv,slowc,scalv,indexv,ne,&
     nb,m,y,nyj,nyk,c,nci,ncj,nck,s,nsi,nsj)
PARAMETER (nmax=10)
DIMENSION y(nyj,nyk),c(nci,ncj,nck),s(nsi,nsj),&
    scalv(nyj),ermax(nmax),kmax(nmax),indexv(nyj)
REAL errj,vmax,vz,err,fac,conv
INTEGER k1,k2,nvars,j1,j2,j3,j4,j5,j6,j7,j8,j9
INTEGER ic1,ic2,m,ne,nb,it,k,jv,km,kp
k1=1
k2=m
nvars=ne*m
j1=1
j2=nb
j3=nb+1
j4=ne
j5=j4+j1
j6=j4+j2
j7=j4+j3
j8=j4+j4
j9=j8+j1
ic1=1
ic2=ne-nb
ic3=ic2+1
ic4=ne
jc1=1
jcf=ic3
do it=1,itmax
  k=k1
  call difeq(k,k1,k2,j9,ic3,ic4,indexv,ne,s,nsi,&
               nsj,y,nyj,nyk)
  call pinvs(ic3,ic4,j5,j9,jc1,k1,c,nci,ncj,nck,s,&
               nsi,nsj)
  do k=k1+1,k2
    kp=k-1
    call difeq(k,k1,k2,j9,ic1,ic4,indexv,ne,s,&
                   nsi,nsj,y,nyj,nyk)
    call red(ic1,ic4,j1,j2,j3,j4,j9,ic3,jc1,jcf,&
             kp,c,nci,ncj,nck,s,nsi,nsj)
    call pinvs(ic1,ic4,j3,j9,jc1,k,c,nci,ncj,nck&
                  ,s,nsi,nsj)
  end do
  k=k2+1
  call difeq(k,k1,k2,j9,ic1,ic2,indexv,ne,s,nsi,&
               nsj,y,nyj,nyk)
  call red(ic1,ic2,j5,j6,j7,j8,j9,ic3,jc1,jcf,k2,&
             c,nci,ncj,nck,s,nsi,nsj)
  call pinvs(ic1,ic2,j7,j9,jcf,k2+1,c,nci,ncj,nck,&
               s,nsi,nsj)
  call bksub(ne,nb,jcf,k1,k2,c,nci,ncj,nck)
  err=0.
  do j=1,ne
    jv=indexv(j)
    ermax(j)=0.
    errj=0.
    kmax(j)=0
    vmax=0.
    do k=k1,k2
      vz=abs(c(j,1,k))
      if(vz>vmax) then
        vmax=vz
        km=k
      endif
      errj=errj+vz
    end do
    err=err+errj/scalv(jv)
    ermax(j)=c(j,1,km)/scalv(jv)
    kmax(j)=km
  end do
  err=err/nvars
  fac=slowc/max(slowc,err)
  do jv=1,ne
    j=indexv(jv)
    do k=k1,k2
      y(j,k)=y(j,k)-fac*c(jv,1,k)
    end do
  end do
  write(*,'(1x,i4,2f12.6,(/5x,i5,f12.6))') &
	        it,err,fac,(kmax(j),ermax(j),j=1,ne)
  if(err<conv) return
end do
pause 'itmax exceeded'
END SUBROUTINE solvde
