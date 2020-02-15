!
! Numerical Mathematics and Computing, Fifth Edition
! Ward Cheney & David Kincaid
! Brooks/Cole Publ. Co.
! Copyright (c) 2003.  All rights reserved.
! For educational use with the Cheney-Kincaid textbook.
! Absolutely no warranty implied or expressed.
!
! Section 15.3
!
! File: seidel.f90
!
! elliptic pde solved by discretization and gauss-seidel method
!  (seidel,f,g,bndy,ustart,true)

program elliptic
      integer, parameter :: nx = 8, ny = 8, itmax = 20
      real, parameter :: ax = 0.0, bx = 1.0, ay = 0.0, by = 1.0
      integer :: i,j
      real :: h,x,y
      real, dimension(0:nx,0:ny)::  u   

      interface
      subroutine seidel(ax,ay,nx,ny,h,itmax,u)     
      real, dimension(0:nx,0:ny), intent(in) :: u        
      real, intent(in) :: ax,ay, h                 
      integer, intent(in) :: nx, ny, itmax         
      end subroutine seidel
      end interface

      h = (bx - ax)/real(nx)      
      do j = 0,ny 
        y = ay + real(j)*h
        u(0,j)  = bndy(ax,y)
        u(nx,j) = bndy(bx,y)
      end do
      do i = 0,nx 
        x = ax + real(i)*h
        u(i,0)  = bndy(x,ay)
        u(i,ny) = bndy(x,by)
      end do
      do j = 1,ny-1
        y = ay + real(j)*h
        do i = 1,nx-1   
          x = ax + real(i)*h
          u(i,j) = ustart(x,y)
        end do
      end do
      print*, " This is u(i,j) , initial values"
      print "(//4x,i5,//(9(2x,e12.5)))",0,((u(i,j),i = 0,nx),j = 0,ny)    
      call seidel(ax,ay,nx,ny,h,itmax,u)     
      print*, "This is u(i,j) with itmax = ",itmax
      print "(//4x,i5,//(9(2x,e12.5)))",itmax,((u(i,j),i = 0,nx),j = 0,ny)
      do j = 0,ny 
        y = ay + real(j)*h
        do i = 0,nx       
          x = ax + real(i)*h
          u(i,j) = abs( true(x,y) - u(i,j) )  
        end do
      end do
      print*, " this is the difference between true value and u(i,j)"
      print "(//4x,i5,//(9(2x,e12.5)))",itmax,((u(i,j),i = 0,nx),j = 0,ny)
end program elliptic
        
      function f(x,y)
      real, intent(in) :: x, y
      f = -25.0 
      end function f
        
      function g(x,y)       
      real, intent(in):: x,y
      g = 0.0 
      end function g
        
      function bndy(x,y)    
      real,intent(in):: x,y
      bndy = true(x,y)    
      end function bndy
        
      function ustart(x,y)  
      real,intent(in):: x,y
      ustart = 1.0
      end function ustart
        
      function true(x,y)    
      real,intent(in):: x,y
      true = 0.5*(cosh(5.0*x) + cosh(5.0*y))/cosh(5.0)
      end function true
                                                   
subroutine seidel(ax,ay,nx,ny,h,itmax,u)     
      real, dimension(0:nx,0:ny), intent(in) :: u        
      real, intent(in) :: ax,ay, h                 
      integer, intent(in) :: nx, ny, itmax         
      integer:: i,j,k

      do  k = 1,itmax      
        do  j = 1,ny-1     
          y = ay + real(j)*h
          do  i = 1,nx-1   
            x = ax + real(i)*h      
            v = u(i+1,j) + u(i-1,j) + u(i,j+1) + u(i,j-1) 
            u(i,j) = (v - h*h*g(x,y))/(4.0 - h*h*f(x,y))  
          end do
        end do
      end do
end subroutine seidel




                                                                      
