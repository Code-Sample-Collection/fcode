FUNCTION ex(x)
REAL*8 y,w,r1,r2,r3,r4,r5,r6,t1,t2,t3,t4,s1,s2,s3,s4
DATA r1,r2,r3,r4,r5,r6/0.107857d-2,-0.976004d-2,&
 0.5519968d-1,-0.24991055d0,0.99999193d0,-0.57721566d0/
DATA t1,t2,t3,t4/8.5733287401d0,1.8059016973d1,&
 8.6347608925d0,0.2677737343d0/
DATA s1,s2,s3,s4/9.5733223454d0,2.56329561486d1,&
 2.10996530827d1,3.9584969228d0/
if (x<1.) then
    ex=((((r1*x+r2)*x+r3)*x+r4)*x+r5)*x+r6-log(x)
else
    y=(((x+t1)*x+t2)*x+t3)*x+t4
    w=(((x+s1)*x+s2)*x+s3)*x+s4
    ex=(y/w)/(exp(x)*x)
endif
END FUNCTION ex
