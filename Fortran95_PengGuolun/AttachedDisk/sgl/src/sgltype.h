typedef struct __sglDevice
{
	int Width;
	int Height;
	int ColorBits;
	int PixelMode;
	int DoubleBuffer;
	int StartTime;
	int EnableReshape;
	int FullScreen;
	int EnableColorKey;
	float vLeft, vTop, vRight, vBottom;
	float vWidth, vHeight;
} sglDevice;