SUBROUTINE correl(data1,data2,n,ans)
PARAMETER (NMAX=8192)
INTEGER n,i
REAL data1(n),data2(n)
COMPLEX fft(NMAX),ans(n)
!USES realft,twofft
call twofft(data1,data2,fft,ans,n)
no2=float(n)/2.0
do i=1,no2+1
  ans(i)=fft(i)*conjg(ans(i))/float(no2)
end do
ans(1)=cmplx(real(ans(1)),real(ans(no2+1)))
call realft(ans,n/2,-1)
END SUBROUTINE correl
