#ifndef _SGL_H_
#define _SGL_H_

#include "sglkey.h"

#ifdef __cplusplus
extern "C" {
#endif

enum __sglBuffer 
{ 
	SGL_FRONTBUFFER = 0, 
	SGL_BACKBUFFER
};

typedef enum __sglBuffer sglBuffer;

enum __sglPixelMode 
{ 
	SGL_UNKNOWN=0,
	SGL_R8G8B8A8, 
	SGL_B8G8R8A8, 
	SGL_A8R8G8B8,
	SGL_A8B8G8R8,
	SGL_R8G8B8,
	SGL_B8G8R8,
	SGL_R5G6B5,
	SGL_B5G6R5,
	SGL_R5G5B5,
	SGL_B5G5R5,
	SGL_256
};

enum __sglInfoIndex
{
	SGL_WINDOW_WIDTH = 1,
	SGL_WINDOW_HEIGHT,
	SGL_COLORBITS,
	SGL_TIME
};

typedef enum __sglPixelMode sglPixelMode;

/* User Interface */
void sglFullScreen(int cx, int cy, int bpps, int doublebuffer);
void sglCreateWindow(int ox, int oy, int width, int height, int doublebuffer);
void sglShowCursor(int show);
void sglMainLoop(void);
void sglSetTitle(char *str);
void sglEnableReshape(int enable);

void sglSetPalette(int index, int r, int g, int b);
void sglGetPalette(int index, int *r, int *g, int *b);
void sglDefaultPalette(void);
void sglUpdatePalette(void);

void sglCaptureKeyboard(void);
void sglReleaseKeyboard(void);
void sglReadKeyboard(void);
int  sglKeyPressed(int key);

/* callback setup for C */
void sglDisplayFunc( void (*func)(void) );
void sglReshapeFunc( void (*func)(int, int) );
void sglIdleFunc   ( void (*func)(void) );
void sglKeyDownFunc( void (*func)(int key) );
void sglKeyUpFunc  ( void (*func)(int key) );
void sglGetCharFunc( void (*func)(int key) );
void sglMouseMoveFunc ( void (*func)(int x, int y) );
void sglMouseDownFunc ( void (*func)(int key, int x, int y) );
void sglMouseUpFunc   ( void (*func)(int key, int x, int y) );
void sglTimerFunc  ( int time, void (*func)(void) );

/* callback setup for Fortran */
void sglDisplaySub( void (_stdcall *sub)(void) );
void sglReshapeSub( void (_stdcall *sub)(int *w, int *h) );
void sglIdleSub   ( void (_stdcall *sub)(void) );
void sglKeyDownSub( void (_stdcall *sub)(int *key) );
void sglKeyUpSub  ( void (_stdcall *sub)(int *key) );
void sglGetCharSub( void (_stdcall *sub)(int *key) );
void sglMouseMoveSub ( void (_stdcall *sub)(int *x, int *y) );
void sglMouseDownSub ( void (_stdcall *sub)(int *key, int *x, int *y) );
void sglMouseUpSub   ( void (_stdcall *sub)(int *key, int *x, int *y) );
void sglTimerSub  ( int time, void (_stdcall *func)(void) );

/* query */
int  sglReady(void);
int  sglGetInfo(int index);
void sglGetPixel(int x, int y, int *r, int *g, int *b);

/* misc */
void sglSelectBuffer( int target );
void sglClearBuffer(void);
void sglUpdateBuffer(void);
void sglShowFPS(int flag);
void sglEnd(void);

/* draw */

/* set foreground color */
void sglColor3f(float r, float g, float b);
void sglColor3i(int r, int g, int b);
void sglColor(int color);

/* set background color */
void sglClearColor3f(float r, float g, float b);
void sglClearColor3i(int r, int g, int b);
void sglClearColor(int color);

/* color key */
void sglEnableColorKey(void);
void sglDisableColorKey(void);
void sglColorKey3f(float r, float g, float b);
void sglColorKey3i(int r, int g, int b);
void sglColorKey(int color);

/* draw basic geometry */
void sglPixel( int x, int y );
void sglLine( int x0, int y0, int x1, int y1 );
void sglRect( int x0, int y0, int x1, int y1 );
void sglFilledRect( int x0, int y0, int x1, int y1 );
void sglCircle( int cx, int cy, int r );
void sglFilledCircle( int cx, int cy, int r);
void sglEllipse(int cx, int cy, int rx, int ry);
void sglFilledEllipse(int cx, int cy, int rx, int ry);
void sglArc(int cx, int cy, int r, float start, float end);
void sglFan(int cx, int cy, int r, float start, float end);

/* draw text */
void sglUseFont(char *name, int w, int h);
void sglTextOut(int x, int y, char *string);

/* block operation */
void sglGetBuffer(void *buffer, int x, int y, int width, int height);
void sglPutBuffer(void *buffer, int x, int y, int width, int height);
void sglGetRGBBuffer(void *buffer, int x, int y, int width, int height);
void sglPutRGBBuffer(void *buffer, int x, int y, int width, int height);

/* virtual */
void sglSetVirtual(float left, float top, float right, float bottom);
void sglPixelV(float x, float y);
void sglLineV(float x0, float y0, float x1, float y1);
void sglRectV(float x0, float y0, float x1, float y1);
void sglFillRectV(float x0, float y0, float x1, float y1);
void sglCircleV(float cx, float cy, float r);
void sglFilledCircleV(float cx, float cy, float r);
void sglEllipseV(float cx, float cy, float rx, float ry);
void sglFilledEllipseV(float cx, float cy, float rx, float ry);
void sglArcV(float cx, float cy, float r, float ang1, float ang2);
void sglFanV(float cx, float cy, float r, float ang1, float ang2);

#ifdef __cplusplus
}
#endif

#endif