
#include <stdio.h>
#include <string.h>

char encPassword[8] = {'h','q','1','1','n','f','-','_'};

int main(int argc, char* argv[]){
        int enc[8] = {0xffffffff, 0x1,0x2,0x3,0x6,0x4,0x3,0x3};

        if( argc == 1){
                printf("Usage: %s password %ld\n", argv[0], strlen(encPassword));
        }else{
                size_t len = strlen(argv[1]);
                if(len==strlen(encPassword)){
                        int i = 0;
                        for(i = 0; i<=7; i++){
                                encPassword[i] = encPassword[i] + enc[i];
                        }
                        if(!strcmp(*(argv+1), encPassword)){
                                printf("Correct password! >>> You logged in! <<<\n");
                        }else{
                                printf("Wrong password\n");
                        }
                }
        }
        return 0;
}