#include <stdio.h>

void goodbye(char **s) {
  printf("Goodbye %s!\n", *s);
}

void say() {
    printf("foo\n");
}

int main(int argc, char *argv[]) {
  char *name __attribute__((cleanup(goodbye)));
  name = argc > 1 ? argv[1] : "World";
  printf("Hello %s!\n", name);
  say();
  return 0;
}
