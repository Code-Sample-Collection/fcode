C
C NUMERICAL MATHEMATICS AND COMPUTING, CHENEY/KINCAID, 1985
C
C FILE: secant.f
C
C SAMPLE SECANT METHOD PROGRAM
C 
      data  a/-1.0/, b/1.0/, M/10/
c      data epsi/1.0e-6/, delta/1.0e-6/
      fa = f(a)
      fb = f(b)
c
      print *
      print *,' Secant Method Example'
c     print *,' Section 3.3, Kincaid-Cheney'
      print *
c
      print *,'    n        x(n)         f(x(n))'
      print *,'0',a,fa	
      print *,'1',b,fb
c
      do 2 k = 2,M
         if (abs(fa) .le. abs(fb)) then
            tmp = a
            a = b
            b = tmp
            tmp = fa
            fa = fb
            fb = tmp
         endif
         s = (b - a)/(fb - fa)
         a = b
         fa = fb	
         b = b - fb*s
         fb = f(b)
         print *,k,b,fb
C         if ((abs(fb) .lt. epsi) .or. (abs(a - b) .lt. delta)) stop
 2    continue
c      print *,M,b,f(b)
c
      stop
      end
c
      function f(x)
      f = x**5 + x**3 + 3.0
      return
      end

