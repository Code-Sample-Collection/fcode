! integer a,b
! real    ra,rb
! a=2
! b=3
! ra=2.0
! rb=3.0
! write(*,*) b/a
! write(*,*) rb/ra
program main
  integer a,b
  real    ra,rb
  a=2
  b=3
  ra=2.0
  rb=3.0
  write(*,*) b/a    ! 输出 1, 因为使用整数计算, 小数部分会无条件舍去
  write(*,*) rb/ra  ! 输出 1.5
end program main