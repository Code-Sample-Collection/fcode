SUBROUTINE difeq(k,k1,k2,jsf,is1,isf,indexv,ne,s,nsi&
          ,nsj,y,nyj,nyk)
PARAMETER(m=41)
COMMON x(m),h,mm,n,c2,anorm
DIMENSION y(nyj,nyk),s(nsi,nsj),indexv(nyj)
INTEGER k,k1,k2,jsf,is1,isf,indexv,ne,nsi,nsj,nyj,nyk
if(k==k1)then
!boundary condition at first point
  if(mod(n+mm,2)==1) then
    s(3,3+indexv(1))=1.   !equation (15.37)
    s(3,3+indexv(2))=0.
    s(3,3+indexv(3))=0.
    s(3,jsf)=y(1,1)       !equation (15.31)
  else
    s(3,3+indexv(1))=0.   !equation (15.37)
    s(3,3+indexv(2))=1.
    s(3,3+indexv(3))=0.
    s(3,jsf)=y(2,1)       !equation (15.31)
  endif
else if(k>k2) then
!boundary conditions at last point
  !equation (15.38)
  s(1,3+indexv(1))=-(y(3,m)-c2)/(2.*(mm+1.)) 
  s(1,3+indexv(2))=1.
  s(1,3+indexv(3))=-y(1,m)/(2.*(mm+1.))
  !equation (15.32)
  s(1,jsf)=y(2,m)-(y(3,m)-c2)*y(1,m)/(2.*(mm+1.))
  s(2,3+indexv(1))=1.    !equation (15.39)
  s(2,3+indexv(2))=0.
  s(2,3+indexv(3))=0.
  s(2,jsf)=y(1,m)-anorm  !equation (15.33)
else
!interior point
  s(1,indexv(1))=-1.     !equation (15.34)
  s(1,indexv(2))=-0.5*h
  s(1,indexv(3))=0.
  s(1,3+indexv(1))=1.
  s(1,3+indexv(2))=-0.5*h
  s(1,3+indexv(3))=0.
  temp=h/(1.-(x(k)+x(k-1))**2*.25)
  temp2=.5*(y(3,k)+y(3,k-1))-c2*.25*(x(k)+x(k-1))**2
  s(2,indexv(1))=temp*temp2*.5    !equation (15.35)
  s(2,indexv(2))=-1.-.5*temp*(mm+1.)*(x(k)+x(k-1))
  s(2,indexv(3))=.25*temp*(y(1,k)+y(1,k-1))
  s(2,3+indexv(1))=s(2,indexv(1))
  s(2,3+indexv(2))=2.+s(2,indexv(2))
  s(2,3+indexv(3))=s(2,indexv(3))
  s(3,indexv(1))=0.    !equation (15.36)
  s(3,indexv(2))=0.
  s(3,indexv(3))=-1.
  s(3,3+indexv(1))=0.
  s(3,3+indexv(2))=0.
  s(3,3+indexv(3))=1.
  !equation (15.26)
  s(1,jsf)=y(1,k)-y(1,k-1)-.5*h*(y(2,k)+y(2,k-1))
  !equation (15.27)
  s(2,jsf)=y(2,k)-y(2,k-1)-temp*((x(k)+x(k-1))&  
           *.5*(mm+1.)*(y(2,k)+y(2,k-1))-temp2*&
           .5*(y(1,k)+y(1,k-1)))
  s(3,jsf)=y(3,k)-y(3,k-1)    !equation (15.30)
endif
END SUBROUTINE difeq
