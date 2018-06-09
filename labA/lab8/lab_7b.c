//---------------------------------------------------------------
// Program lab_7b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_7b lab_7b.c lab_7b_asm.s
// To run:          ./lab_7b
//
//---------------------------------------------------------------

#include <stdio.h>

long long fibc( unsigned int k )
{
	long long fold = 0;
	long long fnew = 1;
	long long sum;

	if( k == 0 ) return fold;
	else if( k == 1 ) return fnew;
	else
	{
		do {
			sum = fold + fnew;
			fold = fnew;
			fnew =  sum;
			k--;
		}
		while( k > 1 );
		return sum;
	}
}

long long fiba( unsigned int k );


void main( void )
{
 int i;

 for( i = 0; i <= 50; i++ )
   printf( "Fib( %2d ) = %ld FibA= %ld\n", i, fibc( i ), fiba( i ) );
}
