SUBROUTINE tutest(data1,n1,data2,n2,t,prob)
DIMENSION data1(n1),data2(n2)
!USES avevar
REAL t,ave1,ave2,var1,var2,prob,df
INTEGER n1,n2
call avevar(data1,n1,ave1,var1)
call avevar(data2,n2,ave2,var2)
t=(ave1-ave2)/sqrt(var1/n1+var2/n2)
df=(var1/n1+var2/n2)**2/((var1/n1)**2/(n1-1)+&
   (var2/n2)**2/(n2-1))
prob=betai(0.5*df,0.5,df/(df+t**2))
END SUBROUTINE tutest
