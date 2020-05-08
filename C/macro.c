#include <stdio.h>
#define MERGE(A, B) A##B

int main()
{
    int year = MERGE(19, 70);
    printf("%d\n", year);
    return 0;
}
