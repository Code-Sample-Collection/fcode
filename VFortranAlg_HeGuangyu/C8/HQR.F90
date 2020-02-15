SUBROUTINE hqr(a,n,wr,wi)
INTEGER n
REAL a(n,n),wi(n),wr(n)
INTEGER i,its,j,k,l,m,nn
REAL anorm,p,q,r,s,t,u,v,w,x,y,z
LOGICAL done
anorm=0.
do i=1,n
  do j=max(i-1,1),n
    anorm=anorm+abs(a(i,j))
  end do
end do
nn=n
t=0.
do while(nn>=1)
  its=0
  do
    done=0
    do l=nn,2,-1
      s=abs(a(l-1,l-1))+abs(a(l,l))
      if(s==0.) s=anorm
      if(abs(a(l,l-1))+s==s) exit
    end do
	if(abs(a(l,l-1))+s/=s) l=1
    x=a(nn,nn)
    if(l==nn) then
      wr(nn)=x+t
      wi(nn)=0.
      nn=nn-1
    else
      y=a(nn-1,nn-1)
      w=a(nn,nn-1)*a(nn-1,nn)
      if(l==nn-1) then
        p=0.5*(y-x)
        q=p**2+w
        z=sqrt(abs(q))
        x=x+t
        if(q>=0.) then
          z=p+sign(z,p)
          wr(nn)=x+z
          wr(nn-1)=wr(nn)
          if(z/=0.)wr(nn)=x-w/z
          wi(nn)=0.
          wi(nn-1)=0.
        else
          wr(nn)=x+p
          wr(nn-1)=wr(nn)
          wi(nn)=z
          wi(nn-1)=-z
        endif
        nn=nn-2
      else
        if(its==30) pause 'too many iterations in hqr'
        if(its==10.or.its==20) then
          t=t+x
          do i=1,nn
            a(i,i)=a(i,i)-x
          end do
          s=abs(a(nn,nn-1))+abs(a(nn-1,nn-2))
          x=0.75*s
          y=x
          w=-0.4375*s**2
        endif
        its=its+1
        do m=nn-2,l,-1
          z=a(m,m)
          r=x-z
          s=y-z
          p=(r*s-w)/a(m+1,m)+a(m,m+1)
          q=a(m+1,m+1)-z-r-s
          r=a(m+2,m+1)
          s=abs(p)+abs(q)+abs(r)
          p=p/s
          q=q/s
          r=r/s
          if(m==l) exit
          u=abs(a(m,m-1))*(abs(q)+abs(r))
          v=abs(p)*(abs(a(m-1,m-1))+abs(z)+abs(a(m+1,m+1)))
          if(u+v==v) exit
        end do
        do i=m+2,nn
          a(i,i-2)=0.
          if (i/=m+2) a(i,i-3)=0.
        end do
        do k=m,nn-1
          if(k/=m) then
            p=a(k,k-1)
            q=a(k+1,k-1)
            r=0.
            if(k/=nn-1) r=a(k+2,k-1)
            x=abs(p)+abs(q)+abs(r)
            if(x/=0.) then
              p=p/x
              q=q/x
              r=r/x
            endif
          endif
          s=sign(sqrt(p**2+q**2+r**2),p)
          if(s/=0.) then
            if(k==m) then
              if(l/=m)a(k,k-1)=-a(k,k-1)
            else
              a(k,k-1)=-s*x
            endif
            p=p+s
            x=p/s
            y=q/s
            z=r/s
            q=q/p
            r=r/p
            do j=k,nn
              p=a(k,j)+q*a(k+1,j)
              if(k/=nn-1) then
                p=p+r*a(k+2,j)
                a(k+2,j)=a(k+2,j)-p*z
              endif
              a(k+1,j)=a(k+1,j)-p*y
              a(k,j)=a(k,j)-p*x
            end do
            do i=l,min(nn,k+3)
              p=x*a(i,k)+y*a(i,k+1)
              if(k/=nn-1) then
                p=p+z*a(i,k+2)
                a(i,k+2)=a(i,k+2)-p*r
              endif
              a(i,k+1)=a(i,k+1)-p*q
              a(i,k)=a(i,k)-p
            end do
          endif
        end do
        done=-1
      endif
    endif
    if (.not.done) exit
  end do
end do
END SUBROUTINE hqr
