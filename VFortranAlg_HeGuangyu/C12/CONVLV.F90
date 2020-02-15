SUBROUTINE convlv(data1,n,respns,m,isign,ans)
PARAMETER(nmax=8192)
DIMENSION data1(n),respns(n)
COMPLEX fft(nmax),ans(n)
INTEGER i,m,isign,no2
do i=1,(m-1)/2
  respns(n+1-i)=respns(m+1-i)
end do
do i=(m+3)/2,n-(m-1)/2
  respns(i)=0.0
end do
call twofft(data1,respns,fft,ans,n)
no2=n/2
do i=1,no2+1
  if (isign==1)  then
    ans(i)=fft(i)*ans(i)/no2
  else  if(isign==-1)  then
    if (cabs(ans(i))==0.0)&
         pause 'deconvolving at a response zero'
    ans(i)=fft(i)/ans(i)/no2
  else
    pause 'no meaning for isign'
  endif
end do
ans(1)=cmplx(real(ans(1)),real(ans(no2+1)))
call  realft(ans,no2,-1)
END SUBROUTINE CONVLV

