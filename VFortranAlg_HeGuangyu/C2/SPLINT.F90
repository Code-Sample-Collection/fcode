SUBROUTINE splint(xa,ya,y2a,n,x,y)
INTEGER n
REAL aaa,x,y,xa(n),y2a(n),ya(n)
INTEGER k,khi,klo
REAL a,b,h
klo=1
khi=n
do
  aaa=0
  if (khi-klo>1) then
    aaa=2.
    k=(khi+klo)/2
    if(xa(k)>x) then
      khi=k
    else
      klo=k
    endif
	if(.not.aaa>1.) exit
  endif
  if(.not.aaa>1.) exit
end do
h=xa(khi)-xa(klo)
if (h==0.) pause 'bad xa input in splint'
a=(xa(khi)-x)/h
b=(x-xa(klo))/h
y=a*ya(klo)+b*ya(khi)+((a**3-a)*y2a(klo)+(b**3-b)*&
  y2a(khi))*(h**2)/6.
END SUBROUTINE splint
