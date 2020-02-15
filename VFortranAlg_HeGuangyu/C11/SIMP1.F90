SUBROUTINE simp1(a,mp,np,mm,ll,nll,iabf,kp,bmax)
INTEGER iabf,kp,mm,mp,nll,np,ll(np)
REAL bmax,a(mp,np)
INTEGER k
REAL test
kp=ll(1)
bmax=a(mm+1,kp+1)
do k=2,nll
  if(iabf==0)then
    test=a(mm+1,ll(k)+1)-bmax
  else
    test=abs(a(mm+1,ll(k)+1))-abs(bmax)
  endif
  if(test>0.)then
    bmax=a(mm+1,ll(k)+1)
    kp=ll(k)
  endif
end do
END SUBROUTINE simp1
