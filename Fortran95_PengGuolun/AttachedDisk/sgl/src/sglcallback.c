#include <stdio.h>

#include "sgldef.h"
#include "sgl.h"
#ifdef WIN32
#include "sglwin32.h"
#endif

#define DISPLAYMESSAGE(x) printf("SGL Message:%s\n",x);

void (*_sglDisplayFunc)(void) = NULL;
void (*_sglIdleFunc)   (void) = NULL;
void (*_sglReshapeFunc)(int,int) = NULL;
void (*_sglWinMoveFunc)(int x, int y) = NULL;
void (*_sglKeyDownFunc)(int key) = NULL;
void (*_sglKeyUpFunc)  (int key) = NULL;
void (*_sglGetCharFunc)(int key) = NULL;
void (*_sglMouseMoveFunc)(int x, int y) = NULL;
void (*_sglMouseDownFunc)(int key, int x, int y) = NULL;
void (*_sglMouseUpFunc)  (int key, int x, int y) = NULL;
void (*_sglTimerFunc)  (void) = NULL;

void (_stdcall *_sglDisplaySub)(void) = NULL;
void (_stdcall *_sglIdleSub)   (void) = NULL;
void (_stdcall *_sglReshapeSub)(int *w, int *h) = NULL;
void (_stdcall *_sglWinMoveSub)(int *x, int *y) = NULL;
void (_stdcall *_sglKeyDownSub)(int *key) = NULL;
void (_stdcall *_sglKeyUpSub)  (int *key) = NULL;
void (_stdcall *_sglGetCharSub)(int *key) = NULL;
void (_stdcall *_sglMouseMoveSub)(int *x, int *y) = NULL;
void (_stdcall *_sglMouseDownSub)(int *key, int *x, int *y) = NULL;
void (_stdcall *_sglMouseUpSub)  (int *key, int *x, int *y) = NULL;
void (_stdcall *_sglTimerSub)  (void) = NULL;

void sglDisplayFunc( void (*func)(void) )
{
	_sglDisplayFunc = func;
}

void sglDisplaySub( void (_stdcall *sub)(void) )
{
	_sglDisplaySub = sub;
}

void sglIdleFunc( void (*func)(void) )
{
	_sglIdleFunc = func;
}

void sglIdleSub( void (_stdcall *sub)(void) )
{
	_sglIdleSub = sub;
}

void sglReshapeFunc( void (*func)(int, int) )
{
	_sglReshapeFunc = func;
}

void sglReshapeSub( void (_stdcall *sub)(int *w, int *h) )
{
	_sglReshapeSub = sub;
}

void sglWinMoveFunc( void (*func)(int,int) )
{
	_sglWinMoveFunc = func;
}

void sglWinMoveSub( void (_stdcall *sub)(int *, int *) )
{
	_sglWinMoveSub = sub;
}

void sglKeyDownFunc( void (*func)(int) )
{
	_sglKeyDownFunc = func;
}

void sglKeyDownSub( void (_stdcall *sub)(int *) )
{
	_sglKeyDownSub = sub;
}

void sglGetCharFunc( void (*func)(int key) )
{
	_sglGetCharFunc = func;
}

void sglGetCharSub( void (_stdcall *sub)(int *key) )
{
	_sglGetCharSub = sub;
}

void sglKeyUpFunc( void (*func)(int) )
{
	_sglKeyUpFunc = func;
}

void sglKeyUpSub( void (_stdcall *sub)(int *) )
{
	_sglKeyUpSub = sub;
}

void sglMouseMoveFunc( void (*func)(int,int) )
{
	_sglMouseMoveFunc = func;
}

void sglMouseMoveSub( void (_stdcall *sub)(int *,int *) )
{
	_sglMouseMoveSub = sub;
}

void sglMouseDownFunc( void (*func)(int,int,int) )
{
	_sglMouseDownFunc = func;
}

void sglMouseDownSub( void (_stdcall *sub)(int *,int *, int *) )
{
	_sglMouseDownSub = sub;
}

void sglMouseUpFunc( void (*func)(int,int,int) )
{
	_sglMouseUpFunc = func;
}

void sglMouseUpSub( void (_stdcall *sub)(int *,int *,int *) )
{
	_sglMouseUpSub = sub;
}

void sglTimerFunc( int time, void (*func)(void) )
{
	_sglTimerFunc = func;
#ifdef WIN32
	Win32Timer(time);
#endif
}

void sglTimerSub( int time, void (_stdcall *sub)(void) )
{
	_sglTimerSub = sub;
#ifdef WIN32
	Win32Timer(time);
#endif
}
