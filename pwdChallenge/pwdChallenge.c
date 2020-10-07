#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* buffer1;
char buffer2[16];

void die(char* a){	// a: rbp-0x8
	printf("Error: %s\n", a);
	fflush(stdout);
	free(buffer1);
	exit(1);
}

void readPwd(){
	buffer1 = (char*) malloc(sizeof(char)*16);
	FILE* fp;

	fp = fopen("pwd.txt","r");	// fp: rbp-0x8

	if(!fp){
		die("cannot open password file");
	}else{
		int i;
		int c = 0;								// c: rbp-0xd
		for(i=0;i<15 && c != 0xff;i++){			// i: rbp-0xc
			c = fgetc(fp);
			buffer1[i] = c;
		}
		buffer1[i] = '\0';
		// fclose(fp);
	}
}

void askPwd(){
	printf("Insert password: ");
	fflush(stdout);
	memset(buffer2, 0, 16);	// memset(buffer2, esi, edx)
	char c = getchar();
	int i = 0; 				// i = rbp-0x4
	for(i=0;i<16 && c != 0xff && c!='\n';i++){
		if(c!='\n'){
			buffer2[i] = c;
		}
		c = getchar();	// c = rbp - 0x5
	}
	fflush(stdout);
}

int main(){
	readPwd();
	askPwd();
	if(!strncmp(buffer1, buffer2, 0xf)){
		puts("Authenticated!");
		fflush(stdout);
		free(buffer1);
	}else{
		if(strlen(buffer1)!=strlen(buffer2)){
			printf("Password should be %ld chars", strlen(buffer1));
		}
		die("Wrong password");
	}
	return 0;
}
