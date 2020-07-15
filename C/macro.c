#include <stdio.h>

#define MERGE(A, B) A##B

#define SWAP(A, B, T) \
T SWAP = A; \
A = B; \
B = SWAP;

int main()
{
    int year = MERGE(19, 70);
    printf("%d\n", year);
    char* A = "Dennis";
    char* B = "Ritchie";
    SWAP(A, B, char*);
    printf("A = %s, B = %s \n", A, B);
    return 0;
}
