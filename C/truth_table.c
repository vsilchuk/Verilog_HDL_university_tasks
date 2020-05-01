// A simple program for generating truth tables.

#include <stdio.h>

int main()
{	
	int A[] = {0, 0, 0, 0, 1, 1, 1, 1};
	int B[] = {0, 0, 1, 1, 0, 0, 1, 1};
	int C[] = {0, 1, 0, 1, 0, 1, 0, 1};
	
	int i = 0, Y = 0;
	
	printf("F = A*B V A*~B*~C V ~A*B*C\n\n");
	printf("A\tB\tC\tY\n");
	
	for(i = 0; i < 8; i++)
	{
		// Y = (A[i] & B[i]) | (!(A[i]) & !(B[i]) & C[i]);	// LW2, task 1
		// Y = ((A[i] & B[i]) | (A[i] & !(B[i]) & !(C[i])) | (!(A[i]) & B[i] & C[i]));
		// Y = ((!(A[i]) & !(C[i])) | (!(A[i]) & B[i]) | (A[i] & !(B[i]) & C[i]));
		
		Y = ((!A[i] | B[i] | C[i]) & (A[i] | C[i]) & (!B[i] & C[i]));
		
		printf("%d\t%d\t%d\t%d\n", A[i], B[i], C[i], Y);	
	}
	
	return 0;
}


	
