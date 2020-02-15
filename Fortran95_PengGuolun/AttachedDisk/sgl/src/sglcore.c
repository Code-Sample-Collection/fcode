#include <stdio.h>

#include "sgldef.h"
#include "sgltype.h"
#include "sgl.h"
#include "sglutility.h"

#include "draw.h"

#ifdef WIN32
#include "sglwin32.h"
#endif

#ifdef DIRECTX
#include "ddraw_utility.h"
#endif

sglDevice sgl = { 0, 0, 0, 0, 0, 0, 1, 0, 0, -1.0f, -1.0f, 1.0f, 1.0f, 2.0f, 2.0f };

#define DISPLAYMESSAGE(x) printf("SGL Message:%s\n",x);

int sglGetInfo(int index)
{
	switch(index)
	{
	case SGL_WINDOW_WIDTH:
		return sgl.Width;
		break;
	case SGL_WINDOW_HEIGHT:
		return sgl.Height;
		break;
	case SGL_COLORBITS:
		return sgl.ColorBits;
	case SGL_TIME:
		return timeGetTime()-sgl.StartTime;
	default:
		DISPLAYMESSAGE("Unknown question for sglGetInfo")
		break;
	}
	return 0;
}

void sglCreateWindow(int cx, int cy, int width, int height, int db)
{
	if ( sglReady() )
	{
		DISPLAYMESSAGE("sglCreateWindow couldn't be used here.");
		return;
	}
	sgl.Width = width;
	sgl.Height = height;
	sgl.DoubleBuffer = db;
	sgl.FullScreen = 0;
#ifdef WIN32
	Win32CreateWindow(cx, cy, width, height, db);
#endif
	sglDefaultPalette();
	sglCaptureKeyboard();
}

void sglFullScreen(int width, int height, int bpps, int db)
{
	if ( sglReady() )
	{
		DISPLAYMESSAGE("sglFullScreen couldn't be used here.");
		return;
	}

	sgl.Width = width;
	sgl.Height = height;
	sgl.ColorBits = bpps;
	sgl.DoubleBuffer = db;
	sgl.FullScreen = 1;
#ifdef WIN32
	Win32FullScreen(width, height, bpps, db);
#endif
	sglDefaultPalette();
	sglCaptureKeyboard();
}

void sglMainLoop(void)
{
#ifdef WIN32
	Win32MainLoop();
#endif
}

void sglEnableColorKey(void)
{
	sgl.EnableColorKey = 1;
}

void sglDisableColorKey(void)
{
	sgl.EnableColorKey = 0;
}

void sglSetPalette(int index, int r, int g, int b)
{
#ifdef DIRECTX
	DDSetPalette(index, r, g, b);
#endif
}

void sglUpdatePalette(void)
{
#ifdef DIRECTX
	DDUpdatePalette();
#endif
}

void sglDefaultPalette(void)
{
	int i;
	int r,g,b;

	for ( i=0; i<256; i++ )
	{
		b = (i & 0xC0)>>6;
		g = (i & 0x38)>>3;
		r = (i & 0x07);
		b = b*255/3;
		g = g*255/7;
		r = r*255/7;
		sglSetPalette(i, r, g, b);
	}
	sglUpdatePalette();
}

void sglCaptureKeyboard(void)
{
#ifdef DIRECTX
	DDInputInit();
#endif
}

void sglReleaseKeyboard(void)
{
#ifdef DIRECTX
	DDInputRelease();
#endif
}

void sglReadKeyboard(void)
{
#ifdef DIRECTX
	DDReadKeyboard();
#endif
}

int sglKeyPressed(int key)
{
#ifdef DIRECTX
	return DDKeyPressed(key) ? 1:0;
#endif
}

void sglSetTitle(char *str)
{
#ifdef WIN32
	Win32SetTitle(str);
#endif
}

void fsglSetTitle(char *str, unsigned int len)
{
	sglSetTitle( MakeCString(str,len) );
}

void sglEnableReshape( int enable )
{
	sgl.EnableReshape = enable;
}

void sglShowCursor(int show)
{
#ifdef WIN32
	Win32ShowCursor(show);
#endif
}
void sglEnd(void)
{
#ifdef WIN32
	PostQuitMessage(0);
#endif
}

void sglSetVirtual(float left, float top, float right, float bottom)
{
	sgl.vLeft = left;
	sgl.vRight = right;
	sgl.vTop = top;
	sgl.vBottom = bottom;
	sgl.vWidth = right - left;
	sgl.vHeight = bottom - top;
}

int sglMapX(float x)
{
	return (int)( (x-sgl.vLeft)*sgl.Width/sgl.vWidth+0.5f);
}

int sglMapY(float y)
{
	return (int)( (y-sgl.vTop)*sgl.Height/sgl.vHeight+0.5f);
}

int sglMapLenX(float len)
{
	int value = (int) (len*sgl.Width/sgl.vWidth);
	return value>0 ? value:-value;
}

int sglMapLenY(float len)
{
	int value = (int) (len*sgl.Height/sgl.vHeight);
	return value>0 ? value:-value;
}

float sglMapVX(int x)
{
	float r = (float)x/(float)sgl.Width;
	return r*sgl.vWidth+sgl.vLeft;
}

float sglMapVY(int y)
{
	float r = (float)y/(float)sgl.Height;
	return r*sgl.vHeight+sgl.vTop;
}

void sglLineV(float x0, float y0, float x1, float y1)
{
	int ix0 = sglMapX(x0);
	int iy0 = sglMapY(y0);
	int ix1 = sglMapX(x1);
	int iy1 = sglMapY(y1);
	sglLine(ix0, iy0, ix1, iy1);
}

void sglRectV(float x0, float y0, float x1, float y1)
{
	int ix0 = sglMapX(x0);
	int iy0 = sglMapY(y0);
	int ix1 = sglMapX(x1);
	int iy1 = sglMapY(y1);
	sglRect(ix0, iy0, ix1, iy1);
}

void sglFilledRectV(float x0, float y0, float x1, float y1)
{
	int ix0 = sglMapX(x0);
	int iy0 = sglMapY(y0);
	int ix1 = sglMapX(x1);
	int iy1 = sglMapY(y1);
	sglFilledRect(ix0, iy0, ix1, iy1);
}

void sglCircleV(float cx, float cy, float r)
{
	sglEllipseV(cx,cy,r,r);
}

void sglFilledCircleV(float cx, float cy, float r)
{
	sglFilledEllipseV(cx,cy,r,r);
}

void sglEllipseV(float cx, float cy, float rx, float ry)
{
	int ix = sglMapX(cx);
	int iy = sglMapY(cy);
	int irx = sglMapLenX(rx);
	int iry = sglMapLenY(ry);
	sglEllipse(ix,iy,irx,iry);
}

void sglFilledEllipseV(float cx, float cy, float rx, float ry)
{
	int ix = sglMapX(cx);
	int iy = sglMapY(cy);
	int irx = sglMapLenX(rx);
	int iry = sglMapLenY(ry);
	sglFilledEllipse(ix,iy,irx,iry);
}

void sglSelectBuffer(int target)
{
#ifdef DIRECTX
	DDSelectBuffer(target);
#endif
}

BOOL sglReady(void)
{
#ifdef DIRECTX
	return DDReady();
#endif
}

void sglColor3f(float r, float g, float b)
{
	int ir = (int)(r*255.0f + 0.5f);
	int ig = (int)(g*255.0f + 0.5f);
	int ib = (int)(b*255.0f + 0.5f);
	if ( ir>255 ) ir=255;
	if ( ir<0   ) ir=0;
	if ( ig>255 ) ig=255;
	if ( ig<0   ) ig=0;
	if ( ib>255 ) ib=255;
	if ( ib<0   ) ib=0;
#ifdef DIRECTX
	DDSetColor(ir,ig,ib);
#endif
}

void sglColor3i(int r, int g, int b)
{
#ifdef DIRECTX
	DDColor3i(r,g,b);
#endif
}

void sglColor(int color)
{
#ifdef DIRECTX
	DDColor(color);
#endif
}

void sglColorKey3f(float r, float g, float b)
{
	int ir = (int)(255.0f*r+0.5f);
	int ig = (int)(255.0f*g+0.5f);
	int ib = (int)(255.0f*b+0.5f);
#ifdef DIRECTX
	DDColorKey3i(ir,ig,ib);
#endif
}

void sglColorKey3i(int r, int g, int b)
{
#ifdef DIRECTX
	DDColorKey3i(r,g,b);
#endif
}

void sglColorkey(int color)
{
#ifdef DIRECTX
	DDColorKey(color);
#endif
}

void sglClearColor3f(float r, float g, float b)
{
	int ir = (int)(r*255.0f + 0.5f);
	int ig = (int)(g*255.0f + 0.5f);
	int ib = (int)(b*255.0f + 0.5f);
	if ( ir>255 ) ir=255;
	if ( ir<0   ) ir=0;
	if ( ig>255 ) ig=255;
	if ( ig<0   ) ig=0;
	if ( ib>255 ) ib=255;
	if ( ib<0   ) ib=0;
#ifdef DIRECTX
	DDBGColor3i(ir,ig,ib);
#endif
}

void sglClearColor3i(int r, int g, int b)
{
#ifdef DIRECTX
	DDBGColor3i(r,g,b);
#endif
}

void sglClearColor(int color)
{
#ifdef DIRECTX
	DDBGColor(color);
#endif
}

void sglPixel( int x, int y )
{
#ifdef DIRECTX
	DDStartDraw();
	DDPutPixel(x,y);
	DDEndDraw();
#endif
}

void sglPixelV( float x, float y)
{
	int ix = (int)(sglMapX(x)+0.5f);
    int iy = (int)(sglMapY(y)+0.5f);
	sglPixel(ix,iy);
}

void sglRect( int x0, int y0, int x1, int y1 )
{
	sglLine(x0,y0, x1,y0);
	sglLine(x0,y1, x1,y1);
	sglLine(x0,y0, x0,y1);
	sglLine(x1,y0, x1,y1);
}

void sglFilledRect( int x0, int y0, int x1, int y1 )
{
#ifdef DIRECTX
	DDStartDraw();
	DDDrawFilledRect(x0,y0, x1,y1);
	DDEndDraw();
#endif
}

void sglLine( int x0, int y0, int x1, int y1 )
{
#ifdef DIRECTX
	DDStartDraw();
	draw_line(x0,y0, x1,y1, DDPutPixel, DDhline, DDvline);
	DDEndDraw();
#endif
}

void sglCircle( int cx, int cy, int r )
{
#ifdef DIRECTX
	DDStartDraw();
	draw_circle(cx , cy, r , DDPutPixel);
	DDEndDraw();
#endif
}

void sglFilledCircle( int cx, int cy, int r)
{
#ifdef DIRECTX
	DDStartDraw();
	draw_filled_circle(cx, cy, r, DDhline);
	DDEndDraw();
#endif
}

void sglEllipse( int cx, int cy, int rx, int ry )
{
#ifdef DIRECTX
	DDStartDraw();
	draw_ellipse(cx,cy, rx,ry, DDPutPixel);
	DDEndDraw();
#endif
}

void sglFilledEllipse( int cx, int cy, int rx, int ry )
{
#ifdef DIRECTX
	DDStartDraw();
	draw_filled_ellipse(cx,cy,rx,ry, DDhline);
	DDEndDraw();
#endif
}

void sglArc( int cx, int cy, int r, float start, float end )
{
#ifdef DIRECTX
	DDStartDraw();
	draw_arc(cx, cy, r, start, end, DDPutPixel);
	DDEndDraw();
#endif
}

void sglArcV( float cx, float cy, float radius, float start, float end )
{
	const int lines = 200;
	float rinc = (end-start)/(float)lines;
	float r = start;
	float x0,y0, x1,y1;
	
	x0 = cx+sglcos(r)*radius;
	y0 = cy-sglsin(r)*radius;
	r += rinc;
	while(r<=end)
	{
		x1 = cx+sglcos(r)*radius;
		y1 = cy-sglsin(r)*radius;
		sglLineV(x0,y0, x1,y1);
		x0 = x1;
		y0 = y1;
		r += rinc;
	}
}

void sglFan( int cx, int cy, int r, float start, float end )
{
	int xs = (int) (sglsin(start)*r+cx);
	int ys = (int) (sglcos(start)*r+cy);
	int xe = (int) (sglsin(end)*r+cx);
	int ye = (int) (sglcos(end)*r+cy);

	sglArc(cx, cy, r, start, end);
	sglLine(cx, cy, xs, ys);
	sglLine(cx, cy, xe, ye);
}

void sglFanV(float cx, float cy, float r, float start, float end)
{
	float xs = sglsin(start)*r+cx;
	float ys = sglcos(start)*r+cy;
	float xe = sglsin(end)*r+cx;
	float ye = sglcos(end)*r+cy;
	sglArcV(cx,cy,r,start,end);
	sglLineV(cx,cy,xs,ys);
	sglLineV(cx,cy,xe,ye);
}

void sglClearBuffer(void)
{
#ifdef DIRECTX
	DDClearTargetSurface();
#endif
}

void sglUpdateBuffer(void)
{
#ifdef DIRECTX
	DDBlitToFrontSurface();
#endif
}

void sglShowFPS(BOOL flag)
{
#ifdef DIRECTX
	DDShowFPS(flag);
#endif
}

extern char * MakeCString(char *str, unsigned int len);

void fsglTextOut(int *x, int *y, char *str, unsigned int len)
{
	sglTextOut(*x, *y, MakeCString(str,len));
}

void sglTextOut(int x, int y, char *string)
{
#ifdef DIRECTX
	DDTextOut(x,y,string);
#endif
}

void fsglUseFont(char *name, unsigned int strlen, int *w, int *h)
{
	sglUseFont( MakeCString(name,strlen), *w, *h );
}

void sglUseFont(char *name, int w, int h)
{
#ifdef DIRECTX
	DDUseFont(name, w, h);
#endif
}

void sglGetPixel(int x, int y, int *r, int *g, int *b)
{
#ifdef DIRECTX
	DDGetPixel(x,y,r,g,b);
#endif
}

void sglGetBuffer(void *buffer, int x, int y, int width, int height)
{
#ifdef DIRECTX
	DDStartDraw();
	DDGetBuffer(buffer, x, y, width, height);
	DDEndDraw();
#endif
}

void sglPutBuffer(void *buffer, int x, int y, int width, int height)
{
#ifdef DIRECTX
	DDStartDraw();
	DDPutBuffer(buffer, x, y, width, height);
	DDEndDraw();
#endif
}

void sglGetRGBBuffer(void *buffer, int x, int y, int width, int height)
{
#ifdef DIRECTX
	DDStartDraw();
	DDGetRGBBuffer(buffer, x, y, width, height);
	DDEndDraw();
#endif
}

void sglPutRGBBuffer(void *buffer, int x, int y, int width, int height)
{
#ifdef DIRECTX
	DDStartDraw();
	DDPutRGBBuffer(buffer, x, y, width, height);
	DDEndDraw();
#endif
}
