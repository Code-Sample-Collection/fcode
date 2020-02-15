SUBROUTINE qcksrt(n,arr)
!PARAMETEr (m=7,nstack=50,fm=7875.0,fa=211.,&
!           fc=1663.,fmi=1./fm)
PARAMETER (m=7,nstack=50,fm=7875.0,fa=211.,&
           fc=1663.,fmi=1.2698e-4)
DIMENSION  arr(n),istack(nstack)
logical done
jstack=0
l=1
ir=n
fx=0.0
do
  if(ir-l<m)then
      do j=l+1,ir
          a=arr(j)
          do i=j-1,1,-1
              if (arr(i)<=a) exit
              arr(i+1)=arr(i)
          end do
		  if(arr(i)>a) i=0
		  arr(i+1)=a
      end do
      if(jstack==0) return
      ir=istack(jstack)
      l=istack(jstack-1)
      jstack=jstack-2
  else
      i=l
      j=ir
      fx=mod(fx*fa+fc,fm)
      iq=l+(ir-l+1)*(fx*fmi)
      a=arr(iq)
      arr(iq)=arr(l)
      do
        do 
		  if (j>0) then
            if(a<arr(j)) then
                j=j-1
				done=-1
			else
			    done=0
            endif
			if(.not.done) exit
          end if
        end do
        if(j<=i) then
            arr(i)=a
            exit
        endif
        arr(i)=arr(j)
        i=i+1
        do
		  if(i<=n) then 
            if(a>arr(i)) then
                i=i+1
				done=-1
			else
			    done=0
            endif
			if(.not.done) exit
          end if
        end do
        if(j<=i) then
            arr(j)=a
            i=j
            exit
        endif
        arr(j)=arr(i)
        j=j-1
      end do
      jstack=jstack+2
      if(jstack.gt.nstack)&
            pause 'nstack must be made larger.'
      if(ir-i>=i-l) then
          istack(jstack)=ir
          istack(jstack-1)=i+1
          ir=i-1
      else
          istack(jstack)=i-1
          istack(jstack-1)=l
          l=i+1
      endif
  endif
end do
END SUBROUTINE qcksrt
