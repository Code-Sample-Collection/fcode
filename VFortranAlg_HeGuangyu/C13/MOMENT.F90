SUBROUTINE moment(data1,n,ave,adev,sdev,var,skew,kurt)
REAL data1(n)
INTEGER j,n
REAL ave,adev,var,skew,kurt,s,p
if(n<=1) pause 'n must be at least 2'
s=0.
do j=1,n
  s=s+data1(j)
end do
ave=s/n
adev=0.
var=0.
skew=0.
kurt=0.
do j=1,n
  s=data1(j)-ave
  adev=adev+abs(s)
  p=s*s
  var=var+p
  p=p*s
  skew=skew+p
  p=p*s
  kurt=kurt+p
end do
adev=adev/n
var=var/(n-1)
sdev=sqrt(var)
if(var/=0.)then
  skew=skew/(n*sdev**3)
  kurt=kurt/(n*var**2)-3.
else
  pause 'no skew or kurtosis when zero variance'
endif
END SUBROUTINE moment
