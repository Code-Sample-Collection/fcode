SUBROUTINE tptest(data1,data2,n,t,prob)
DIMENSION data1(n),data2(n)
!USES avevar,betai
REAL cov,ave1,ave2,var1,var2,df,sd,t,prob
INTEGER j,n
call avevar(data1,n,ave1,var1)
call avevar(data2,n,ave2,var2)
cov=0.
do j=1,n
  cov=cov+(data1(j)-ave1)*(data2(j)-ave2)
end do
df=n-1
cov=cov/df
sd=sqrt((var1+var2-2.*cov)/n)
t=(ave1-ave2)/sd
prob=betai(0.5*df,0.5,df/(df+t**2))
END SUBROUTINE tptest
