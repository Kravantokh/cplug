#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "libtcc.h"
#include "base"

void tcc_err(void* opaque, const char* msg){
	fprintf(stderr, "%s\n", msg);
}

int main(void){
	printf("Creating compiler instance.\n");
	TCCState* compiler = tcc_new();
	
	tcc_set_error_func(compiler, NULL, &tcc_err);
	tcc_set_output_type(compiler, TCC_OUTPUT_DLL);
	tcc_add_include_path(compiler, "./plugin_api");
	tcc_add_library_path(compiler, "./lib/tinycc");
	//tcc_add_library_path(compiler, "/usr/lib/");
	tcc_add_file(compiler, "./test.c");
	tcc_output_file(compiler, "./test.so");

	tcc_set_options(compiler, "-shared -o test.so test.c");
	tcc_run(compiler, 0, NULL);
	
	tcc_delete(compiler);

	void* handle = dlopen("./test.so", RTLD_LAZY | RTLD_LOCAL);
	if(handle == NULL){
		fprintf(stderr, "Handle is NULL.\n");
	}

	int (*test)(void) = dlsym(handle, "test");
	if(test == NULL){
		fprintf(stderr, "test fptr is NULL.\n");
	}

	printf("Test result: %d", test() );




	return EXIT_SUCCESS;
}
