SUBROUTINE jacobi(a,n,d,v,nrot)
INTEGER n,nrot,NMAX
REAL a(n,n),d(n),v(n,n)
PARAMETER (NMAX=500)
INTEGER i,ip,iq,j
REAL c,g,h,s,sm,t,tau,theta,tresh,b(NMAX),z(NMAX)
do ip=1,n
  do iq=1,n
    v(ip,iq)=0.
  end do
  v(ip,ip)=1.
end do
do ip=1,n
  b(ip)=a(ip,ip)
  d(ip)=b(ip)
  z(ip)=0.
end do
nrot=0
do i=1,50
  sm=0.
  do ip=1,n-1
    do iq=ip+1,n
      sm=sm+abs(a(ip,iq))
    end do
  end do
  if(sm==0.) return
  if(i<4) then
    tresh=0.2*sm/n**2
  else
    tresh=0.
  endif
  do ip=1,n-1
    do iq=ip+1,n
      g=100.*abs(a(ip,iq))
      if((i>4).and.(abs(d(ip))+g==abs(d(ip)))&
	        .and.(abs(d(iq))+g==abs(d(iq)))) then
        a(ip,iq)=0.
      else if(abs(a(ip,iq))>tresh) then
        h=d(iq)-d(ip)
        if(abs(h)+g==abs(h)) then
          t=a(ip,iq)/h
        else
          theta=0.5*h/a(ip,iq)
          t=1./(abs(theta)+sqrt(1.+theta**2))
          if(theta<0.) t=-t
        endif
        c=1./sqrt(1+t**2)
        s=t*c
        tau=s/(1.+c)
        h=t*a(ip,iq)
        z(ip)=z(ip)-h
        z(iq)=z(iq)+h
        d(ip)=d(ip)-h
        d(iq)=d(iq)+h
        a(ip,iq)=0.
        do j=1,ip-1
          g=a(j,ip)
          h=a(j,iq)
          a(j,ip)=g-s*(h+g*tau)
          a(j,iq)=h+s*(g-h*tau)
        end do
        do j=ip+1,iq-1
          g=a(ip,j)
          h=a(j,iq)
          a(ip,j)=g-s*(h+g*tau)
          a(j,iq)=h+s*(g-h*tau)
        end do
        do j=iq+1,n
          g=a(ip,j)
          h=a(iq,j)
          a(ip,j)=g-s*(h+g*tau)
          a(iq,j)=h+s*(g-h*tau)
        end do
        do j=1,n
          g=v(j,ip)
          h=v(j,iq)
          v(j,ip)=g-s*(h+g*tau)
          v(j,iq)=h+s*(g-h*tau)
        end do
        nrot=nrot+1
      endif
    end do
  end do
  do ip=1,n
    b(ip)=b(ip)+z(ip)
    d(ip)=b(ip)
    z(ip)=0.
  end do
end do
pause 'too many iterations in jacobi'
END SUBROUTINE jacobi 
