!DEC$ objcomment lib:"dxguid.lib"
!DEC$ objcomment lib:"ddraw.lib"
!DEC$ objcomment lib:"dinput.lib"
!DEC$ objcomment lib:"winmm.lib"
!DEC$ objcomment lib:"sgl.lib"

module sgl
  implicit none
  integer, parameter :: maxstrlen = 80

  integer, parameter :: SGL_WINDOW_WIDTH = 1
  integer, parameter :: SGL_WINDOW_HEIGHT = 2
  integer, parameter :: SGL_COLORBITS = 3
  integer, parameter :: SGL_TIME = 4

  integer, parameter :: KEY_ESCAPE = 1
  integer, parameter :: KEY_1 = 2
  integer, parameter :: KEY_2 = 3
  integer, parameter :: KEY_3 = 4
  integer, parameter :: KEY_4 = 5
  integer, parameter :: KEY_5 = 6
  integer, parameter :: KEY_6 = 7
  integer, parameter :: KEY_7 = 8
  integer, parameter :: KEY_8 = 9
  integer, parameter :: KEY_9 = 10
  integer, parameter :: KEY_0 = 11
  integer, parameter :: KEY_MINUS = 12
  integer, parameter :: KEY_EQUALS = 13
  integer, parameter :: KEY_BACK = 14
  integer, parameter :: KEY_TAB = 15
  integer, parameter :: KEY_Q = 16
  integer, parameter :: KEY_W = 17
  integer, parameter :: KEY_E = 18
  integer, parameter :: KEY_R = 19
  integer, parameter :: KEY_T = 20
  integer, parameter :: KEY_Y = 21
  integer, parameter :: KEY_U = 22
  integer, parameter :: KEY_I = 23
  integer, parameter :: KEY_O = 24
  integer, parameter :: KEY_P = 25
  integer, parameter :: KEY_LBRACKET = 26
  integer, parameter :: KEY_RBRACKET = 27
  integer, parameter :: KEY_RETURN = 28
  integer, parameter :: KEY_LCONTROL = 29
  integer, parameter :: KEY_A = 30
  integer, parameter :: KEY_S = 31
  integer, parameter :: KEY_D = 32
  integer, parameter :: KEY_F = 33
  integer, parameter :: KEY_G = 34
  integer, parameter :: KEY_H = 35
  integer, parameter :: KEY_J = 36
  integer, parameter :: KEY_K = 37
  integer, parameter :: KEY_L = 38
  integer, parameter :: KEY_SEMICOLON = 39
  integer, parameter :: KEY_APOSTROPHE = 40
  integer, parameter :: KEY_GRAVE = 41
  integer, parameter :: KEY_LSHIFT = 42
  integer, parameter :: KEY_BACKSLASH = 43
  integer, parameter :: KEY_Z = 44
  integer, parameter :: KEY_X = 45
  integer, parameter :: KEY_C = 46
  integer, parameter :: KEY_V = 47
  integer, parameter :: KEY_B = 48
  integer, parameter :: KEY_N = 49
  integer, parameter :: KEY_M = 50
  integer, parameter :: KEY_COMMA = 51
  integer, parameter :: KEY_PERIOD = 52
  integer, parameter :: KEY_SLASH = 53
  integer, parameter :: KEY_RSHIFT = 54
  integer, parameter :: KEY_MULTIPLY = 55
  integer, parameter :: KEY_LMENU = 56
  integer, parameter :: KEY_SPACE = 57
  integer, parameter :: KEY_CAPITAL = 58
  integer, parameter :: KEY_F1 = 59
  integer, parameter :: KEY_F2 = 60
  integer, parameter :: KEY_F3 = 61
  integer, parameter :: KEY_F4 = 62
  integer, parameter :: KEY_F5 = 63
  integer, parameter :: KEY_F6 = 64
  integer, parameter :: KEY_F7 = 65
  integer, parameter :: KEY_F8 = 66
  integer, parameter :: KEY_F9 = 67
  integer, parameter :: KEY_F10 = 68
  integer, parameter :: KEY_NUMLOCK = 69
  integer, parameter :: KEY_SCROLL = 70
  integer, parameter :: KEY_NUMPAD7 = 71
  integer, parameter :: KEY_NUMPAD8 = 72
  integer, parameter :: KEY_NUMPAD9 = 73
  integer, parameter :: KEY_SUBTRACT = 74
  integer, parameter :: KEY_NUMPAD4 = 75
  integer, parameter :: KEY_NUMPAD5 = 76
  integer, parameter :: KEY_NUMPAD6 = 77
  integer, parameter :: KEY_ADD = 78
  integer, parameter :: KEY_NUMPAD1 = 79
  integer, parameter :: KEY_NUMPAD2 = 80
  integer, parameter :: KEY_NUMPAD3 = 81
  integer, parameter :: KEY_NUMPAD0 = 82
  integer, parameter :: KEY_DECIMAL = 83
  integer, parameter :: KEY_OEM_102 = 86
  integer, parameter :: KEY_F11 = 87
  integer, parameter :: KEY_F12 = 88
  integer, parameter :: KEY_F13 = 100
  integer, parameter :: KEY_F14 = 101
  integer, parameter :: KEY_F15 = 102
  integer, parameter :: KEY_KANA = 112
  integer, parameter :: KEY_ABNT_C1 = 115
  integer, parameter :: KEY_CONVERT = 121
  integer, parameter :: KEY_NOCONVERT = 123
  integer, parameter :: KEY_YEN = 125
  integer, parameter :: KEY_ABNT_C2 = 126
  integer, parameter :: KEY_NUMPADEQUALS = 141
  integer, parameter :: KEY_PREVTRACK = 144
  integer, parameter :: KEY_AT = 145
  integer, parameter :: KEY_COLON = 146
  integer, parameter :: KEY_UNDERLINE = 147
  integer, parameter :: KEY_KANJI = 148
  integer, parameter :: KEY_STOP = 149
  integer, parameter :: KEY_AX = 150
  integer, parameter :: KEY_UNLABELED = 151
  integer, parameter :: KEY_NEXTTRACK = 153
  integer, parameter :: KEY_NUMPADENTER = 156
  integer, parameter :: KEY_RCONTROL = 157
  integer, parameter :: KEY_MUTE = 160
  integer, parameter :: KEY_CALCULATOR = 161
  integer, parameter :: KEY_PLAYPAUSE = 162
  integer, parameter :: KEY_MEDIASTOP = 164
  integer, parameter :: KEY_VOLUMEDOWN = 174
  integer, parameter :: KEY_VOLUMEUP = 176
  integer, parameter :: KEY_WEBHOME = 178
  integer, parameter :: KEY_NUMPADCOMMA = 179
  integer, parameter :: KEY_DIVIDE = 181
  integer, parameter :: KEY_SYSRQ = 183
  integer, parameter :: KEY_RMENU = 184
  integer, parameter :: KEY_PAUSE = 197
  integer, parameter :: KEY_HOME = 199
  integer, parameter :: KEY_UP = 200
  integer, parameter :: KEY_PRIOR = 201
  integer, parameter :: KEY_LEFT = 203
  integer, parameter :: KEY_RIGHT = 205
  integer, parameter :: KEY_END = 207
  integer, parameter :: KEY_DOWN = 208
  integer, parameter :: KEY_NEXT = 209
  integer, parameter :: KEY_INSERT = 210
  integer, parameter :: KEY_DELETE = 211
  integer, parameter :: KEY_LWIN = 219
  integer, parameter :: KEY_RWIN = 220
  integer, parameter :: KEY_APPS = 221
  integer, parameter :: KEY_POWER = 222
  integer, parameter :: KEY_SLEEP = 223
  integer, parameter :: KEY_WAKE = 227
  integer, parameter :: KEY_WEBSEARCH = 229
  integer, parameter :: KEY_WEBFAVORITES = 230
  integer, parameter :: KEY_WEBREFRESH = 231
  integer, parameter :: KEY_WEBSTOP = 232
  integer, parameter :: KEY_WEBFORWARD = 233
  integer, parameter :: KEY_WEBBACK = 234
  integer, parameter :: KEY_MYCOMPUTER = 235
  integer, parameter :: KEY_MAIL = 236
  integer, parameter :: KEY_MEDIASELECT = 237

  
  interface
  subroutine sglCreateWindow(x, y, width, height, doublebuffer)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglCreateWindow' :: sglCreateWindow
    integer x,y,width,height,doublebuffer
  end subroutine
  subroutine sglFullScreen(x, y, bpps, doublebuffer)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFullScreen' :: sglFullScreen
    integer x,y,bpps,doublebuffer
  end subroutine
  
  subroutine sglSetVirtual(left,top,right,bottom)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglSetVirtual' :: sglSetVirtual
    real left,top,right,bottom
  end subroutine

  subroutine sglSetPalette(index, r, g, b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglSetPalette' :: sglSetPalette
    integer index, r, g, b
  end subroutine
  subroutine sglGetPalette(index, r, g, b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglSetPalette' :: sglSetPalette
    integer index
	integer r, g, b
  !DEC$ ATTRIBUTES REFERENCE :: r,g,b
  end subroutine
  subroutine sglUpdatePalette()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglUpdatePalette' :: sglUpdatePalette
  end subroutine
  subroutine sglDefaultPalette()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglDefaultPalette' :: sglDefaultPalette
  end subroutine

  subroutine sglShowFPS(show)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglShowFPS' :: sglShowFPS
    integer show
  end subroutine
  subroutine sglShowCursor(show)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglShowCursor' :: sglShowCursor
    integer show
  end subroutine
  subroutine sglSetTitle(str)
  !DEC$ ATTRIBUTES C, REFERENCE, ALIAS:'_fsglSetTitle' :: sglSetTitle
    character(len=*) :: str
  end subroutine
  
  subroutine sglUseFont(str, w, h)
  !DEC$ ATTRIBUTES C, REFERENCE, ALIAS:'_fsglUseFont' :: sglUseFont
    character(len=*) :: str
	integer :: w, h
  end subroutine
  subroutine sglEnableReshape(b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglEnableReshape' :: sglEnableReshape
  integer b
  end subroutine
  subroutine sglMainLoop()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglMainLoop' :: sglMainLoop
  end subroutine
  subroutine sglDisplaySub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglDisplaySub' :: sglDisplaySub
  external sub
  end subroutine
  subroutine sglReshapeSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglReshapeSub' :: sglReshapeSub
  external sub
  end subroutine
  subroutine sglIdleSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglIdleSub' :: sglIdleSub
  external sub
  end subroutine
  subroutine sglEnd()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglEnd' :: sglEnd
  end subroutine
  subroutine sglCaptureKeyboard()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglCaptureKeyboard' :: sglCaptureKeyboard
  end subroutine
  subroutine sglReleaseKeyboard()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglReleaseKeyboard' :: sglReleaseKeyboard
  end subroutine
  subroutine sglReadKeyboard()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglReadKeyboard' :: sglReadKeyboard
  end subroutine
  logical(4) function sglKeyPressed(key)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglKeyPressed' :: sglKeyPressed
  integer key
  end function
  integer(4) function sglGetInfo(index)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglGetInfo' :: sglGetInfo
  integer index
  end function

  subroutine sglTimerSub(time,sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglTimerSub' :: sglTimerSub
  integer time
  external sub
  end subroutine

  subroutine sglKeyDownSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglKeyDownSub' :: sglKeyDownSub
  external sub
  end subroutine

  subroutine sglKeyUpSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglKeyUpSub' :: sglKeyUpSub
  external sub
  end subroutine

  subroutine sglGetCharSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglGetCharSub' :: sglGetCharSub
  external sub
  end subroutine
  
  subroutine sglMouseMoveSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglMouseMoveSub' :: sglMouseMoveSub
  external sub
  end subroutine

  subroutine sglMouseDownSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglMouseDownSub' :: sglMouseDownSub
  external sub
  end subroutine

  subroutine sglMouseUpSub(sub)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglMouseUpSub' :: sglMouseUpSub
  external sub
  end subroutine

  subroutine sglColor3f(r,g,b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglColor3f' :: sglColor3f
  real r,g,b
  end subroutine
  subroutine sglColor3i(r,g,b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglColor3i' :: sglColor3i
  integer :: r,g,b
  end subroutine
  subroutine sglColor(color)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglColor' :: sglColor
  integer :: color
  end subroutine
  
  subroutine sglClearColor3f(r,g,b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglClearColor3f' :: sglClearColor3f
  real r,g,b
  end subroutine
  subroutine sglClearColor3i(r,g,b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglClearColor3i' :: sglClearColor3i
  integer r,g,b
  end subroutine
  subroutine sglClearColor(color)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglClearColor' :: sglClearColor
  integer color
  end subroutine

  subroutine sglClearBuffer()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglClearBuffer' :: sglClearBuffer
  end subroutine
  subroutine sglUpdateBuffer()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglUpdateBuffer' :: sglUpdateBuffer
  end subroutine
  subroutine sglPixel(x,y)    
  !DEC$ ATTRIBUTES C, ALIAS:'_sglPixel' :: sglPixel
  integer x,y
  end subroutine
  subroutine sglPixelV(x,y)    
  !DEC$ ATTRIBUTES C, ALIAS:'_sglPixelV' :: sglPixelV
  real x,y
  end subroutine
  subroutine sglLine(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglLine' :: sglLine
  integer x0,y0,x1,y1
  end subroutine
  subroutine sglLineV(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglLineV' :: sglLineV
  real x0,y0,x1,y1
  end subroutine
  subroutine sglRect(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglRect' :: sglRect
  integer x0,y0,x1,y1
  end subroutine
  subroutine sglRectV(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglRectV' :: sglRectV
  real x0,y0,x1,y1
  end subroutine
  subroutine sglFilledRect(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledRect' :: sglFilledRect
  integer x0,y0,x1,y1
  end subroutine
  subroutine sglFilledRectV(x0,y0,x1,y1)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledRectV' :: sglFilledRectV
  real x0,y0,x1,y1
  end subroutine
  subroutine sglCircle(cx,cy,r)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglCircle' :: sglCircle
  integer cx, cy, r
  end subroutine
  subroutine sglCircleV(cx,cy,r)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglCircleV' :: sglCircleV
  real cx, cy, r
  end subroutine
  subroutine sglFilledCircle(cx,cy,r)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledCircle' :: sglFilledCircle
  integer cx, cy, r
  end subroutine
  subroutine sglFilledCircleV(cx,cy,r)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledCircleV' :: sglFilledCircleV
  real cx, cy, r
  end subroutine
  subroutine sglEllipse(cx,cy,rx,ry)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglEllipse' :: sglEllipse
  integer cx, cy, rx, ry
  end subroutine
  subroutine sglEllipseV(cx,cy,rx,ry)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglEllipseV' :: sglEllipseV
  real cx, cy, rx, ry
  end subroutine
  subroutine sglFilledEllipse(cx,cy,rx,ry)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledEllipse' :: sglFilledEllipse
  integer cx, cy, rx, ry
  end subroutine
  subroutine sglFilledEllipseV(cx,cy,rx,ry)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFilledEllipseV' :: sglFilledEllipseV
  real cx, cy, rx, ry
  end subroutine
  subroutine sglArc(cx,cy,r,as,ae)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglArc' :: sglArc
  integer cx, cy, r
  real as, ae
  end subroutine
  subroutine sglArcV(cx,cy,r,as,ae)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglArcV' :: sglArcV
  real cx, cy, r
  real as, ae
  end subroutine
  subroutine sglFan(cx,cy,r,as,ae)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFan' :: sglFan
  integer cx,cy,r
  real as,ae
  end subroutine
  subroutine sglFanV(cx,cy,r,as,ae)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglFanV' :: sglFanV
  real cx,cy,r
  real as,ae
  end subroutine
  subroutine sglTextOut(x,y,str)
  !DEC$ ATTRIBUTES C,REFERENCE, ALIAS:'_fsglTextOut' :: sglTextOut
  integer x,y
  character*(*) str
  end subroutine
  subroutine sglGetBuffer(buffer,x,y,width,height)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglGetBuffer' :: sglGetBuffer
  integer(1) :: buffer(*)
  !DEC$ ATTRIBUTES REFERENCE :: buffer
  integer :: x,y,width,height
  end subroutine
  subroutine sglPutBuffer(buffer,x,y,width,height)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglPutBuffer' :: sglPutBuffer
  integer(1) :: buffer(*)
  !DEC$ ATTRIBUTES REFERENCE :: buffer
  integer :: x,y,width,height
  end subroutine
  subroutine sglGetRGBBuffer(buffer,x,y,width,height)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglGetRGBBuffer' :: sglGetRGBBuffer
  integer(1) :: buffer(*)
  !DEC$ ATTRIBUTES REFERENCE :: buffer
  integer :: x,y,width,height
  end subroutine
  subroutine sglPutRGBBuffer(buffer,x,y,width,height)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglPutRGBBuffer' :: sglPutRGBBuffer
  integer(1) :: buffer(*)
  integer :: x,y,width,height
  end subroutine
  subroutine sglEnableColorKey()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglEnableColorKey' :: sglEnableColorKey
  end subroutine	
  subroutine sglDisableColorKey()
  !DEC$ ATTRIBUTES C, ALIAS:'_sglDisableColorKey' :: sglDisableColorKey
  end subroutine	
  subroutine sglColorKey3i(r,g,b)
  !DEC$ ATTRIBUTES C, ALIAS:'_sglColorKey3i' :: sglColorKey3i
  integer r,g,b
  end subroutine	
  end interface

end module sgl