#ifndef _DDRAW_H_
#define _DDRAW_H_

#include <ddraw.h>
#include <dinput.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct __BufferInfo
{
	LPDIRECTDRAWSURFACE7 surface;
	RECT                 rect;
	int					 BytesPerPixel;
	int					 width, height;
	int					 Pitch;
	int					 pointeroffset;
	unsigned char        *pointer;
} BufferInfo;

typedef struct __CDDraw {
    HWND					m_hwnd;
    LPDIRECTDRAW7			m_pDDraw;
	LPDIRECTDRAWCLIPPER		m_pClipper;
	LPDIRECTDRAWPALETTE     m_pPalette;

	LPDIRECTINPUT7          m_pDI;         
	LPDIRECTINPUTDEVICE7    m_pKeyboard;     

	BufferInfo				m_FrontBuffer, m_BackBuffer;
	BufferInfo				*m_pTargetBuffer;
	int						m_iSelectBuffer;
	int						m_iPixelMode;
	unsigned int			m_ClearColor;
	unsigned int			m_Color;
	unsigned int			m_ColorKey;
	int						m_nFrameCount;
	int						m_iTextRed, m_iTextGreen, m_iTextBlue;
	BOOL 					m_bShowFPS;
	BOOL					m_bInitized;
	BOOL					m_bDoubleBuffer;
	int						fpsX, fpsY;
} CDDraw;

BOOL DDWindow( HWND hWnd, int doublebuffer);
BOOL DDFullScreen( HWND hWnd, int w, int h, int b, int doublebuffer);
void DDSelectBuffer(int target);
BOOL DDCreateBackSurface( int w, int h, BufferInfo *bi);
BOOL DDReadKeyboard(void);
BOOL DDKeyPressed(int index);
BOOL DDInputInit(void);
void DDInputRelease(void);


extern void (*DDSetColor)(int r, int g, int b);
extern void (*DDPutPixel)(int x, int y);
void DDGetPixel(int x, int y, int *r, int *g, int *b);
void DDTextColor(int r, int g, int b);
void DDColor(int color);
void DDColor3i(int r, int g, int b);
void DDColorKey3i(int r,int g,int b);
void DDColorKey(int color);
void DDBGColor3i(int r, int g, int b);
void DDBGColor(int color);
void DDShowFPS(int flag);

void DDhline(int x, int y, int xext);
void DDvline(int x, int y, int yext);
void DDDrawFilledRect( int x0, int y0, int x1, int y1 );
void DDSetPalette(int index, int r, int g, int b);
void DDGetPalette(int index, int *r, int *g, int *b);
void DDUpdatePalette(void);

void DDTextOut(int x, int y, char *string);
void DDUseFont(char *name, int width, int height);
void DDGetBuffer(void *buffer, int x, int y, int width, int height);
void DDPutBuffer(void *buffer, int x, int y, int width, int height);
void DDGetRGBBuffer(void *buffer, int x, int y, int width, int height);
void DDPutRGBBuffer(void *buffer, int x, int y, int width, int height);

int  DDStartDraw( void );
int  DDEndDraw( void );
void DDRelease( void );
void DDRestore( void );
int  DDClearTargetSurface( void );
int  DDBlitToFrontSurface( void );
void DDDrawFPS( void );
void DDOnMove( void );
void DDOnSize( void );

BOOL DDReady(void);
#ifdef __cplusplus
}
#endif

#endif