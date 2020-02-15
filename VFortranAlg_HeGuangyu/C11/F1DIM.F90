FUNCTION f1dim(x)
INTEGER NMAX
REAL f1dim,func,x
PARAMETER (NMAX=50)
!USES func
INTEGER j,ncom
REAL pcom(NMAX),xicom(NMAX),xt(NMAX)
COMMON /f1com/ pcom,xicom,ncom
do j=1,ncom
  xt(j)=pcom(j)+x*xicom(j)
end do
f1dim=func(xt)
END FUNCTION f1dim
