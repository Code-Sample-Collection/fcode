
char *MakeCString(char *str, unsigned int len)
{
	static char buffer[256];
	unsigned int i;
	for ( i=0; i<len; i++ ) buffer[i]=*str++;
	buffer[i]='\0';
	return buffer;
}

float sglsin(float num)
{
	__asm
	{
		fld num;
		fsin;
	};
}

float sglcos(float num)
{
	__asm
	{
		fld num;
		fcos;
	};
}