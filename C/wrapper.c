#include <stdlib.h>
#include <stdio.h>

// gcc wrapper.c -Wl,--wrap=free -Wl,--wrap=malloc

extern void * __real_malloc(size_t);
extern void __real_free(void *);

void * __wrap_malloc(size_t c) {
    printf("malloc called with %lu\n", c);
    return __real_malloc(c);
}

void __wrap_free(void *ptr) {
    printf("calling the free function ...\n");
    return __real_free(ptr);
}

int main(void) {
    void *p = malloc(42);
    if(p) free(p);
    char *x;
    return 0;
}
