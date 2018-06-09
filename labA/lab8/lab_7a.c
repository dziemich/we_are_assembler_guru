//---------------------------------------------------------------
// Program lab_7a - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_7a lab_7a.c lab_7a_asm.s
// To run:          ./lab_7a
//
//---------------------------------------------------------------

#include <stdio.h>

long long int factc( unsigned int k )
{
	long long result = 1;
	while( k > 1 )
	   result *= k--;
	return result;			
}

long long int facta( unsigned int k );

void main( void )
{
 int i;

 for( i = 1; i <= 30; i++ )
   printf( "Fact(%d) = %ld FactA = %ld\n", i, factc(i), facta(i) );
}
