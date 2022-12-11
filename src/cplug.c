#include <stdio.h>
#include <stdlib.h>
#include "libtcc.h"
#include "base"

void tcc_err(void* opaque, const char* msg){
	fprintf(stderr, "%s\n", msg);
}

int main(void){
	printf("Creating compiler instance.\n");
	TCCState* compiler = tcc_new();
	
	tcc_set_error_func(compiler, NULL, &tcc_err);
	//tcc_add_include_path(compiler, "./plugin_api");
	//tcc_add_library_path(compiler, "./lib/tinycc");

	tcc_set_options(compiler, "-shared -o test.so test.c");
	tcc_run(compiler, 0, NULL);
	
	tcc_delete(compiler);
	return EXIT_SUCCESS;
}
