#include<stdlib.h>
#include<stdio.h>

struct Person
{
    char* name;
    char* famliy_name;
    char** born_at;
    void (*say)(char* name);
};

struct Dimension
{
    int x;
    int y;
};

typedef struct Person Person;

typedef struct Dimension Dimension;

void talk(char* name) 
{
    printf("%s\n", name);
}

int main()
{
    Person p1;
    p1.name         = "Sigmund";
    p1.famliy_name  = "Freud";
    p1.say = talk;
    p1.born_at = (char**) malloc(2 * sizeof(char*));
    p1.born_at[0] = "Pribor";
    p1.born_at[1] = "Czechia";
    p1.say(p1.born_at[1]);
    Dimension d1 = 
    {
        .x = 3,
        .y = 4,
    };
    printf("x = %d, y = %d\n", d1.x, d1.y);
    return 0;
}
