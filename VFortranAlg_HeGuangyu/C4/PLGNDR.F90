FUNCTION plgndr(l,m,x)
INTEGER l,m
REAL plgndr,x
INTEGER i,ll
REAL fact,pll,pmm,pmmp1,somx2
if(m<0.or.m>l.or.abs(x)>1.) pause&
              'bad arguments in plgndr'
pmm=1.
if(m>0) then
  somx2=sqrt((1.-x)*(1.+x))
  fact=1.
  do i=1,m
    pmm=-pmm*fact*somx2
    fact=fact+2.
  end do
endif
if(l==m) then
  plgndr=pmm
else
  pmmp1=x*(2*m+1)*pmm
  if(l==m+1) then
    plgndr=pmmp1
  else
    do ll=m+2,l
      pll=(x*(2*ll-1)*pmmp1-(ll+m-1)*pmm)/(ll-m)
      pmm=pmmp1
      pmmp1=pll
    end do
    plgndr=pll
  endif
endif
END FUNCTION plgndr
