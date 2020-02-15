SUBROUTINE simp3(a,mp,np,i1,k1,ip,kp)
INTEGER i1,ip,k1,kp,mp,np
REAL a(mp,np)
INTEGER ii,kk
REAL piv
piv=1./a(ip+1,kp+1)
do ii=1,i1+1
  if(ii-1/=ip) then
    a(ii,kp+1)=a(ii,kp+1)*piv
    do kk=1,k1+1
      if(kk-1/=kp) then
        a(ii,kk)=a(ii,kk)-a(ip+1,kk)*a(ii,kp+1)
      endif
    end do
  endif
end do
do kk=1,k1+1
  if(kk-1/=kp) a(ip+1,kk)=-a(ip+1,kk)*piv
end do
a(ip+1,kp+1)=piv
END SUBROUTINE simp3
