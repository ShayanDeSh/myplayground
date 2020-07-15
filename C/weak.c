#include <stdio.h>
extern void foo(void); 

void foo(void) {
  printf("I'm overriding foo!\n");
}

void __f() {
    printf("Called by alias\n");
}

void f() __attribute__((weak, alias("__f")));

int main() {
    foo(); // I'm overriding foo!
    f();
}
