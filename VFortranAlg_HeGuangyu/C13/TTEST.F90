SUBROUTINE ttest(data1,n1,data2,n2,t,prob)
REAL data1(n1),data2(n2)
!USES avevar,betai
REAL df,var,prob,t,ave1,ave2,var1,var2
INTEGER n1,n2
call avevar(data1,n1,ave1,var1)
call avevar(data2,n2,ave2,var2)
df=n1+n2-2
var=((n1-1)*var1+(n2-1)*var2)/df
t=(ave1-ave2)/sqrt(var*(1./n1+1./n2))
prob=betai(0.5*df,0.5,df/(df+t**2))
END SUBROUTINE ttest
