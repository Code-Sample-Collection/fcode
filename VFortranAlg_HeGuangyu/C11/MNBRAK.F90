SUBROUTINE mnbrak(ax,bx,cx,fa,fb,fc,func)
REAL ax,bx,cx,fa,fb,fc,func,GOLD,GLIMIT,TINY
EXTERNAL func
PARAMETER (GOLD=1.618034, GLIMIT=100.,TINY=1.e-20)
REAL dum,fu,q,r,u,ulim
LOGICAL DONE
fa=func(ax)
fb=func(bx)
if(fb>fa) then
  dum=ax
  ax=bx
  bx=dum
  dum=fb
  fb=fa
  fa=dum
endif
cx=bx+GOLD*(bx-ax)
fc=func(cx)
do
  if(fb<fc) exit
  done=-1
  r=(bx-ax)*(fb-fc)
  q=(bx-cx)*(fb-fa)
  u=bx-((bx-cx)*q-(bx-ax)*r)/(2.*sign(max&
                             (abs(q-r),TINY),q-r))
  ulim=bx+GLIMIT*(cx-bx)
  if((bx-u)*(u-cx)>0.) then
    fu=func(u)
    if(fu<fc) then
      ax=bx
      fa=fb
      bx=u
      fb=fu
      return
    else if(fu>fb) then
      cx=u
      fc=fu
      return
    endif
    u=cx+GOLD*(cx-bx)
    fu=func(u)
  else if((cx-u)*(u-ulim)>0.) then
    fu=func(u)
    if(fu<fc) then
      bx=cx
      cx=u
      u=cx+GOLD*(cx-bx)
      fb=fc
      fc=fu
      fu=func(u)
    endif
  else if((u-ulim)*(ulim-cx)>=0.) then
    u=ulim
    fu=func(u)
  else
    u=cx+GOLD*(cx-bx)
    fu=func(u)
  endif
  if (done) then
    ax=bx
    bx=cx
    cx=u
    fa=fb
    fb=fc
    fc=fu
  else
    done=0
  end if
  if (.not.done) exit 
end do
END SUBROUTINE mnbrak
