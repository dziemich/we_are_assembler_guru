 
#include <stdio.h>

long long minc( int k, int l, int m)
{
	long long fold = 0;
	long long fnew = 1;
	long long sum;

	if( k > l ) {
		if ( m < l) {
			return m;		
		} else {
			return l;
		}
	} else {
		if (k<m) {
			return k;
		} else {
			return m;
		}
	}
}

long long mina( long k, long l, long m);


void main( void )
{
 int i;

 for( i = 0; i <= 50; i++ )
   printf( "Fib( %2d ) = %ld FibA= %ld\n", i, fibc( i ), fiba( i ) );
}
