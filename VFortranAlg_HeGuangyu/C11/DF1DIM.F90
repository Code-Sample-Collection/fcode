FUNCTION df1dim(x)
PARAMETER (nmax=50)
REAL xicom(nmax),pcom(nmax)
COMMON /f1com/ pcom,xicom,ncom
REAL xt(nmax),df(nmax)
INTEGER j
do j=1,ncom
  xt(j)=pcom(j)+x*xicom(j)
end do
call dfunc(xt,df)
df1dim=0.
do j=1,ncom
  df1dim=df1dim+df(j)*xicom(j)
end do
END FUNCTION df1dim
