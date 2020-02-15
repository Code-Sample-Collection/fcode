#include <windows.h>
#include <ddraw.h>

#include "ddraw_utility.h"
#include "sgl.h"
#include "sgltype.h"

static void DDPutPixel4(int x, int y);
static void DDPutPixel3(int x, int y);
static void DDPutPixel2(int x, int y);
static void DDPutPixel1(int x, int y);

static void DDSetColorA8B8G8R8(int r, int g, int b);
static void DDSetColorA8R8G8B8(int r, int g, int b);
static void DDSetColorB8G8R8A8(int r, int g, int b);
static void DDSetColorR8G8B8A8(int r, int g, int b);
static void DDSetColorB8G8R8(int r, int g, int b);
static void DDSetColorR8G8B8(int r, int g, int b);
static void DDSetColorB5G6R5(int r, int g, int b);
static void DDSetColorR5G6B5(int r, int g, int b);
static void DDSetColorB5G5R5(int r, int g, int b);
static void DDSetColorR5G5B5(int r, int g, int b);
static void DDSetColor256(int r, int g, int b);

static void DDGetPixelA8B8G8R8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelA8R8G8B8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelB8G8R8A8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelR8G8B8A8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelB8G8R8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelR8G8B8(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelB5G6R5(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelR5G6B5(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelB5G5R5(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixelR5G5B5(unsigned char *pointer, int *r, int *g, int *b);
static void DDGetPixel256(unsigned char *pointer, int *r, int *g, int *b);

void (*DDSetColor)(int r, int g, int b) = NULL;
void (*DDPutPixel)(int x, int y) = NULL;
static void (*_DDGetPixel)(unsigned char *pointer, int *r, int *g, int *b) = NULL;

extern CDDraw g_ddraw;
extern PALETTEENTRY g_pe[256];
extern sglDevice sgl;
extern unsigned char *current_pointer;

#define OUT_RANGE(x,y) if ( x<0 || y<0 || x>=sgl.Width || y>=sgl.Height ) return;

int SetPixelFunc(void)
{
 	DDPIXELFORMAT   pf;

	ZeroMemory(&pf,sizeof(DDPIXELFORMAT));
	pf.dwSize=sizeof(DDPIXELFORMAT);
	IDirectDrawSurface7_GetPixelFormat( g_ddraw.m_FrontBuffer.surface, &pf );
	g_ddraw.m_FrontBuffer.BytesPerPixel = (pf.dwRGBBitCount+7)/8;
	sgl.ColorBits = pf.dwRGBBitCount;
	g_ddraw.m_iPixelMode = SGL_UNKNOWN;
	switch( pf.dwRGBBitCount )
	{
	case 32:
		DDPutPixel = DDPutPixel4;
		if ( pf.dwRBitMask == 0x000000ff &&
			 pf.dwGBitMask == 0x0000ff00 &&
			 pf.dwBBitMask == 0x00ff0000 )
		{
			DDSetColor = DDSetColorA8B8G8R8;
			_DDGetPixel = DDGetPixelA8B8G8R8;
			g_ddraw.m_iPixelMode = SGL_A8B8G8R8;
		}
		else if ( pf.dwRBitMask == 0x00ff0000 &&
				  pf.dwGBitMask == 0x0000ff00 &&
				  pf.dwBBitMask == 0x000000ff )
		{
			DDSetColor = DDSetColorA8R8G8B8;
			_DDGetPixel = DDGetPixelA8R8G8B8;
			g_ddraw.m_iPixelMode = SGL_A8R8G8B8;
		}
		else if ( pf.dwRBitMask == 0x0000ff00 &&
			 pf.dwGBitMask == 0x00ff0000 &&
			 pf.dwBBitMask == 0xff000000 )
		{
			DDSetColor = DDSetColorB8G8R8A8;
			_DDGetPixel = DDGetPixelB8G8R8A8;
			g_ddraw.m_iPixelMode = SGL_B8G8R8A8;
		}
		else if ( pf.dwRBitMask == 0xff000000 &&
				  pf.dwGBitMask == 0x00ff0000 &&
				  pf.dwBBitMask == 0x0000ff00 )
		{
			DDSetColor = DDSetColorR8G8B8A8;
			_DDGetPixel = DDGetPixelR8G8B8A8;
			g_ddraw.m_iPixelMode = SGL_R8G8B8A8;
		}
		break;

	case 24:
		DDPutPixel = DDPutPixel3;
		if ( pf.dwRBitMask == 0x0000ff &&
			 pf.dwGBitMask == 0x00ff00 &&
			 pf.dwBBitMask == 0xff0000 )
		{
			DDSetColor = DDSetColorB8G8R8;
			_DDGetPixel = DDGetPixelB8G8R8;
			g_ddraw.m_iPixelMode = SGL_B8G8R8;
		}
		else if ( pf.dwRBitMask == 0xff0000 &&
			      pf.dwGBitMask == 0x00ff00 &&
				  pf.dwBBitMask == 0x0000ff )
		{
			DDSetColor = DDSetColorR8G8B8;
			_DDGetPixel = DDGetPixelR8G8B8;
			g_ddraw.m_iPixelMode = SGL_R8G8B8;
		}
		break;

	case 16:
	case 15:
		DDPutPixel = DDPutPixel2;
		if ( pf.dwRBitMask == 0x001f &&
			 pf.dwGBitMask == 0x03e0 &&
			 pf.dwBBitMask == 0x7c00 )
		{
			DDSetColor = DDSetColorB5G5R5;
			_DDGetPixel = DDGetPixelB5G5R5;
			g_ddraw.m_iPixelMode = SGL_B5G5R5;
		}
		else if ( pf.dwRBitMask == 0x7c00 &&
				  pf.dwGBitMask == 0x03e0 &&
				  pf.dwBBitMask == 0x001f )
		{
			DDSetColor = DDSetColorR5G5B5;
			_DDGetPixel = DDGetPixelR5G5B5;
			g_ddraw.m_iPixelMode = SGL_R5G5B5;
		}
		else if ( pf.dwRBitMask == 0x001f &&
				  pf.dwGBitMask == 0x07e0 &&
				  pf.dwBBitMask == 0xf800 )
		{
			DDSetColor = DDSetColorB5G6R5;
			_DDGetPixel = DDGetPixelB5G6R5;
			g_ddraw.m_iPixelMode = SGL_B5G6R5;
		}
		else if ( pf.dwRBitMask == 0xf800 &&
				  pf.dwGBitMask == 0x07e0 &&
				  pf.dwBBitMask == 0x001f )
		{
			DDSetColor = DDSetColorR5G6B5;
			_DDGetPixel = DDGetPixelR5G6B5;
			g_ddraw.m_iPixelMode = SGL_R5G6B5;
		}
		break;

	case 8:
		DDPutPixel = DDPutPixel1;
		DDSetColor = DDSetColor256;
		_DDGetPixel = DDGetPixel256;
		g_ddraw.m_iPixelMode = SGL_256;
		break;

	case 4:
		break;
	}

	sgl.PixelMode = g_ddraw.m_iPixelMode;
	return sgl.PixelMode!=SGL_UNKNOWN;
}

void DDGetPixel(int x, int y, int *r, int *g, int *b)
{
	OUT_RANGE(x,y);
	
	current_pointer = g_ddraw.m_pTargetBuffer->pointer + 
		      g_ddraw.m_pTargetBuffer->pointeroffset +
		      y * g_ddraw.m_pTargetBuffer->Pitch + 
		      x * g_ddraw.m_pTargetBuffer->BytesPerPixel;

	_DDGetPixel(current_pointer,r,g,b);
}

void DDPutPixel4( int x, int y)
{
	OUT_RANGE(x,y)

	current_pointer = g_ddraw.m_pTargetBuffer->pointer + g_ddraw.m_pTargetBuffer->pointeroffset +
		y * g_ddraw.m_pTargetBuffer->Pitch + 
		x * 4;

	*( (unsigned int *) current_pointer ) = g_ddraw.m_Color;
}

static void DDPutPixel3( int x, int y)
{
	OUT_RANGE(x,y)

	current_pointer = g_ddraw.m_pTargetBuffer->pointer + g_ddraw.m_pTargetBuffer->pointeroffset +
		y * g_ddraw.m_pTargetBuffer->Pitch + 
		x * 3;

	*( (unsigned int *) current_pointer ) = ( g_ddraw.m_Color & 0x00ffffff );
}

static void DDPutPixel2( int x, int y)
{
	OUT_RANGE(x,y)

	current_pointer = g_ddraw.m_pTargetBuffer->pointer + g_ddraw.m_pTargetBuffer->pointeroffset +
		y * g_ddraw.m_pTargetBuffer->Pitch + 
		x * 2;

	*( (unsigned short *) current_pointer ) = g_ddraw.m_Color;
}

static void DDPutPixel1( int x, int y)
{
	OUT_RANGE(x,y)

	current_pointer = g_ddraw.m_pTargetBuffer->pointer + g_ddraw.m_pTargetBuffer->pointeroffset + 
		y * g_ddraw.m_pTargetBuffer->Pitch + 
		x;

	*current_pointer = g_ddraw.m_Color;
}


static void DDSetColorA8B8G8R8(int r, int g, int b)
{
	g_ddraw.m_Color = b<<16 | g<<8 | r;
}

static void DDGetPixelA8B8G8R8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[0];
	*g = pointer[1];
	*b = pointer[2];
}

static void DDSetColorA8R8G8B8(int r, int g, int b)
{
	g_ddraw.m_Color = r<<16 | g<<8 | b;
}

static void DDGetPixelA8R8G8B8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[2];
	*g = pointer[1];
	*b = pointer[0];
}

static void DDSetColorB8G8R8A8(int r, int g, int b)
{
	g_ddraw.m_Color = b<<24 | g<<16 | r<<8;
}


static void DDGetPixelB8G8R8A8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[1];
	*g = pointer[2];
	*b = pointer[3];
}

static void DDSetColorR8G8B8A8(int r, int g, int b)
{
	g_ddraw.m_Color = r<<24 | g<<16 | b<<8;
}

static void DDGetPixelR8G8B8A8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[3];
	*g = pointer[2];
	*b = pointer[1];
}

static void DDSetColorB8G8R8(int r, int g, int b)
{
	g_ddraw.m_Color = b<<16 | g<<8 | r;
}

static void DDGetPixelB8G8R8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[0];
	*g = pointer[1];
	*b = pointer[2];
}

static void DDSetColorR8G8B8(int r, int g, int b)
{
	g_ddraw.m_Color = r<<16 | g<<8 | b;
}

static void DDGetPixelR8G8B8(unsigned char *pointer, int *r, int *g, int *b)
{
	*r = pointer[2];
	*g = pointer[1];
	*b = pointer[0];
}

static void DDSetColorB5G5R5(int r, int g, int b)
{
	r>>=3;
	g>>=3;
	b>>=3;
	g_ddraw.m_Color = b<<10 | g<<5 | r;
}

static void DDGetPixelB5G5R5(unsigned char *pointer, int *r, int *g, int *b)
{
	unsigned short data =*( (unsigned short *)pointer );
	*b = (data & 0x7c00)>>7;
	*g = (data & 0x03e0)>>2;
	*r = (data & 0x001f)<<3;
}

static void DDSetColorR5G5B5(int r, int g, int b)
{
	r>>=3;
	g>>=3;
	b>>=3;
	g_ddraw.m_Color = r<<10 | g<<5 | b;
}

static void DDGetPixelR5G5B5(unsigned char *pointer, int *r, int *g, int *b)
{
	unsigned short data =*( (unsigned short *)pointer );
	*r = (data & 0x7c00)>>7;
	*g = (data & 0x03e0)>>2;
	*b = (data & 0x001f)<<3;
}

static void DDSetColorB5G6R5(int r, int g, int b)
{
	r>>=3;
	g>>=2;
	b>>=3;
	g_ddraw.m_Color = b<<11 | g<<5 | r;
}

static void DDGetPixelB5G6R5(unsigned char *pointer, int *r, int *g, int *b)
{
	unsigned short data = *( (unsigned short *)pointer );
	*b = (data & 0xf800)>>8;
	*g = (data & 0x07e0)>>3;
	*r = (data & 0x001f)<<3;
}

static void DDSetColorR5G6B5(int r, int g, int b)
{
	r>>=3;
	g>>=2;
	b>>=3;
	g_ddraw.m_Color = r<<11 | g<<5 | b;
}

static void DDGetPixelR5G6B5(unsigned char *pointer, int *r, int *g, int *b)
{
	unsigned short data = *( (unsigned short *)pointer );
	*r = (data & 0xf800)>>8;		
	*g = (data & 0x07e0)>>3;
	*b = (data & 0x001f)<<3;
}

static void DDSetColor256(int r, int g, int b)
{
	g_ddraw.m_Color = (b&0xC0) | ((g>>2)&0x38) | (r>>5);
}

static void DDGetPixel256(unsigned char *pointer, int *r, int *g, int *b)
{
	DDGetPalette(*pointer, r,g,b);
}
