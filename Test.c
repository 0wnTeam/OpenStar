#include <stdio.h>
%hook int puts (const char* c) { // remember to put the damned space between "puts" and "(const char* c)" !1!!!1!!1!!
	puts("[StarX] Hooked.");
	puts(c);
}
%ctor
{
	puts("Hey. This is OpenStar!");
}
