SUBROUTINE ftest(data1,n1,data2,n2,f,prob)
DIMENSION data1(n1),data2(n2)
!USES avevar,betai
REAL ave1,avf2,var1,var2,prob,f,df1,df2
INTEGER n1,n2
call avevar(data1,n1,ave1,var1)
call avevar(data2,n2,ave2,var2)
if(var1>var2)then
  f=var1/var2
  df1=n1-1
  df2=n2-1
else
  f=var2/var1
  df1=n2-1
  df2=n1-1
endif
prob=betai(0.5*df2,0.5*df1,df2/(df2+df1*f))&
  +(1.-betai(0.5*df1,0.5*df2,df1/(df1+df2/f)))
END SUBROUTINE ftest
