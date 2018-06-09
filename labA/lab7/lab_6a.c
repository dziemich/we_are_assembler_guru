//---------------------------------------------------------------
// Program lab_6a - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_6a lab_6a.c lab_6a_asm.s
// To run:          ./lab_6a
//
//---------------------------------------------------------------

#include <stdio.h>

long long factc( unsigned int k )
{
	if( k <= 1 )
		return 1;
	else
		return k * factc( k - 1 );
}

long long facta( unsigned int k ); // wywolanie funkcji z assemblera

void main( void )
{
 int i;

 for( i = 1; i <= 50; i++ )
   printf( "FactC(%d) = %ld FactA = %ld\n", i, factc(i), facta(i) );
}
