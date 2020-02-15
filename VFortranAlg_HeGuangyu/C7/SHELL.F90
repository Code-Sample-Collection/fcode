SUBROUTINE shell(n,arr)
INTEGER m,k,l,j
REAL arr
!parameter (aln2i=1./0.69314718,tiny=1.e-5)
PARAMETER (aln2i=1.4427,tiny=1.e-5)
DIMENSION arr(n)
lognb2=int(alog(float(n))*aln2i+tiny)
m=n
do nn=1,lognb2
  m=m/2
  k=n-m
  do j=1,k
    i=j
    do
      l=i+m
      if (arr(l)<arr(i)) then
        t=arr(i)
        arr(i)=arr(l)
        arr(l)=t
        i=i-m
        if (.not.i>=1) exit
      endif
	  exit
	end do
  end do
end do
END SUBROUTINE shell
