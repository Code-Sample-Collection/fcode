SUBROUTINE simp2(a,m,n,mp,np,l2,nl2,ip,kp,q1)
INTEGER ip,kp,m,mp,n,nl2,np,l2(mp)
REAL q1,a(mp,np),EPS
PARAMETER (EPS=1.e-6)
INTEGER i,ii,k
REAL q,q0,qp,flag
ip=0
flag=0
do i=1,nl2
  if(a(l2(i)+1,kp+1)<-EPS) flag=1
  if(flag==1) exit
end do
if(flag==0) return
q1=-a(l2(i)+1,1)/a(l2(i)+1,kp+1)
ip=l2(i)
do i=i+1,nl2
  ii=l2(i)
  if(a(ii+1,kp+1)<-EPS) then
    q=-a(ii+1,1)/a(ii+1,kp+1)
    if(q<q1) then
      ip=ii
      q1=q
    else if (q==q1) then
      do k=1,n
        qp=-a(ip+1,k+1)/a(ip+1,kp+1)
        q0=-a(ii+1,k+1)/a(ii+1,kp+1)
        if(q0/=qp) exit
      end do
      if(q0<qp) ip=ii
    endif
  endif
end do
END SUBROUTINE simp2
