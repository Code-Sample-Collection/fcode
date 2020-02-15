SUBROUTINE simplx(a,m,n,mp,np,m1,m2,m3,icase,izrov,&
                  iposv)
INTEGER icase,m,m1,m2,m3,mp,n,np,iposv(m),izrov(n),&
        MMAX,NMAX
REAL a(mp,np),EPS
PARAMETER (MMAX=100,NMAX=100,EPS=1.e-6)
!USES simp1,simp2,simp3
INTEGER i,ip,ir,is,k,kh,kp,m12,nl1,nl2,l1(NMAX),&
        l2(MMAX),l3(MMAX)
REAL bmax,q1
if(m/=m1+m2+m3)&
     pause 'bad input constraint counts in simplx'
nl1=n
do k=1,n
  l1(k)=k
  izrov(k)=k
end do
nl2=m
do i=1,m
  if(a(i+1,1)<0.) pause 'bad input tableau in simplx'
  l2(i)=i
  iposv(i)=n+i
end do
do i=1,m2
  l3(i)=1
end do
ir=0
if(m2+m3==0) goto 3
ir=1
do k=1,n+1
  q1=0.
  do i=m1+1,m
    q1=q1+a(i+1,k)
  end do
  a(m+2,k)=-q1
end do
do
  call simp1(a,mp,np,m+1,l1,nl1,0,kp,bmax)
  if(bmax<=EPS.and.a(m+2,1)<-EPS) then
    icase=-1
    return
  else if(bmax<=EPS.and.a(m+2,1)<=EPS) then
    m12=m1+m2+1
    do ip=m12,m
      if(iposv(ip)==ip+n) then
        call simp1(a,mp,np,ip,l1,nl1,1,kp,bmax)
        if(bmax>0.) goto 1
      endif
    end do
    ir=0
    m12=m12-1
    do i=m1+1,m12
      if(l3(i-m1)==1) then
        do k=1,n+1
          a(i+1,k)=-a(i+1,k)
        end do
      endif
    end do
    exit 
  endif
  call simp2(a,m,n,mp,np,l2,nl2,ip,kp,q1)
  if(ip==0) then
    icase=-1
    return
  endif
1 call simp3(a,mp,np,m+1,n,ip,kp)
  if(iposv(ip)>=n+m1+m2+1) then
    do k=1,nl1
      if(l1(k)==kp) exit
    end do
    nl1=nl1-1
    do is=k,nl1
      l1(is)=l1(is+1)
    end do
  else
    if(iposv(ip)<n+m1+1) goto 2
    kh=iposv(ip)-m1-n
    if(l3(kh)==0) goto 2
    l3(kh)=0
  endif
  a(m+2,kp+1)=a(m+2,kp+1)+1.
  do i=1,m+2
    a(i,kp+1)=-a(i,kp+1)
  end do
2 is=izrov(kp)
  izrov(kp)=iposv(ip)
  iposv(ip)=is
  if(ir/=0) exit
end do
3 call simp1(a,mp,np,0,l1,nl1,0,kp,bmax)
  if(bmax<=0.) then
    icase=0
    return
  endif
  call simp2(a,m,n,mp,np,l2,nl2,ip,kp,q1)
  if(ip==0) then
    icase=1
    return
  endif
  call simp3(a,mp,np,m,n,ip,kp)
  goto 2
END SUBROUTINE simplx
