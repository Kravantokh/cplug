#include "base"
BEGIN
void main(void){
	char* str = call.alloc(7);
	str[0] = 'H';
	str[1] = 'e';
	str[2] = 'l';
	str[3] = 'l';
	str[4] = 'o';
	str[5] = '!';
	str[6] = '\0';

	call.print((string){str, 0});
	
}
