FUNCTION probks(alam)
PARAMETER(eps1=0.001,eps2=1.e-8)
REAL a2,fac,term,termbf,alam
INTEGER j
a2=-2.*alam**2
fac=2.
probks=0.
termbf=0.
do j=1,100
  term=fac*exp(a2*j**2)
  probks=probks+term
  if(abs(term)<eps1*termbf.or.abs(term)<&
       eps2*probks) return
  fac=-fac
  termbf=abs(term)
end do
probks=1.
END FUNCTION probks
