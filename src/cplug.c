#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <math.h>

int main(void){
	
	char msg[256] = {0};
	int ret = system("./tcc/tcc -L ./tcc/ -I ./tcc/ ./tcc/test.c -o tcc/a.out");

	printf("Return value of tcc: %d\n", ret);
	FILE* buf = popen("./tcc/a.out", "r");
	
	if( fgets (msg, 256, buf)!=NULL ) {
      puts(msg);
	}
	ret = pclose(buf);
	printf("Return value a.out: %d\n", ret);


	void* handle = dlopen("./test.so", RTLD_LAZY | RTLD_LOCAL);
	if(handle == NULL){
		fprintf(stderr, "Handle is NULL.\n");
	}

	double (*test)(void) = dlsym(handle, "test");
	if(test == NULL){
		fprintf(stderr, "test fptr is NULL.\n");
		return EXIT_FAILURE;
	}

	printf("Test result: %f", test() );
	
	dlclose(handle);

	return EXIT_SUCCESS;
}
