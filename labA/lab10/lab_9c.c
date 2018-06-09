//---------------------------------------------------------------
// Program lab_9c - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -no-pie -o lab_9c lab_9c.c lab_9c.s -lm
// To run:          ./lab_9c
//
//--------------------------------------------------------------- 

#include <stdio.h>
#include <sys/time.h>
#include <math.h>

#define BASE			10.0
#define LOG_OF_ITERATIONS	8


double fun_a( long long int iter );		// function in lab_9c.s
double fun_b( long long int iter );		// function in lab_9c.s

//--------------------------------------------------------------- 
double fun_cf1( long long int iter )
{
	float sum = 0.0;
	float denominator = 1.0;
	float numerator = 4.0;
	float temp;
	long long int counter = 0;

	while (counter < iter ) {
		temp = numerator;
		temp /= denominator;
		sum += temp;
		denominator += 2;
		numerator = -numerator;
		
		counter++;
	}
	return sum;
}
//--------------------------------------------------------------- 
double fun_cf2( long long int iter )
{
	float sum1 = 0.0, sum2 = 0.0;
	float denominator = 1.0;
	float numerator = 4.0;
	float temp;
	long long int counter = 0;

	while (counter < iter ) {
		temp = numerator;
		temp /= denominator;
		sum1 += temp;
		denominator += 2;
		numerator = -numerator;
		temp = numerator;
		temp /= denominator;
		sum2 += temp;
		denominator += 2;
		numerator = -numerator;

		counter+=2;
	}
	return sum1+sum2;
}
//--------------------------------------------------------------- 
double fun_cd1( long long int iter )
{
	double sum = 0.0;
	double denominator = 1.0;
	double numerator = 4.0;
	double temp;
	long long int counter = 0;

	while (counter < iter ) {
		temp = numerator;
		temp /= denominator;
		sum += temp;
		denominator += 2;
		numerator = -numerator;
		
		counter++;
	}
	return sum;
}
//--------------------------------------------------------------- 
double fun_cd2( long long int iter )
{
	double sum1 = 0.0, sum2 = 0.0;
	double denominator = 1.0;
	double numerator = 4.0;
	double temp;
	long long int counter = 0;

	while (counter < iter ) {
		temp = numerator;
		temp /= denominator;
		sum1 += temp;
		denominator += 2;
		numerator = -numerator;
		temp = numerator;
		temp /= denominator;
		sum2 += temp;
		denominator += 2;
		numerator = -numerator;

		counter+=2;
	}
	return sum1+sum2;
}
//--------------------------------------------------------------- 
int main()
{
	long long int iterations;
	int i;
	struct timeval t1, t2;
	double	elapsed;

	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[CD1]  %12lld iterations - value = %19.17lf\n", iterations, fun_cd1( iterations ) );
	
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[CD2]  %12lld iterations - value = %19.17lf\n", iterations, fun_cd2( iterations ) );
	
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[CF1]  %12lld iterations - value = %19.17lf\n", iterations, fun_cf1( iterations ) );
	
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[CF2]  %12lld iterations - value = %19.17lf\n", iterations, fun_cf2( iterations ) );
	
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[ASM]  %12lld iterations - value = %19.17lf\n", iterations, fun_a( iterations ) );
		
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	gettimeofday( &t1, NULL );
	for( i = 1; i <= LOG_OF_ITERATIONS; i++ )
	{
		iterations = pow( BASE, i );
		printf("[ASM2] %12lld iterations - value = %19.17lf\n", iterations, fun_b( iterations ) );
		
	}
	gettimeofday( &t2, NULL );
	elapsed = ( t2.tv_sec - t1.tv_sec ) * 1000.0 + ( t2.tv_usec - t1.tv_usec ) / 1000.0;
	printf( "Time = %10.4lf ms\n", elapsed );
	//------------------------------------------------------------------------------------
	return 0;
}

