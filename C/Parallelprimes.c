#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h> 
#include<sys/wait.h>

void prime(int t){
    int pr;
    read(t, &pr, sizeof pr);
    if (pr) {
        printf("%d  %d\n", pr ,getpid());
    }
    
    int p[2];
    pipe(p);
    int pid  = 1;
    pid = fork();
    if (pr) {
        if (pid == 0) 
        {
            close(p[1]);
            prime(p[0]);
        }
        close(p[0]); 
        if(pid) {
            int got;
            while (read(t, &got, sizeof got)){
                // printf("%d  %d\n", got, getpid());
                if (!got) {
                    break;
                } else if (got % pr) {
                    // if (getpid() == 5) {           
                    //     printf("%d  %d\n", got, getpid());
                    // }
                    write(p[1], &got, sizeof got);
                } 
            } 
            // printf("finished\n");
            close(p[1]);
            wait(0);
        }
    } else {
        close(p[1]);
        wait(0);
    }
    
}

int main(int argc, char *argv) {

    int p[2];
    pipe(p);
    int pid = fork();
        if (pid == 0) {
            close(p[1]);
            prime(p[0]);
        } 
        close(p[0]);
        if(pid) {
        int i = 2;
        for (i = 3; i < 1000; i++) {
            if (i % 2 != 0) {
				write(p[1], &i, sizeof i);
			}
        }
        close(p[1]);
        wait(0);
    }
    exit(0);
}
