 
#include <stdio.h>

long long sum3( unsigned int k1, unsigned int k2, unsigned int k3 )
{
		return k1+k2+k3;
}

long long sum3a( unsigned int k1, unsigned int k2, unsigned int k3  );

void main( void )
{
 int i;

 for( i = 0; i <= 50; i++ )
   printf( "FibC( %2d ) = %ld FibA = %ld\n", i, sum3( i,i,i ), sum3a( i,i,i ) );
}
