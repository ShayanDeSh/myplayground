#include<stdlib.h>
#include<stdio.h>

struct Person
{
    char* name;
    char* famliy_name;
    char** born_at;
    void (*say)(char* name);
};

typedef struct Person Person;

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
    return 0;
}
