SUBROUTINE scrsho(fx)
INTEGER ISCR,JSCR
REAL fx
EXTERNAL fx
PARAMETER (ISCR=60,JSCR=21)
INTEGER i,j,jz
REAL dx,dyj,x,x1,x2,ybig,ysml,y(ISCR)
CHARACTER*1 scr(ISCR,JSCR),blank,zero,yy,xx,ff
SAVE blank,zero,yy,xx,ff
DATA blank,zero,yy,xx,ff/' ','-','l','-','x'/
do
  write (*,*) ' Enter x1,x2 (= to stop)'
  read (*,*) x1,x2
  if(x1==x2) return
  do j=1,JSCR
    scr(1,j)=yy
    scr(ISCR,j)=yy
  end do
  do i=2,ISCR-1
    scr(i,1)=xx
    scr(i,JSCR)=xx
    do j=2,JSCR-1
      scr(i,j)=blank
    end do
  end do
  dx=(x2-x1)/(ISCR-1)
  x=x1
  ybig=0.
  ysml=ybig
  do i=1,ISCR
    y(i)=fx(x)
    if(y(i)<ysml) ysml=y(i)
    if(y(i)>ybig) ybig=y(i)
    x=x+dx
  end do
  if(ybig==ysml) ybig=ysml+1.
  dyj=(JSCR-1)/(ybig-ysml)
  jz=1-ysml*dyj
  do i=1,ISCR
    scr(i,jz)=zero
    j=1+(y(i)-ysml)*dyj
    scr(i,j)=ff
  end do
  write (*,'(1x,1pe10.3,1x,80a1)') ybig,&
                            (scr(i,JSCR),i=1,ISCR)
  do j=JSCR-1,2,-1
    write (*,'(12x,80a1)') (scr(i,j),i=1,ISCR)
  end do
  write (*,'(1x,1pe10.3,1x,80a1)') ysml,&
                               (scr(i,1),i=1,ISCR)
  write (*,'(12x,1pe10.3,40x,e10.3)') x1,x2
end do
END SUBROUTINE scrsho
