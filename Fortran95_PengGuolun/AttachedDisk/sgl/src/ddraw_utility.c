#include <windows.h>
#include <ddraw.h>
#include <dinput.h>
#include <assert.h>
#include <mmsystem.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ddraw_utility.h"
#include "sgl.h"
#include "sgltype.h"

// Macro to release an object. 
#define RELEASE(x) {\
					 if (x != NULL)\
					 {\
						x->lpVtbl->Release(x);\
						x = NULL;\
					 }\
				   }
// Macro to display a message box containing the given string. 
#define DISPLAYMESSAGE(x) {\
							printf("SGL Message:%s\n",x);\
							/*MessageBox(NULL, "SGL message", x, MB_OK);*/\
						  }

#define RESTORE(x) {\
					  if ( x && x->lpVtbl->IsLost(x)==DDERR_SURFACELOST )\
						x->lpVtbl->Restore(x);\
				   }

extern sglDevice sgl;

CDDraw g_ddraw;

unsigned char *current_pointer;

static HFONT  g_font = NULL;
static DDPIXELFORMAT g_pixelformat;

extern void (*DDSetColor)(int r, int g, int b);
extern void (*DDPutPixel)(int x, int y);

extern int  SetPixelFunc( void );

PALETTEENTRY g_pe[256];

void DDTextColor(int r, int g, int b)
{
	g_ddraw.m_iTextRed = r;
	g_ddraw.m_iTextGreen = g;
	g_ddraw.m_iTextBlue = b;
}

void DDColor3i(int r, int g, int b)
{
	DDTextColor(r,g,b);
	DDSetColor(r,g,b);
}

void DDColorKey3i(int r, int g, int b)
{
	int backup = g_ddraw.m_Color;
	DDSetColor(r,g,b);
	g_ddraw.m_ColorKey = g_ddraw.m_Color;
	g_ddraw.m_Color = backup;
}

void DDColorKey(int color)
{
	g_ddraw.m_ColorKey = color;
}

void DDBGColor3i(int r, int g, int b)
{
	int backup = g_ddraw.m_Color;
	DDSetColor(r,g,b);
	g_ddraw.m_ClearColor = g_ddraw.m_Color;
	g_ddraw.m_Color = backup;
}

void DDBGColor(int color)
{
	g_ddraw.m_ClearColor = color;
}

void DDShowFPS(int show)
{
	g_ddraw.m_bShowFPS = show;
}

void DDUseFont(char *name, int width, int height)
{
	int charset = name[0]>0 ? DEFAULT_CHARSET : CHINESEBIG5_CHARSET;
	if ( g_font ) DeleteObject(g_font);
	
    g_font = CreateFont(height, width,
        0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
        charset,
        OUT_DEFAULT_PRECIS,
        CLIP_DEFAULT_PRECIS,
        DEFAULT_QUALITY,
        DEFAULT_PITCH,
        name);
}

void DDColor(int color)
{
	g_ddraw.m_Color = color;
	g_ddraw.m_iTextRed = (color & 0xff0000) >> 16;
	g_ddraw.m_iTextGreen = (color & 0x00ff00) >> 8;
	g_ddraw.m_iTextBlue = (color & 0x0000ff);
}

int DDStartDraw( void )
{
    DDSURFACEDESC2	ddsd;
	int ddrval;
    ZeroMemory(&ddsd,sizeof(ddsd));
    ddsd.dwSize = sizeof(ddsd);
	ddrval = IDirectDrawSurface7_Lock( g_ddraw.m_pTargetBuffer->surface, 
		NULL, &ddsd, DDLOCK_WAIT, NULL);
//	assert(ddrval==DD_OK);
	return (ddrval==DD_OK);
}

int DDEndDraw( void )
{
	int ddrval;
    ddrval = IDirectDrawSurface7_Unlock( g_ddraw.m_pTargetBuffer->surface, NULL);
//	assert(ddrval==DD_OK);
	return (ddrval==DD_OK);
}

void DDSetPalette(int index, int r, int g, int b)
{
	g_pe[index].peRed = r;
	g_pe[index].peGreen = g;
	g_pe[index].peBlue = b;
	g_pe[index].peFlags = 0;
}

void DDGetPalette(int index, int *r, int *g, int *b)
{
	*r = g_pe[index].peRed;
	*g = g_pe[index].peGreen;
	*b = g_pe[index].peBlue;
}

void DDSelectBuffer(int target)
{
	g_ddraw.m_iSelectBuffer = target;
	switch( target )
	{
	case SGL_BACKBUFFER:
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_BackBuffer;
		break;
	case SGL_FRONTBUFFER:
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_FrontBuffer;
		break;
	}
}

BOOL DDReady(void)
{
	return g_ddraw.m_bInitized;
}

void DDUpdatePalette(void)
{
	LPDIRECTDRAWPALETTE palette = g_ddraw.m_pPalette;
	if ( palette==NULL ) return;
	IDirectDrawPalette_SetEntries(palette, 0, 0, 256, g_pe);
}

void DDInputRelease(void)
{
	if ( g_ddraw.m_pKeyboard ) IDirectInputDevice7_Unacquire(g_ddraw.m_pKeyboard);
	RELEASE( g_ddraw.m_pKeyboard);
	RELEASE( g_ddraw.m_pDI);
}

BOOL DDInputInit(void)
{
	HRESULT hr;
	if( g_ddraw.m_hwnd==NULL )
	{
		DISPLAYMESSAGE("Call sglCreateWindow or sglFullScreen first.");
		return FALSE;
	}
    // Create a DInput object
    if( FAILED( hr = DirectInputCreateEx( GetModuleHandle(NULL), DIRECTINPUT_VERSION, 
                                         &IID_IDirectInput7, &g_ddraw.m_pDI, NULL ) ) )
	{
		DISPLAYMESSAGE("Create direct input device fail.");
        return FALSE;
	}
    // Obtain an interface to the system keyboard device.
    if( FAILED( hr = IDirectInput7_CreateDeviceEx(
		g_ddraw.m_pDI, &GUID_SysKeyboard, 
		&IID_IDirectInputDevice7, &g_ddraw.m_pKeyboard, NULL ) ) )
	{
		DISPLAYMESSAGE("Create keyboard device fail.");
        return FALSE;
	}

	if( FAILED( hr = IDirectInputDevice7_SetDataFormat( 
		g_ddraw.m_pKeyboard, &c_dfDIKeyboard ) ) )
	{
		DISPLAYMESSAGE("Set data format fail.");
        return FALSE;
	}

    if ( FAILED( hr = IDirectInputDevice7_SetCooperativeLevel(
		 g_ddraw.m_pKeyboard, g_ddraw.m_hwnd, DISCL_NONEXCLUSIVE|DISCL_FOREGROUND ) ) )
	{
		DISPLAYMESSAGE("Set directinput cooperativelevel fail.");
		RELEASE(g_ddraw.m_pKeyboard);
		RELEASE(g_ddraw.m_pDI);
		return FALSE;
	}
	
	IDirectInputDevice7_Acquire(g_ddraw.m_pKeyboard);

	return TRUE;
}

static BYTE keyboardbuffer[256];

BOOL DDReadKeyboard(void)
{
    HRESULT hr;

    if( g_ddraw.m_pKeyboard == NULL ) 
        return FALSE;
    
    // Get the input's device state, and put the state in dims
    ZeroMemory( keyboardbuffer, sizeof(keyboardbuffer) );
    hr = IDirectInputDevice7_GetDeviceState( 
		 g_ddraw.m_pKeyboard, sizeof(keyboardbuffer), keyboardbuffer );

    if( FAILED(hr) ) 
    {
        hr = IDirectInputDevice7_Acquire(g_ddraw.m_pKeyboard);
        while( hr == DIERR_INPUTLOST ) 
			hr = IDirectInputDevice7_Acquire(g_ddraw.m_pKeyboard);
		return FALSE;
    }
	return TRUE;
}

BOOL DDKeyPressed(int index)
{
	if ( g_ddraw.m_pKeyboard==NULL ) return FALSE;
	return (keyboardbuffer[index] & 0x80);
}

BOOL DDFullScreen(HWND hWnd, int width, int height, int bpp, int doublebuffer)
{
    HRESULT         ddrval;
    LPDIRECTDRAW    DDraw;
    DDSURFACEDESC2  ddsd;

	if ( DDReady() ) 
	{
//		DDRelease();
		DISPLAYMESSAGE("sglFullScreen fail.");
		return FALSE;
	}

	if ( bpp == 0 )	
	{
		HDC hdc = GetDC(hWnd);
		bpp = GetDeviceCaps(hdc,BITSPIXEL);
		ReleaseDC(hWnd, hdc);
	}
	
	ZeroMemory(&g_ddraw, sizeof(g_ddraw) );
	g_ddraw.m_Color = 0xffffffff;
	sgl.Width = g_ddraw.m_FrontBuffer.width  = width;
	sgl.Height = g_ddraw.m_FrontBuffer.height = height;
    g_ddraw.m_hwnd = hWnd;
	sgl.DoubleBuffer = g_ddraw.m_bDoubleBuffer = doublebuffer;
	g_ddraw.fpsX = 10;
	g_ddraw.fpsY = 5;
	g_ddraw.m_FrontBuffer.surface = g_ddraw.m_BackBuffer.surface = NULL;
	
    ddrval = DirectDrawCreate(NULL,&DDraw,NULL);
    if( ddrval != DD_OK )
    {
	    DISPLAYMESSAGE("Direct Draw Create Failed");
	    return FALSE;
    }

    // Fetch DirectDraw interface
    ddrval = IDirectDraw_QueryInterface( DDraw, 
		     &IID_IDirectDraw7, (LPVOID *) &(g_ddraw.m_pDDraw) );
	RELEASE(DDraw);

	if ( ddrval != DD_OK )
	{
		DISPLAYMESSAGE("Create DirectDraw 7 fail.");
		return FALSE;
	}

    ddrval = IDirectDraw7_SetCooperativeLevel( g_ddraw.m_pDDraw, 
		     hWnd, DDSCL_EXCLUSIVE|DDSCL_FULLSCREEN);
    if( ddrval != DD_OK )
    {
		RELEASE( g_ddraw.m_pDDraw );
	    DISPLAYMESSAGE("SetCooperativeLevel Failed");
	    return FALSE;
    }

    if( FAILED( IDirectDraw7_SetDisplayMode(
		g_ddraw.m_pDDraw, width, height, bpp, 0, 0 ) ) )
	{
		RELEASE(g_ddraw.m_pDDraw );
		DISPLAYMESSAGE("Invalid display mode.");
		return FALSE;
	}
	/* create primary surface */
    ZeroMemory(&ddsd,sizeof(ddsd));
    ddsd.dwSize = sizeof(ddsd);
    ddsd.dwFlags = DDSD_CAPS;
    ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_VIDEOMEMORY;
    ddrval = IDirectDraw7_CreateSurface( g_ddraw.m_pDDraw, 
		     &ddsd, &g_ddraw.m_FrontBuffer.surface, NULL);
	// impossible for primary surface
    if (ddrval != DD_OK)
    {
   		DISPLAYMESSAGE("Create Primary Surface Failed.");
		RELEASE(g_ddraw.m_pDDraw);
		return FALSE;
	}

	/* get pointer of primary sufrace */
	IDirectDrawSurface7_Lock( g_ddraw.m_FrontBuffer.surface, 
	     NULL, &ddsd, 
		 DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR, NULL);
	g_ddraw.m_FrontBuffer.pointer = (unsigned char *)ddsd.lpSurface;
	g_ddraw.m_FrontBuffer.Pitch = ddsd.lPitch;
	IDirectDrawSurface7_Unlock( g_ddraw.m_FrontBuffer.surface, NULL );

	if ( !SetPixelFunc() )
	{
		DISPLAYMESSAGE("SGL doesn't support this display mode.");
		RELEASE(g_ddraw.m_FrontBuffer.surface);
		RELEASE(g_ddraw.m_pDDraw);
		return FALSE;
	}

	ddrval = IDirectDraw7_CreatePalette( g_ddraw.m_pDDraw,
			 DDPCAPS_8BIT | DDPCAPS_ALLOW256, g_pe, &g_ddraw.m_pPalette, NULL);
	ddrval = IDirectDrawSurface7_SetPalette( g_ddraw.m_FrontBuffer.surface, g_ddraw.m_pPalette );
	DDUpdatePalette();

	if ( doublebuffer )
	{
		if ( !DDCreateBackSurface( g_ddraw.m_FrontBuffer.width, g_ddraw.m_FrontBuffer.height, &g_ddraw.m_BackBuffer ) )
		{
			DDRelease();
			return FALSE;
		}
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_BackBuffer;
	}
	else
	{
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_FrontBuffer;
	}

	DDOnMove();
	g_ddraw.m_bInitized = TRUE;

    return TRUE;
}

BOOL DDWindow( HWND hWnd, int doublebuffer )
{
    HRESULT         ddrval;
    LPDIRECTDRAW    DDraw;
    DDSURFACEDESC2  ddsd;
	RECT			rect;

	if ( DDReady() )
		DDRelease();
	
	GetClientRect(hWnd, &rect);
	ZeroMemory(&g_ddraw, sizeof(g_ddraw) );
	g_ddraw.m_Color = 0xffffffff;
	g_ddraw.m_ColorKey = 0;
	sgl.Width = g_ddraw.m_FrontBuffer.width  = rect.right-rect.left;
	sgl.Height = g_ddraw.m_FrontBuffer.height = rect.bottom-rect.top;
	sgl.DoubleBuffer = g_ddraw.m_bDoubleBuffer = doublebuffer;
    g_ddraw.m_hwnd=hWnd;
	g_ddraw.fpsX = 10;
	g_ddraw.fpsY = 5;
	g_ddraw.m_FrontBuffer.surface = g_ddraw.m_BackBuffer.surface = NULL;

    ddrval = DirectDrawCreate(NULL,&DDraw,NULL);
    if( ddrval != DD_OK )
    {
	    DISPLAYMESSAGE("Direct Draw Create Failed");
	    return FALSE;
    }

    // Fetch DirectDraw interface
    ddrval = IDirectDraw_QueryInterface( DDraw, 
			 &IID_IDirectDraw7, (LPVOID *) &(g_ddraw.m_pDDraw) );
	RELEASE(DDraw);
	if ( ddrval != DD_OK )
	{
		DISPLAYMESSAGE("Create DirectDraw 7 fail.");
		return FALSE;
	}

	ddrval = IDirectDraw7_SetCooperativeLevel(g_ddraw.m_pDDraw, hWnd, DDSCL_NORMAL);
    if( ddrval != DD_OK )
    {
	    DISPLAYMESSAGE("SetCooperativeLevel Failed.");
		RELEASE(g_ddraw.m_pDDraw);
	    return FALSE;
    }

    ZeroMemory(&ddsd,sizeof(ddsd));
    ddsd.dwSize = sizeof(ddsd);
    ddsd.dwFlags = DDSD_CAPS;
    ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_VIDEOMEMORY;
    ddrval = IDirectDraw7_CreateSurface( g_ddraw.m_pDDraw, 
		     &ddsd, &g_ddraw.m_FrontBuffer.surface, NULL);
	// impossible for primary surface
    if (ddrval != DD_OK)
    {
   		DISPLAYMESSAGE("Create Primary Surface Failed.");
		RELEASE(g_ddraw.m_pDDraw);
		return FALSE;
	}
	/* get pointer of primary surface */
	ddrval = IDirectDrawSurface7_Lock( g_ddraw.m_FrontBuffer.surface, 
			 NULL, &ddsd, 
			 DDLOCK_WAIT|DDLOCK_SURFACEMEMORYPTR, NULL);
	g_ddraw.m_FrontBuffer.pointer = (unsigned char *)ddsd.lpSurface;
	g_ddraw.m_FrontBuffer.Pitch = ddsd.lPitch;
	IDirectDrawSurface7_Unlock( g_ddraw.m_FrontBuffer.surface, NULL );

	if ( !SetPixelFunc() )
	{
		DDRelease();
		DISPLAYMESSAGE("SGL doesn't support this display mode.");
		return FALSE;
	}

    ddrval = IDirectDraw7_CreateClipper( g_ddraw.m_pDDraw, 0, &g_ddraw.m_pClipper, NULL);
    if (ddrval != DD_OK)
    {
		DDRelease();
    	DISPLAYMESSAGE("Create Clipper Failed");
	    return FALSE;
    }

    ddrval = IDirectDrawClipper_SetHWnd(g_ddraw.m_pClipper, 0, hWnd);
    if (ddrval != DD_OK)
    {
		DDRelease();
	    DISPLAYMESSAGE("Set HWnd Failed.");
        return  FALSE;
    }    

    ddrval = IDirectDrawSurface7_SetClipper( g_ddraw.m_FrontBuffer.surface, g_ddraw.m_pClipper );
    if (ddrval != DD_OK)
    {
		DDRelease();
        DISPLAYMESSAGE("Set Clipper Failed.");
        return FALSE;
    }

	ddrval = IDirectDraw7_CreatePalette( g_ddraw.m_pDDraw,
			 DDPCAPS_8BIT | DDPCAPS_ALLOW256, g_pe, &g_ddraw.m_pPalette, NULL);
	ddrval = IDirectDrawSurface7_SetPalette( g_ddraw.m_FrontBuffer.surface, g_ddraw.m_pPalette );
	DDUpdatePalette();

	if ( doublebuffer )
	{
		if ( !DDCreateBackSurface( g_ddraw.m_FrontBuffer.width, g_ddraw.m_FrontBuffer.height, &g_ddraw.m_BackBuffer ) )
		{
			DDRelease();
			return FALSE;
		}
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_BackBuffer;
	}
	else
	{
		g_ddraw.m_pTargetBuffer = &g_ddraw.m_FrontBuffer;
	}

	DDOnMove();
	g_ddraw.m_bInitized = TRUE;

    return TRUE;
}

void DDRelease( void )
{
	RELEASE( g_ddraw.m_pClipper );
	RELEASE( g_ddraw.m_pPalette );
	RELEASE( g_ddraw.m_FrontBuffer.surface );
	RELEASE( g_ddraw.m_BackBuffer.surface );
	RELEASE( g_ddraw.m_pDDraw );
	DDInputRelease();

	if ( g_font ) DeleteObject(g_font);
	g_ddraw.m_bInitized = FALSE;
}

BOOL DDCreateBackSurface( int w, int h, BufferInfo *bi)
{
    HRESULT        ddrval;
    DDSURFACEDESC2 ddsd;
 	DDPIXELFORMAT  pixelformat;
    int            width, height;

	if(g_ddraw.m_pDDraw == NULL) return FALSE;
	if ( h==0 ) h=1;
	if ( w==0 ) w=1;

	bi->rect.top = bi->rect.left = 0;
	bi->rect.right =  w;
	bi->rect.bottom = h;
    bi->width = width = w;
	bi->height = height = h;

	RELEASE( bi->surface );
    ZeroMemory( &ddsd, sizeof(ddsd) );
    ddsd.dwSize = sizeof(ddsd);
    ddsd.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
    ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
    ddsd.dwWidth  = width;
    ddsd.dwHeight = height;

    ddrval = g_ddraw.m_pDDraw->lpVtbl->CreateSurface( 
		g_ddraw.m_pDDraw, &ddsd, &bi->surface, NULL );

    if (ddrval != DD_OK)
    {
        ddsd.ddsCaps.dwCaps &= ~DDSCAPS_VIDEOMEMORY;
    	ddrval = g_ddraw.m_pDDraw->lpVtbl->CreateSurface( 
			g_ddraw.m_pDDraw, &ddsd, &bi->surface, NULL);
		if( ddrval != DD_OK )
		{
			DISPLAYMESSAGE("Create Normal Surface Failed.");
			return FALSE;
		}
    }

	ZeroMemory(&pixelformat,sizeof(DDPIXELFORMAT));
	pixelformat.dwSize=sizeof(DDPIXELFORMAT);
	bi->surface->lpVtbl->GetPixelFormat(bi->surface, &pixelformat);
	bi->BytesPerPixel = (pixelformat.dwRGBBitCount+7)/8;

	ddrval = bi->surface->lpVtbl->Lock( 
		bi->surface, NULL,&ddsd,DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR,NULL);
    bi->pointer = (unsigned char *)ddsd.lpSurface;
    bi->Pitch = ddsd.lPitch;
    bi->surface->lpVtbl->Unlock( g_ddraw.m_BackBuffer.surface, NULL );

	return TRUE;
}

void DDRestore( void )
{
	RESTORE( g_ddraw.m_FrontBuffer.surface );
	RESTORE( g_ddraw.m_BackBuffer.surface );
}

int DDBlitToFrontSurface( void )
{
	HRESULT  ddrval;

	if ( !g_ddraw.m_bDoubleBuffer ) return 1;
	if ( g_ddraw.m_FrontBuffer.width<=1 || g_ddraw.m_FrontBuffer.height<=1 )
		return 1;

	DDRestore();

	if ( g_ddraw.m_bShowFPS ) DDDrawFPS();

	ddrval = g_ddraw.m_FrontBuffer.surface->lpVtbl->Blt( 
		g_ddraw.m_FrontBuffer.surface,  &g_ddraw.m_FrontBuffer.rect, 
		g_ddraw.m_BackBuffer.surface,  &g_ddraw.m_BackBuffer.rect, 
		DDBLT_WAIT, NULL );
//	assert(ddrval!=DD_OK);
	return (ddrval == DD_OK);
}

void DDTextOut(int x, int y, char *string)
{
	HDC hdc;
	x+=g_ddraw.m_pTargetBuffer->rect.left;
	y+=g_ddraw.m_pTargetBuffer->rect.top;

	g_ddraw.m_pTargetBuffer->surface->lpVtbl->GetDC( g_ddraw.m_pTargetBuffer->surface, &hdc );
	  if ( g_font ) SelectObject(hdc, g_font);
      SetBkMode(hdc, TRANSPARENT);
	  if ( sgl.ColorBits>8 )
		SetTextColor(hdc,RGB(g_ddraw.m_iTextRed,g_ddraw.m_iTextGreen,g_ddraw.m_iTextBlue));
 	  TextOut(hdc, x, y, string, strlen(string));
	g_ddraw.m_pTargetBuffer->surface->lpVtbl->ReleaseDC( g_ddraw.m_pTargetBuffer->surface, hdc );
}

void DDDrawFPS( void )
{
	static char string[50]="\0";
	static float fps=0.0f;
	static int time,time0=0,time1=0;
	static int PreviousFrameCount=0;
	HDC hdc;

	g_ddraw.m_nFrameCount++;
	time1=timeGetTime();
	time=time1-time0;

	if ( time >= 1000 )
	{
		float Frames=(float)(g_ddraw.m_nFrameCount-PreviousFrameCount);
		float sec=(float)time/1000.0f;
		sprintf(string,"(%dX%d)  FPS:%7.1f", 
			g_ddraw.m_FrontBuffer.width, g_ddraw.m_FrontBuffer.height,
			Frames/sec);
		PreviousFrameCount=g_ddraw.m_nFrameCount;
		time0=time1;
	}

	g_ddraw.m_pTargetBuffer->surface->lpVtbl->GetDC( g_ddraw.m_pTargetBuffer->surface, &hdc );
      SetBkMode(hdc, TRANSPARENT);
	  SetTextColor(hdc,RGB(255,255,255));
 	  TextOut(hdc, g_ddraw.m_pTargetBuffer->rect.left+g_ddraw.fpsX, 
		  g_ddraw.m_pTargetBuffer->rect.top+g_ddraw.fpsY, string, strlen(string));
	g_ddraw.m_pTargetBuffer->surface->lpVtbl->ReleaseDC( g_ddraw.m_pTargetBuffer->surface, hdc );
}

int DDClearTargetSurface( void )
{
	HRESULT result;
	DDBLTFX ddbltfx;

	RESTORE( g_ddraw.m_pTargetBuffer->surface );

	ZeroMemory(&ddbltfx, sizeof(ddbltfx));
	ddbltfx.dwSize = sizeof(ddbltfx);
	ddbltfx.dwFillColor = g_ddraw.m_ClearColor;
	result = g_ddraw.m_pTargetBuffer->surface->lpVtbl->Blt(
		g_ddraw.m_pTargetBuffer->surface, NULL, 
		NULL, NULL, 
		DDBLT_COLORFILL | DDBLT_WAIT, &ddbltfx );
	assert(result==DD_OK);
	return (result==DD_OK);
}

void DDOnSize( void )
{
	RECT rect;
	GetClientRect( g_ddraw.m_hwnd, &rect );
	g_ddraw.m_FrontBuffer.width = rect.right - rect.left;
	g_ddraw.m_FrontBuffer.height = rect.bottom - rect.top;
	if ( g_ddraw.m_bDoubleBuffer )
	{
		g_ddraw.m_BackBuffer.width  = g_ddraw.m_FrontBuffer.width;
		g_ddraw.m_BackBuffer.height = g_ddraw.m_FrontBuffer.height;
		DDCreateBackSurface(g_ddraw.m_BackBuffer.width, g_ddraw.m_BackBuffer.height, &g_ddraw.m_BackBuffer );
	}
	DDOnMove();
}

void DDOnMove( void )
{
	RECT rect;
	POINT pt = { 0,0 };

    GetClientRect( g_ddraw.m_hwnd, &rect );
	pt.x=pt.y=0;
	ClientToScreen( g_ddraw.m_hwnd, &pt );

	g_ddraw.m_FrontBuffer.rect = rect;
	OffsetRect( &g_ddraw.m_FrontBuffer.rect, pt.x, pt.y );
	g_ddraw.m_FrontBuffer.pointeroffset = 
		pt.x * g_ddraw.m_FrontBuffer.BytesPerPixel + pt.y * g_ddraw.m_FrontBuffer.Pitch;
	g_ddraw.m_BackBuffer.pointeroffset = 0;
}


void DDvline(int x, int y, int yext)
{
	int i;
	if ( yext>0 )
	{
		for(i=0; i<yext; i++,y++)
		{
			DDPutPixel(x,y);
		}
	}
	else
	{
		for(i=0; i>yext; i--,y--)
		{
			DDPutPixel(x,y);
		}
	}
}

void DDhline(int x, int y, int xext)
{
	int i;
	if ( xext>0 )
	{
		for(i=0; i<xext; i++,x++)
		{
			DDPutPixel(x,y);
		}
	}
	else
	{
		for(i=0; i>xext; i--,x--)
		{
			DDPutPixel(x,y);
		}
	}
}

/*
void DDDrawFilledRect( int x0, int y0, int x1, int y1 )
{
	HRESULT result = !DD_OK;
	DDBLTFX ddbltfx;
	RECT rect;

    SetRect(&rect, x0, y0, x1, y1);
	ZeroMemory(&ddbltfx, sizeof(ddbltfx));
	ddbltfx.dwSize = sizeof(ddbltfx);
	ddbltfx.dwFillColor = g_ddraw.m_Color;
	
	RESTORE( g_ddraw.m_pTargetBuffer->surface );
	result = g_ddraw.m_pTargetBuffer->surface->lpVtbl->Blt(
		g_ddraw.m_pTargetBuffer->surface, &rect, 
		NULL, NULL,
		DDBLT_COLORFILL | DDBLT_WAIT, &ddbltfx );
}
*/

static void swap(int *a, int *b)
{
	int c;
	c=*a;
	*a=*b;
	*b=*a;
}

void DDDrawFilledRect( int x0, int y0, int x1, int y1 )
{
	int x,y;
	for ( y=y0; y<=y1; y++ )
		for ( x=x0; x<=x1; x++ )
			DDPutPixel(x,y);
}

void DDGetBuffer(void *buffer, int x, int y, int width, int height)
{
	unsigned char *dest = (unsigned char *)buffer;
	unsigned char *src  = (unsigned char *)g_ddraw.m_pTargetBuffer->pointer;
	unsigned char *proc;
	int px,py,i;
	RECT rect = g_ddraw.m_pTargetBuffer->rect;

	x+=rect.left;
	y+=rect.top;
	
	for ( py=y; py<y+height; py++ )
	{
		proc = src + py*g_ddraw.m_pTargetBuffer->Pitch + 
			  		  x*g_ddraw.m_pTargetBuffer->BytesPerPixel;
		if ( py<rect.top || py>=rect.bottom )
		{
			memset(dest, 0, width*g_ddraw.m_pTargetBuffer->BytesPerPixel);
			dest+=width*g_ddraw.m_pTargetBuffer->BytesPerPixel;
		}
		else
		{
			for ( px=x; px<x+width; px++ )
			{
				if ( px<rect.left || px>=rect.right )
				{
					for ( i=0; i<g_ddraw.m_pTargetBuffer->BytesPerPixel; i++ )
						*dest++ = 0;
				}
				else
				{
					for ( i=0; i<g_ddraw.m_pTargetBuffer->BytesPerPixel; i++ )
						*dest++ = *proc++;
				}
			}
		}
	}
}

void DDPutBuffer(void *buffer, int x, int y, int width, int height)
{
	unsigned char *src  = (unsigned char *)buffer;
	unsigned char *dest = (unsigned char *)g_ddraw.m_pTargetBuffer->pointer;
	unsigned char *proc;

	int dx, dy;
	int sx, sy;

	int rx = x;
	int ry = y;
	int bx = 0;
	int by = 0;
	int bw = width;
	int bh = height;

	int i;

	if ( rx<0 )
	{
		bx = -x;
		rx = 0;
		bw = width-bx;
	}
	if ( rx+bw > sgl.Width )
	{
		if ( rx>0 )
			bw = sgl.Width-rx;
		else
			bw = sgl.Width;
	}

	if ( ry<0 ) 
	{
		by = -y;
		ry = 0;
		bh = height-by;
	}
	if ( ry+bh > sgl.Height )
	{
		if ( ry>0 )
			bh = sgl.Height-ry;
		else
			bh = sgl.Height;
	}

	dx = rx;
	sx = bx;

	if ( !sgl.EnableColorKey )
	{
		for ( sy=by, dy=ry; sy<by+bh; sy++,dy++ )
		{
			proc = dest + 
				   dy * g_ddraw.m_pTargetBuffer->Pitch + 
				   dx * g_ddraw.m_pTargetBuffer->BytesPerPixel +
				   g_ddraw.m_pTargetBuffer->pointeroffset;
			src = (unsigned char *)buffer + 
				  sy*width*g_ddraw.m_pTargetBuffer->BytesPerPixel + 
				  sx*g_ddraw.m_pTargetBuffer->BytesPerPixel;
			if ( bw>0 )
				memcpy( proc, src, bw*g_ddraw.m_pTargetBuffer->BytesPerPixel );
		}
	}
	else
	{
		for ( sy=by, dy=ry; sy<by+bh; sy++,dy++ )
		{
			proc = dest + 
				   dy * g_ddraw.m_pTargetBuffer->Pitch + 
				   dx * g_ddraw.m_pTargetBuffer->BytesPerPixel +
				   g_ddraw.m_pTargetBuffer->pointeroffset;
			src = (unsigned char *)buffer + 
				  sy*width*g_ddraw.m_pTargetBuffer->BytesPerPixel + 
				  sx*g_ddraw.m_pTargetBuffer->BytesPerPixel;

			switch(g_ddraw.m_pTargetBuffer->BytesPerPixel)
			{
			case 1:
				for ( i=0; i<bw; i++, proc++, src++ )
				{
					if ( *src!=g_ddraw.m_ColorKey)
					{
						*proc=*src;
					}
				}
				break;

			case 2:
				for ( i=0; i<bw; i++, proc+=2, src+=2 )
				{
					if ( (*(unsigned short*)src)!=g_ddraw.m_ColorKey)
					{
						*( (unsigned short *) proc )=*((unsigned short *)src);
					}
				}
				break;
			case 3:
				for ( i=0; i<bw; i++, proc+=3, src+=3 )
				{
					unsigned int color = (UINT)src[2]<<16|(UINT)src[1]<<8|src[0];
					if ( color!=g_ddraw.m_ColorKey)
					{
						proc[0]=src[0];
						proc[1]=src[1];
						proc[2]=src[2];
					}
				}
				break;
			case 4:
				for ( i=0; i<bw; i++, proc+=4, src+=4 )
				{
					unsigned int color = *( (unsigned int *) src);
					if ( color!=g_ddraw.m_ColorKey)
					{
						*( (unsigned int *) proc ) = color;
					}
				}
				break;
			} 
		}
	}
}

void DDGetRGBBuffer(void *buffer, int x, int y, int width, int height)
{
	unsigned char *proc = (unsigned char*)buffer;
	int r,g,b;
	int px,py;
	for ( py = y; py < y+height; py++ )
	{
		for ( px = x; px < x+width; px++ )
		{
			DDGetPixel(px,py,&r,&g,&b);
			*proc++=r;
			*proc++=g;
			*proc++=b;
		}
	}
}

void DDPutRGBBuffer(void *buffer, int x, int y, int width, int height)
{
	unsigned char *proc = (unsigned char*)buffer;
	int backup = g_ddraw.m_Color;
	int px, py;

	if ( !sgl.EnableColorKey )
	{
		for ( py = y; py < y+height; py++ )
		{
			for ( px = x; px < x+width; px++, proc+=3 )
			{
				DDSetColor( proc[0], proc[1], proc[2] );
				DDPutPixel(px,py);
			}
		}
	}
	else
	{
		for ( py = y; py < y+height; py++ )
		{
			for ( px = x; px < x+width; px++, proc+=3 )
			{
				DDSetColor( proc[0], proc[1], proc[2] );
				if (g_ddraw.m_Color!=g_ddraw.m_ColorKey)
					DDPutPixel(px,py);
			}
		}
	}
	g_ddraw.m_Color = backup;
}

