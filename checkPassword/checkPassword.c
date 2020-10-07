#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char encPassword[] = "vF34j4q6";

int main(int argc, char* argv[]){
  int enc[8] = {0xffffffff, 0x1, 0x2, 0x3, 0x6, 0x4, 0x3, 0x3};  // enc: rbp-0x40

  if(argc>1){
    char* input = argv[1];  // input: rbp-0x48
    if(strlen(input) == strlen(encPassword)){
      // Encode input
      int i;  // i: rbp-0x4c
      for(i=0;i<8;i++){
        *(input+i) = *(input+i)+enc[i];
      }
      if(!strcmp(encPassword, input)){
        puts("Correct password! >>> You logged in!\n");

      }else{
        puts("Wrong password.\n");
        exit(1);
      }
      return 0;
    }
  }
  printf("Usage: %s password (%ld chars)\n", argv[0], strlen(encPassword));
  exit(2);
}
