! A.1.5 P123 The LBM Code (D2Q9)
! LBM code for 2-D, diffusion problems, D2Q9
program LBM_D2Q9 ! main program
parameter (n=100,m=100)
real f(0:8,0:n,0:m),feq
real rho(0:n,0:m),x(0:n),y(0:m)
real w(0:8)
integer i
open(2,file='lbm_D2Q9-Qresu.result')
open(3,file='lbm_D2Q9-midtlbmtc.result')
!
dx=1.0
dy=dy
x(0)=0.0
y(0)=0.0
do i=1,n
    x(i)=x(i-1)+dx
end do
do j=1,m
    y(j)=y(j-1)+dy
end do
dt=1.0
tw=1.0
alpha=0.25
csq=(dx*dx)/(dt*dt)
omega=1.0/(3.*alpha/(csq*dt)+0.5)
mstep=400
w(0)=4./9.
do i=1,4
    w(i)=1./9.
end do
do i=5,8
    w(i)=1./36.
end do
do j=0,m
    do i=0,n
        rho(i,j)=0.0 ! initial field
    end do
end do
do j=0,m
    do i=0,n
        do k=0,8
            f(k,i,j)=w(k)*rho(i,j)
            if(i.eq.0) f(k,i,j)=w(k)*tw
        end do
    end do
end do

! main loop
do kk=1,mstep
    do j=0,m
        do i=0,n
            sum=0.0
            do k=0,8
                sum=sum+f(k,i,j)
            end do
            rho(i,j)=sum
        end do
    end do
    print *,rho(0,m/2)
    do j=0,m
        do i=0,n
            do k=0,8
                feq=w(k)*rho(i,j)
                f(k,i,j)=omega*feq+(1.-omega)*f(k,i,j)
            end do
        end do
    end do

    ! streaming
    do j=m,0,-1
        do i=0,n
            f(2,i,j)=f(2,i,j-1)
            f(6,i,j)=f(6,i+1,j-1)
        end do
    end do
    do j=m,0,-1
        do i=n,0,-1
            f(1,i,j)=f(1,i-1,j)
            f(5,i,j)=f(5,i-1,j-1)
        end do
    end do
    do j=0,m
        do i=n,0,-1
            f(4,i,j)=f(4,i,j+1)
            f(8,i,j)=f(8,i-1,j+1)
        end do
    end do
    do j=0,m
        do i=0,n
            f(3,i,j)=f(3,i+1,j)
            f(7,i,j)=f(7,i+1,j+1)
        end do
    end do

    ! Boundary conditions
    do j=0,m
        f(1,0,j)=w(1)*tw+w(3)*tw-f(3,0,j)
        f(5,0,j)=w(5)*tw+w(7)*tw-f(7,0,j)
        f(8,0,j)=w(8)*tw+w(6)*tw-f(6,0,j)
        f(3,n,j)=-f(1,n,j)
        f(6,n,j)=-f(8,n,j)
        f(7,n,j)=-f(5,n,j)
    end do
    do i=0,n
        f(4,i,m)=-f(2,i,m)
        f(7,i,m)=-f(5,i,m)
        f(8,i,m)=-f(6,i,m)
        f(1,i,0)=f(1,i,1)
        f(2,i,0)=f(2,i,1)
        f(3,i,0)=f(3,i,1)
        f(4,i,0)=f(4,i,1)
        f(5,i,0)=f(5,i,1)
        f(6,i,0)=f(6,i,1)
        f(7,i,0)=f(7,i,1)
        f(8,i,0)=f(8,i,1)
    end do
end do ! end of the main loop

do j=0,m
    do i=0,n
        sum=0.0
        do k=0,8
            sum=sum+f(k,i,j)
        end do
        rho(i,j)=sum
    end do
end do

! Output
print *, rho(0,m/2)
write(2,*)"VARIABLES =X, Y, T"
write(2,*)"ZONE ","I=",n+1,"J=",m+1,",","F=BLOCK"
do j=0,m
    write(2,*)(x(i),i=0,n)
end do
do j=0,m
    write(2,*)(y(j),i=0,n)
end do
do j=0,m
    write(2,*)(rho(i,j),i=0,n)
end do
do i=0,n
    write(3,*)x(i),rho(i,m/2)
end do

stop
end program LBM_D2Q9
! end of the main program