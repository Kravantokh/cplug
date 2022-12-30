#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <math.h>
#include "base"

void* alloc(unsigned int n){
	return malloc(n);
}

void print(plug_api_string str){
	printf("%s", str.contents);
}

int main(void){
	
	int ret = system("./tcc/tcc -L ./tcc/ -I ./tcc/ -shared ./tcc/test.c -o tcc/test.so");
	
	if(ret != 0){
		fprintf(stderr, "TCC did not compile sucessfully!\n");
		return EXIT_FAILURE;
	}


	void* handle = dlopen("./tcc/test.so", RTLD_LAZY | RTLD_LOCAL);
	if(handle == NULL){
		fprintf(stderr, "Handle is NULL. Could not dlopen the file given.\n");
		return EXIT_FAILURE;
	}

	void (*pre_init)(plug_api_dispatch_table) = dlsym(handle, "pre_init");

	if(pre_init == NULL){
		fprintf(stderr, "pre_init function ptr is NULL. The init function could not be found. \n");
		return EXIT_FAILURE;
	}

	pre_init( (plug_api_dispatch_table){&alloc, &print}) ;


	void (*plug_main)(void) = dlsym(handle, "main");

	if(plug_main == NULL){
		fprintf(stderr, "plug_main function ptr is NULL. The main function could not be found. \n");
		return EXIT_FAILURE; }
	plug_main();
	dlclose(handle); 

return EXIT_SUCCESS;
}
