FUNCTION bnldev(pp,n,idum)
INTEGER idum,n
REAL bnldev,pp,PI
!USES gammln,ran1
PARAMETER (PI=3.141592654)
INTEGER j,nold
REAL am,em,en,g,oldg,p,pc,pclog,plog,pold,&
     sq,t,y,gammln,ran1
SAVE nold,pold,pc,plog,pclog,en,oldg
DATA nold /-1/, pold /-1./
if(pp<=0.5) then
  p=pp
else
  p=1.-pp
endif
am=n*p
if (n<25) then
  bnldev=0.
  do j=1,n
    if(ran1(idum)<p) bnldev=bnldev+1.
  end do
else if (am<1.) then
  g=exp(-am)
  t=1.
  do j=0,n
    t=t*ran1(idum)
    if (t<g) exit
  end do
  if(t<g) then
    bnldev=j
  else
    j=n
	bnldev=j
  end if
else
  if (n/=nold) then
    en=n
    oldg=gammln(en+1.)
    nold=n
  endif
  if (p/=pold) then
    pc=1.-p
    plog=log(p)
    pclog=log(pc)
    pold=p
  endif
  sq=sqrt(2.*am*pc)
  do
    do
      y=tan(PI*ran1(idum))
      em=sq*y+am
      if (.not.(em<0..or.em>=en+1.)) exit
    end do
    em=int(em)
    t=1.2*sq*(1.+y**2)*exp(oldg-gammln(em+1.)-&
       gammln(en-em+1.)+em*plog+(en-em)*pclog)
    if (.not.ran1(idum)>t) exit
  end do
  bnldev=em
endif
if (p/=pp) bnldev=n-bnldev
END FUNCTION bnldev
