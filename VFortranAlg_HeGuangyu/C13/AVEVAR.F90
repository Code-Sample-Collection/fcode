SUBROUTINE avevar(data,n,ave,var)
DIMENSION data(n)
REAL ave,var,s
INTEGER j,n
ave=0.0
var=0.0
do j=1,n
  ave=ave+data(j)
end do
ave=ave/n
do j=1,n
  s=data(j)-ave
  var=var+s*s
end do
var=var/(n-1)
END SUBROUTINE avevar
