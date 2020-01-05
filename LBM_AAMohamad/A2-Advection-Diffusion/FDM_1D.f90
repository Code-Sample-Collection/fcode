! A.2.2 P129 The FDM Code (1-D)
! Finite Difference code for 1-D advection-diffusion problem.
program FDM_1D ! main program
parameter (n=200)
real dens,fo(0:n),f(0:n)
integer i
open(2,file='fdm_1D-finitrs.result')
!
dx=0.500
dt=0.2500
! Note that the value of dt should be less than or equal to 
! 1. / [ (2alpha)/(dx*dx) + u/dx ]
! to satisfy stability criterion.
u=0.10
alpha=0.25
mstep=1600
do i=0,n
    fo(i)=0.0
end do
fo(0)=1.0
f(0)=1.0
fo(n)=0.0
f(n)=0.0

! main loop
do kk=1,mstep
    do i=1,n-1
        adv=dt*u*(fo(i)-fo(i-1))/dx
        f(i)=fo(i)+dt*alpha*(fo(i+1)-2.*fo(i)+fo(i-1))/(dx*dx)-adv
    end do 
    !
    do i=1,n-1
        fo(i)=f(i)
    end do
end do ! end of the main loop

! Output
x=0.0
do i=0,n
    write(2,*)x,f(i)
    x=x+dx
end do

stop
end program FDM_1D
! end of the main program