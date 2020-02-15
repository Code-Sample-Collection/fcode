#ifndef __SGL_DRAW
#define __SGL_DRAW

void draw_line(int x0, int y0, int x1, int y1, 
			   void (*pixel)(int x, int y),
			   void (*hline)(int, int, int),
			   void (*vline)(int, int, int) );
void draw_circle(int cx, int cy, int r, void (*pixel)(int x, int y));
void draw_filled_circle(int cx, int cy, int r, void (*hline)(int x0, int y, int ext));
void draw_ellipse(int cx, int cy, int rx, int ry, void (*pixel)(int x,int y));
void draw_filled_ellipse(int cx, int cy, int rx, int ry, void (*vline)(int x, int y, int ext));
void draw_arc(int cx, int cy, int r, float start, float end, void (*pixel)(int x, int y));

#endif