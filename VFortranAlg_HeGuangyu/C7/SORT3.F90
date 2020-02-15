SUBROUTINE sort3(n,ra,rb,rc,wksp,iwksp)
INTEGER n,iwksp(n)
REAL ra(n),rb(n),rc(n),wksp(n)
!USES indexx
INTEGER j
call indexx(n,ra,iwksp)
do j=1,n
  wksp(j)=ra(j)
end do
do j=1,n
  ra(j)=wksp(iwksp(j))
end do
do j=1,n
  wksp(j)=rb(j)
end do
do j=1,n
  rb(j)=wksp(iwksp(j))
end do
do j=1,n
  wksp(j)=rc(j)
end do
do j=1,n
  rc(j)=wksp(iwksp(j))
end do
END SUBROUTINE sort3
