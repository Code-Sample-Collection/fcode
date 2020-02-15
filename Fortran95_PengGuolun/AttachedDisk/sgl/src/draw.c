#include <math.h>
#include "sgltype.h"
#include "sglutility.h"

extern sglDevice sgl;

void draw_line( int x0, int y0, int x1, int y1, 
			   void (*pixel)(int, int), 
			   void (*hline)(int, int, int),
			   void (*vline)(int, int, int) )
{
	int xdiff = x1 - x0;	
	int ydiff = y1 - y0;
	int xadd, yadd;
	int xinc, yinc;
	int x,y;
	int sum = 0;

	if ( xdiff > 0 )
	{
		xinc=1;
		xadd=xdiff;
	}
	else if ( xdiff < 0 )
	{
		xinc=-1;
		xadd=-xdiff;
	}
	else
	{
		xinc = xadd = 0;
	}

	if ( ydiff > 0 )
	{
		yinc=1;
		yadd=ydiff;
	}
	else if ( ydiff < 0 )
	{
		yinc=-1;
		yadd=-ydiff;
	}
	else
	{
		yinc = yadd = 0;
	}

	x=x0;
	y=y0;

	if ( xadd==0 && yadd==0 )
	{
		pixel(x,y);
	}
	else if ( xadd==0 )
	{
		vline(x,y,ydiff>0 ? ydiff+1:ydiff-1);
	}
	else if ( yadd==0 )
	{
		hline(x,y,xdiff>0? xdiff+1:xdiff-1);
	}
	else if ( xadd > yadd )
	{
		while(x!=x1)
		{
			pixel(x,y);
			x+=xinc;
			sum+=yadd;
			if ( sum>=xadd )
			{
				y+=yinc;
				sum-=xadd;
			}
		}
		pixel(x,y);
	}
	else if ( xadd < yadd )
	{
		while(y!=y1)
		{
			pixel(x,y);
			y+=yinc;
			sum+=xadd;
			if ( sum>=yadd )
			{
				x+=xinc;
				sum-=yadd;
			}
		}
		pixel(x,y);
	}
	else /* xadd = yadd */
	{
		while(x!=x1)
		{
			pixel(x,y);
			x+=xinc;
			y+=yinc;
		}
		pixel(x,y);
	}
}

static void _symetry(int xs, int ys, int x, int y, void (*pixel)(int,int))
{
	pixel(xs + x, ys + y);
	pixel(xs - x, ys + y);
	pixel(xs + x, ys - y);
	pixel(xs - x, ys - y);
	pixel(xs + y, ys + x);
	pixel(xs - y, ys + x);
	pixel(xs + y, ys - x);
	pixel(xs - y, ys - x);
}

void draw_circle( int xs, int ys, int r, void (*pixel)(int,int) )
{
	int	x =	0;
	int	y =	r;
	int	p =	3 -	2 *	r;

	if ((ys	+ r) < 0 || 
		(xs + r) < 0 ||	
		(ys	- r) >=	sgl.Height || 
		(xs - r) >= sgl.Width  ||
		 r < 1 ) 
		return;

	while (x < y)
	{
		_symetry(xs, ys, x,	y, pixel);
		if (p <	0)
			p += 4 * (x++) + 6;
		else
			p += 4 * ((x++)	- (y--)) + 10;
	}
	if (x == y)
		_symetry(xs, ys, x,	y, pixel);
}

static void _symetry2(int xs, int ys, int x, int y, void (*hline)(int,int,int) )
{
	hline(xs-x,ys+y,x+x);
	hline(xs-x,ys-y,x+x);
	hline(xs-y,ys+x,y+y);
	hline(xs-y,ys-x,y+y);
}

void draw_filled_circle(int xs, int	ys, int	r, void (*hline)(int,int,int) )
{
	int	x =	0;
	int	y =	r;
	int	p =	3 -	2 *	r;

	if ((ys	+ r) < 0 || 
		(xs + r) < 0 ||	
		(ys	- r) >= sgl.Height || 
		(xs - r) >= sgl.Width  ||
		 r < 1) 
		 return;

	while (x < y)
	{
		_symetry2(xs, ys, x, y, hline);
		if (p <	0)
			p += 4 * (x++) + 6;
		else
			p += 4 * ((x++)	- (y--)) + 10;
	}
	if (x == y)
		_symetry2(xs, ys, x, y, hline);
}

void draw_ellipse(int x, int y, int rx, int ry, void (*pixel)(int,int) )
{
	int ix, iy;
	int h, i, j, k;
	int oh, oi, oj, ok;
	
	if (rx < 1) rx = 1;
	if (ry < 1) ry = 1;

	h = i = j = k = 0xFFFF;

	if (rx > ry)
	{
		ix = 0;
		iy = rx * 64;
		do
		{
			oh = h;
			oi = i;
			oj = j;
			ok = k;
			h = (ix + 32) >> 6;
			i = (iy + 32) >> 6;
			j = (h * ry) / rx;
			k = (i * ry) / rx;
			if (((h != oh) || (k != ok)) && (h < oi))
			{
				pixel(x + h, y + k);
				if (h) pixel(x - h, y + k);
				if (k)
				{
					pixel(x + h, y - k);
					if (h) pixel(x - h, y - k);
				}
			}

			if (((i != oi) || (j != oj)) && (h < i))
			{
				pixel(x + i, y + j);
				if (i)
					pixel(x - i, y + j);
				if (j)
				{
					pixel(x + i, y - j);
					if (i)
						pixel(x - i, y - j);
				}
			}

			ix = ix + iy / rx;
			iy = iy - ix / rx;

		}
		while (i > h);
	}
	else
	{
		ix = 0;
		iy = ry * 64;

		do
		{
			oh = h;
			oi = i;
			oj = j;
			ok = k;

			h = (ix + 32) >> 6;
			i = (iy + 32) >> 6;
			j = (h * rx) / ry;
			k = (i * rx) / ry;

			if (((j != oj) || (i != oi)) && (h < i))
			{
				pixel(x + j, y + i);
				if (j) pixel(x - j, y + i);
				if (i) 
				{
					pixel(x + j, y - i);
					if (j) pixel(x - j, y - i);
				}
			}

			if (((k != ok) || (h != oh)) && (h < oi))
			{
				pixel(x + k, y + h);
				if (k) pixel(x - k, y + h);
				if (h)
				{
					pixel(x + k, y - h);
					if (k) pixel(x - k, y - h);
				}
			}
			ix = ix + iy / ry;
			iy = iy - ix / ry;
		}
		while (i > h);
	}
}

void draw_filled_ellipse(int x, int y, int rx, int ry, void (*hline)(int,int,int) )
{
	int ix, iy;
	int a, b, c, d;
	int da, db, dc, dd;
	int na, nb, nc, nd;

	if (rx > ry)
	{
		dc = -1;
		dd = 0xFFFF;
		ix = 0;
		iy = rx * 64;
		na = 0;
		nb = (iy + 32) >> 6;
		nc = 0;
		nd = (nb * ry) / rx;

		do
		{
			a = na;
			b = nb;
			c = nc;
			d = nd;

			ix = ix + (iy / rx);
			iy = iy - (ix / rx);
			na = (ix + 32) >> 6;
			nb = (iy + 32) >> 6;
			nc = (na * ry) / rx;
			nd = (nb * ry) / rx;

			if ((c > dc) && (c < dd))
			{
				hline(x - b, y + c, b * 2);
				if (c)
					hline(x - b, y - c, b * 2);
				dc = c;
			}

			if ((d < dd) && (d > dc))
			{
				hline(x - a, y + d, a * 2);
				hline(x - a, y - d, a * 2);
				dd = d;
			}

		}
		while (b > a);
	}
	else
	{
		da = -1;
		db = 0xFFFF;
		ix = 0;
		iy = ry * 64;
		na = 0;
		nb = (iy + 32) >> 6;
		nc = 0;
		nd = (nb * rx) / ry;

		do
		{
			a = na;
			b = nb;
			c = nc;
			d = nd;

			ix = ix + (iy / ry);
			iy = iy - (ix / ry);
			na = (ix + 32) >> 6;
			nb = (iy + 32) >> 6;
			nc = (na * rx) / ry;
			nd = (nb * rx) / ry;

			if ((a > da) && (a < db))
			{
				hline(x - d, y + a, d * 2);
				if (a)
					hline(x - d, y - a, d * 2);
				da = a;
			}

			if ((b < db) && (b > da))
			{
				hline(x - c, y + b, c * 2);
				hline(x - c, y - b, c * 2);
				db = b;
			}

		}
		while (b > a);
	}
}

void draw_arc(int x, int y, int r, float ang1, float ang2, void (*pixel)(int,int) )
{
	int px, py;
	int ex, ey;
	int px1, px2, px3;
	int py1, py2, py3;
	int d1, d2, d3;
	int ax, ay;
	int q, qe;
	float tg_cur, tg_end;
	int done = 0;
	double rr1, rr2, rr3;
	int rr = (r * r);

	rr1 = r;
	rr2 = x;
	rr3 = y;

	/* evaluate the start point and the end point */
	px = (int) (rr2 + rr1 * sglcos(ang1));
	py = (int) (rr3 - rr1 * sglsin(ang1));
	ex = (int) (rr2 + rr1 * sglcos(ang2));
	ey = (int) (rr3 - rr1 * sglsin(ang2));

	/* start quadrant */
	if (px >= x)
	{
		if (py <= y)
			q = 1;				/* quadrant 1 */
		else
			q = 4;				/* quadrant 4 */
	}
	else
	{
		if (py < y)
			q = 2;				/* quadrant 2 */
		else
			q = 3;				/* quadrant 3 */
	}

	/* end quadrant */
	if (ex >= x)
	{
		if (ey <= y)
			qe = 1;				/* quadrant 1 */
		else
			qe = 4;				/* quadrant 4 */
	}
	else
	{
		if (ey < y)
			qe = 2;				/* quadrant 2 */
		else
			qe = 3;				/* quadrant 3 */
	}

#define loc_tg(_y, _x)  (_x-x) ? (float)(_y-y)/(_x-x) : (float)(_y-y)

	tg_end = loc_tg(ey, ex);

	while (!done)
	{
		pixel(px, py);

		/* from here, we have only 3 possible direction of movement, eg.
		 * for the first quadrant:
		 *
		 *    OOOOOOOOO
		 *    OOOOOOOOO
		 *    OOOOOO21O
		 *    OOOOOO3*O
		 */

		/* evaluate the 3 possible points */
		switch (q)
		{

			case 1:
				px1 = px;
				py1 = py - 1;
				px2 = px - 1;
				py2 = py - 1;
				px3 = px - 1;
				py3 = py;

				/* 2nd quadrant check */
				if (px != x)
				{
					break;
				}
				else
				{
					/* we were in the end quadrant, changing is illegal. Exit. */
					if (qe == q)
						done = 1;
					q++;
				}
				/* fall through */

			case 2:
				px1 = px - 1;
				py1 = py;
				px2 = px - 1;
				py2 = py + 1;
				px3 = px;
				py3 = py + 1;

				/* 3rd quadrant check */
				if (py != y)
				{
					break;
				}
				else
				{
					/* we were in the end quadrant, changing is illegal. Exit. */
					if (qe == q)
						done = 1;
					q++;
				}
				/* fall through */

			case 3:
				px1 = px;
				py1 = py + 1;
				px2 = px + 1;
				py2 = py + 1;
				px3 = px + 1;
				py3 = py;

				/* 4th quadrant check */
				if (px != x)
				{
					break;
				}
				else
				{
					/* we were in the end quadrant, changing is illegal. Exit. */
					if (qe == q)
						done = 1;
					q++;
				}
				/* fall through */

			case 4:
				px1 = px + 1;
				py1 = py;
				px2 = px + 1;
				py2 = py - 1;
				px3 = px;
				py3 = py - 1;

				/* 1st quadrant check */
				if (py == y)
				{
					/* we were in the end quadrant, changing is illegal. Exit. */
					if (qe == q)
						done = 1;

					q = 1;
					px1 = px;
					py1 = py - 1;
					px2 = px - 1;
					py2 = py - 1;
					px3 = px - 1;
					py3 = py;
				}
				break;

			default:
				return;
		}

		/* now, we must decide which of the 3 points is the right point.
		 * We evaluate the distance from center and, then, choose the
		 * nearest point.
		 */
		ax = x - px1;
		ay = y - py1;
		rr1 = ax * ax + ay * ay;

		ax = x - px2;
		ay = y - py2;
		rr2 = ax * ax + ay * ay;

		ax = x - px3;
		ay = y - py3;
		rr3 = ax * ax + ay * ay;

		/* difference from the main radius */
		if (rr1 > rr)
			d1 = (int) (rr1 - rr);
		else
			d1 = (int) (rr - rr1);
		if (rr2 > rr)
			d2 = (int) (rr2 - rr);
		else
			d2 = (int) (rr - rr2);
		if (rr3 > rr)
			d3 = (int) (rr3 - rr);
		else
			d3 = (int) (rr - rr3);

		/* what is the minimum? */
		if (d1 <= d2)
		{
			px = px1;
			py = py1;
		}
		else if (d2 <= d3)
		{
			px = px2;
			py = py2;
		}
		else
		{
			px = px3;
			py = py3;
		}

		/* are we in the final quadrant? */
		if (qe == q)
		{
			tg_cur = loc_tg(py, px);

			/* is the arc finished? */
			switch (q)
			{

				case 1:
					/* end quadrant = 1? */
					if (tg_cur <= tg_end)
						done = 1;
					break;

				case 2:
					/* end quadrant = 2? */
					if (tg_cur <= tg_end)
						done = 1;
					break;

				case 3:
					/* end quadrant = 3? */
					if (tg_cur <= tg_end)
						done = 1;
					break;

				case 4:
					/* end quadrant = 4? */
					if (tg_cur <= tg_end)
						done = 1;
					break;
			}
		}
	}

	/* draw the last evaluated point */
	pixel(px, py);
}
