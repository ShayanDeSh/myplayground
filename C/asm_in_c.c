#include "stdio.h"

void main() 
{
    int x = 1;
    int y = 2;

    asm ("mov %0, %1"
            : "=r" (y)
            : "r" (x)
            );

    printf("y = %d, x = %d \n", y, x);

    asm ("leal (%1, %1, 4), %0"
            : "=r" (y)
            : "r" (x)
        );

    printf("y = %d, x = %d \n", y, x);


}
