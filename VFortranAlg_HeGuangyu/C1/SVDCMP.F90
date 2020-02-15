SUBROUTINE svdcmp(a,m,n,w,v)
PARAMETER(nmax=100)
REAL a(m,n),w(n),v(n,n),rv1(nmax)
INTEGER i,l,k,nm
REAL g,s,scale,f,h,c,x,y,z 
if(m<n) pause 'you must augment a with extra zero rows.'
g=0.0
scale=0.0
anorm=0.0
do i=1,n
  l=i+1
  rv1(i)=scale*g
  g=0.0
  s=0.0
  scale=0.0
  if(i<=m) then
    do k=i,m
      scale=scale+abs(a(k,i))
    end do
    if(scale/=0.0) then
      do k=i,m
        a(k,i)=a(k,i)/scale
        s=s+a(k,i)*a(k,i)
      end do
      f=a(i,i)
      g=-sign(sqrt(s),f)
      h=f*g-s
      a(i,i)=f-g
      if (i/=n) then
        do j=l,n
          s=0.0
          do k=i,m
            s=s+a(k,i)*a(k,j)
          end do
          f=s/h
          do k=i,m
            a(k,j)=a(k,j)+f*a(k,i)
          end do
        end do
      endif
      do k=i,m
        a(k,i)=scale*a(k,i)
      end do
    endif
  endif
  w(i)=scale*g
  g=0.0
  s=0.0
  scale=0.0
  if ((i<=m).and.(i/=n)) then
    do k=l,n
      scale=scale+abs(a(i,k))
    end do
    if (scale/=0.0) then
      do k=l,n
        a(i,k)=a(i,k)/scale
        s=s+a(i,k)*a(i,k)
      end do
      f=a(i,l)
      g=-sign(sqrt(s),f)
      h=f*g-s
      a(i,l)=f-g
      do k=l,n
        rv1(k)=a(i,k)/h
      end do
      if (i/=m) then
        do j=l,m
          s=0.0
          do k=l,n
            s=s+a(j,k)*a(i,k)
          end do
          do k=l,n
            a(j,k)=a(j,k)+s*rv1(k)
          end do
        end do
      endif
      do k=l,n
        a(i,k)=scale*a(i,k)
      end do
    endif
  endif
  anorm=max(anorm,(abs(w(i))+abs(rv1(i))))
end do
do i=n,1,-1
  if (i<n) then
    if (g/=0.0) then
      do j=l,n
        v(j,i)=(a(i,j)/a(i,l))/g
      end do
      do j=l,n
        s=0.0
        do k=l,n
           s=s+a(i,k)*v(k,j)
        end do
        do k=l,n
          v(k,j)=v(k,j)+s*v(k,i)
        end do
      end do
    endif
    do j=l,n
      v(i,j)=0.0
      v(j,i)=0.0
    end do
  endif
  v(i,i)=1.0
  g=rv1(i)
  l=i
end do
do i=n,1,-1
  l=i+1
  g=w(i)
  if (i<n) then
    do j=l,n
      a(i,j)=0.0
    end do
  endif
  if (g/=0.0) then
    g=1.0/g
    if (i/=n) then
    do j=l,n
      s=0.0
      do k=l,m
        s=s+a(k,i)*a(k,j)
      end do
      f=(s/a(i,i))*g
      do k=i,m
        a(k,j)=a(k,j)+f*a(k,i)
      end do
    end do
    endif
    do j=i,m
      a(j,i)=a(j,i)*g
    end do
  else
    do j=i,m
      a(j,i)=0.0
    end do
  endif
  a(i,i)=a(i,i)+1.0
end do
do k=n,1,-1
  do its=1,30
    do l=k,1,-1
      nm=l-1
      if((abs(rv1(l))+anorm)==anorm) exit
      if((abs(w(nm))+anorm)==anorm) exit
    end do
	if (abs(rv1(l))+anorm/=anorm) then
      c=0.0
      s=1.0
      do i=l,k
        f=s*rv1(i)
        if((abs(f)+anorm)/=anorm) then
          g=w(i)
          h=sqrt(f*f+g*g)
          w(i)=h
          h=1.0/h
          c=(g*h)
          s=-(f*h)
          do j=1,m
            y=a(j,nm)
            z=a(j,i)
            a(j,nm)=(y*c)+(z*s)
            a(j,i)=-(y*s)+(z*c)
          end do
        endif
      end do
	end if
    z=w(k)
    if(l==k) then
      if(z<0.0) then
        w(k)=-z
        do j=1,n
          v(j,k)=-v(j,k)
        end do
      endif
      exit 
    endif
    if(its==30) pause 'no convergence in 30 iterations'
    x=w(l)
    nm=k-1
    y=w(nm)
    g=rv1(nm)
    h=rv1(k)
    f=((y-z)*(y+z)+(g-h)*(g+h))/(2.0*h*y)
    g=sqrt(f*f+1.0)
    f=((x-z)*(x+z)+h*((y/(f+sign(g,f)))-h))/x
    c=1.0
    s=1.0
    do j=l,nm
      i=j+1
      g=rv1(i)
      y=w(i)
      h=s*g
      g=g*c
      z=sqrt(f*f+h*h)
      rv1(j)=z
      c=f/z
      s=h/z
      f=(x*c)+(g*s)
      g=-(x*s)+(g*c)
      h=y*s
      y=y*c
      do nm=1,n
        x=v(nm,j)
        z=v(nm,i)
        v(nm,j)=(x*c)+(z*s)
        v(nm,i)=-(x*s)+(z*c)
      end do
      z=sqrt(f*f+h*h)
      w(j)=z
      if(z/=0.0) then
        z=1.0/z
        c=f*z
        s=h*z
      endif
      f=(c*g)+(s*y)
      x=-(s*g)+(c*y)
      do nm=1,m
        y=a(nm,j)
        z=a(nm,i)
        a(nm,j)=(y*c)+(z*s)
        a(nm,i)=-(y*s)+(z*c)
      end do
    end do
    rv1(l)=0.0
    rv1(k)=f
    w(k)=x
  end do
end do
END SUBROUTINE svdcmp

