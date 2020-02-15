#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

#include "sgldef.h"
#include "sgl.h"
#include "sgltype.h"
#include "sglutility.h"
#include "sglcallback.h"

#ifdef DIRECTX
#include "ddraw_utility.h"
extern CDDraw g_ddraw;
#endif

#define SGL_TIMERID 11

extern sglDevice sgl;

static HWND g_hwnd = NULL;
static char g_wintitle[128] = "SGL Application";
static UINT g_TimerID = 0, g_TimerClock = 0;

#define DISPLAYMESSAGE(x) {\
							printf("SGL Message:%s\n",x);\
							/*MessageBox(NULL, "SGL message", x, MB_OK);*/\
						  }

void Win32SetTitle(char *str)
{
	if ( g_hwnd ) SetWindowText(g_hwnd, str);
}

void Win32ShowCursor(int show)
{
	ShowCursor(show);
}


void Win32Timer(int time)
{
	if ( time<=0 ) return;

	g_TimerClock = time;

	if ( g_TimerID ) 
	{
		KillTimer(g_ddraw.m_hwnd, SGL_TIMERID);
		g_TimerID = 0;
	}

	if ( g_ddraw.m_hwnd )
		g_TimerID = SetTimer(g_ddraw.m_hwnd, SGL_TIMERID, time, NULL);
}

void Win32MainLoop(void)
{
	MSG			msg;
	SendMessage(g_hwnd, WM_PAINT, 0, 0);
	while( TRUE )
	{
		if (PeekMessage(&msg, 0, 0, 0, PM_REMOVE))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
			if ( msg.message==WM_QUIT )
			{
				break;
			}
		}
		else
		{
			if ( _sglIdleFunc ) _sglIdleFunc();
			if ( _sglIdleSub  ) _sglIdleSub ();
		}
	}
	if ( sglReady() ) DDRelease();
}


static LRESULT WINAPI
WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	PAINTSTRUCT ps;
	int x, y;
	int key;
	switch (message)
	{
		case WM_CREATE:
			break;

        case WM_DESTROY:
			if ( g_TimerID )
			{
				KillTimer(hwnd, g_TimerID);
				g_TimerID = 0;
			}
			PostQuitMessage(0);
			break;

		case WM_CLOSE:
			break;

		case WM_DISPLAYCHANGE:
			if ( !sgl.FullScreen )
			{
				if ( sglReady() ) DDRelease();
				DDWindow(hwnd, sgl.DoubleBuffer);
			}
			break;
	
        case WM_SIZE:
			sgl.Width  = LOWORD(lParam);
			sgl.Height = HIWORD(lParam);
			if ( sglReady() ) DDOnSize();
			if ( _sglReshapeFunc ) _sglReshapeFunc( sgl.Width, sgl.Height ); 
			if ( _sglReshapeSub  ) _sglReshapeSub( &sgl.Width, &sgl.Height );
			break;

        case WM_MOVE:
			if ( sglReady() ) DDOnMove();
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglWinMoveFunc ) _sglWinMoveFunc( x, y );
			if ( _sglWinMoveSub  ) _sglWinMoveSub ( &x, &y );
			break;
		
		case WM_TIMER:
			if ( SGL_TIMERID == wParam )
			{
				if ( _sglTimerFunc ) _sglTimerFunc();
				if ( _sglTimerSub  ) _sglTimerSub();
			}
			break;
		case WM_PALETTECHANGED:
			sglUpdatePalette();
			break;

		case WM_PAINT:
			BeginPaint(hwnd, &ps); /* Must have this for some Win32 reason. */
			EndPaint(hwnd, &ps);
			if ( sglReady() )
			{
				if ( _sglDisplayFunc ) _sglDisplayFunc();
				if ( _sglDisplaySub  ) _sglDisplaySub();
			}
			break;

		case WM_SYSKEYDOWN:
		case WM_KEYDOWN:
			if ( _sglKeyDownFunc ) _sglKeyDownFunc(wParam);
			if ( _sglKeyDownSub  ) _sglKeyDownSub (&wParam);
			break;

		case WM_SYSKEYUP:
		case WM_KEYUP:
			if ( _sglKeyUpFunc ) _sglKeyUpFunc(wParam);
			if ( _sglKeyUpSub  ) _sglKeyUpSub (&wParam);
			break;
		
		case WM_CHAR:
			if ( _sglGetCharFunc ) _sglGetCharFunc( wParam );
			if ( _sglGetCharSub  ) _sglGetCharSub ( &wParam );
			break;
		
		case WM_MOUSEMOVE:
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseMoveFunc ) _sglMouseMoveFunc( x, y );
			if ( _sglMouseMoveSub  ) _sglMouseMoveSub (&x,&y);
			break;

		case WM_LBUTTONDOWN:
			key = 1;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseDownFunc ) _sglMouseDownFunc(key,x,y);
			if ( _sglMouseDownSub  ) _sglMouseDownSub (&key,&x,&y);
			break;

		case WM_LBUTTONUP:
			key = 1;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseUpFunc ) _sglMouseUpFunc(key,x,y);
			if ( _sglMouseUpSub  ) _sglMouseUpSub (&key,&x,&y);
			break;

		case WM_MBUTTONDOWN:
			key = 2;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseDownFunc ) _sglMouseDownFunc(key,x,y);
			if ( _sglMouseDownSub  ) _sglMouseDownSub (&key,&x,&y);
			break;

		case WM_MBUTTONUP:
			key = 2;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseUpFunc ) _sglMouseUpFunc(key,x,y);
			if ( _sglMouseUpSub  ) _sglMouseUpSub (&key,&x,&y);
			break;

		case WM_RBUTTONDOWN:
			key = 3;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseDownFunc ) _sglMouseDownFunc(key,x,y);
			if ( _sglMouseDownSub  ) _sglMouseDownSub (&key,&x,&y);
			break;

		case WM_RBUTTONUP:
			key = 3;
			x = (int)(short) LOWORD(lParam);    
			y = (int)(short) HIWORD(lParam);		
			if ( _sglMouseUpFunc ) _sglMouseUpFunc(key,x,y);
			if ( _sglMouseUpSub  ) _sglMouseUpSub (&key,&x,&y);
			break;

		case WM_COMMAND:
			break;
    }
	return DefWindowProc(hwnd, message, wParam, lParam);
} // WndProc

void Win32FullScreen(int width, int height, int bpps, int doublebuffer)
{
	WNDCLASS	wc;
	HWND		hwnd;
	HINSTANCE   hinstance;
	DWORD		wstyle = 0;

	if ( width==0 || height==0 )
	{
		sgl.Width = width = GetSystemMetrics(SM_CXSCREEN);
        sgl.Height = height = GetSystemMetrics(SM_CYSCREEN);
	}

	wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	hinstance = wc.hInstance = GetModuleHandle(NULL);
	wc.hIcon = NULL;
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = "sgl";

	if (RegisterClass(&wc) == 0)
		return;

	wstyle = WS_POPUP;

	hwnd = CreateWindowEx(
		WS_EX_APPWINDOW,
		"sgl",
		g_wintitle,
		wstyle,
		CW_USEDEFAULT, CW_USEDEFAULT,
		CW_USEDEFAULT, CW_USEDEFAULT,
		NULL,
		NULL,		// use the window class menu
		hinstance,
		NULL
		);

	g_hwnd = hwnd;
	if (hwnd == NULL)
		return;
	
	DDFullScreen(hwnd, width, height, bpps, doublebuffer);
	ShowWindow(hwnd, TRUE);
	UpdateWindow(hwnd);
	sglShowCursor(0);
	Win32Timer(g_TimerClock);

	return;
}

void Win32CreateWindow(int cx, int cy, int width, int height, int doublebuffer)
{
	WNDCLASS	wc;
	HWND		hwnd;
	HINSTANCE   hinstance;
	DWORD		wstyle = 0;
	RECT        rect;
	
	wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	hinstance = wc.hInstance = GetModuleHandle(NULL);
	wc.hIcon = NULL;
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = "sgl";

	if (RegisterClass(&wc) == 0)
		return;

	if ( sgl.EnableReshape )
		wstyle = WS_OVERLAPPEDWINDOW;// | WS_CLIPCHILDREN | WS_CLIPSIBLINGS;
	else
		wstyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX;

	SetRect(&rect, cx, cy, cx+width, cy+height);
	AdjustWindowRect(&rect, wstyle, FALSE);

	hwnd = CreateWindowEx(
		WS_EX_APPWINDOW,
		"sgl",
		g_wintitle,
		wstyle,
		rect.left,			// x
		rect.top,			// y
		rect.right-rect.left,	// width
		rect.bottom-rect.top,	// height
		NULL,
		NULL,		// use the window class menu
		hinstance,
		NULL
		);
	g_hwnd = hwnd;
	if (hwnd == NULL)
		return;

	DDWindow(hwnd, doublebuffer);
	ShowWindow(hwnd, TRUE);
	UpdateWindow(hwnd);
	Win32Timer(g_TimerClock);

	return;
}
