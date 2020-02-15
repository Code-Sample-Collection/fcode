SUBROUTINE powell(p,xi,n,np,ftol,iter,fret)
INTEGER iter,n,np,NMAX,ITMAX
REAL fret,ftol,p(np),xi(np,np),func
EXTERNAL func
PARAMETER (NMAX=20,ITMAX=200)
!USES func,linmin
INTEGER i,ibig,j
REAL del,fp,fptt,t,pt(NMAX),ptt(NMAX),xit(NMAX)
fret=func(p)
do  j=1,n
  pt(j)=p(j)
end do
iter=0
do
  do
    do
      iter=iter+1
      fp=fret
      ibig=0
      del=0.
      do i=1,n
        do j=1,n
          xit(j)=xi(j,i)
        end do
        fptt=fret
        call linmin(p,xit,n,fret)
        if(abs(fptt-fret)>del) then
          del=abs(fptt-fret)
          ibig=i
        endif
      end do
      if(2.*abs(fp-fret)<=ftol*(abs(fp)+abs(fret))) return
      if(iter==ITMAX) then
	    pause 'powell exceeding maximum iterations'
		return
	  end if
      do j=1,n
        ptt(j)=2.*p(j)-pt(j)
        xit(j)=p(j)-pt(j)
        pt(j)=p(j)
      end do
      fptt=func(ptt)
      if(fptt>=fp) exit
    end do
    t=2.*(fp-2.*fret+fptt)*(fp-fret-del)**2-del*(fp-fptt)**2
    if(t>=0.) exit
  end do
  call linmin(p,xit,n,fret)
  do j=1,n
    xi(j,ibig)=xi(j,n)
    xi(j,n)=xit(j)
  end do
end do
END SUBROUTINE powell
