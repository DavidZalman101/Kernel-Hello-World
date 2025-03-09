/*
* kernel.c
*/

void kmain(void) {
	const char *str = "Kernel, Hello World!";
	char *vidptr = (char*)0xb8000; // video mem begins here
	unsigned int i = 0;
	unsigned int j = 0;

	/* this loops clears the screen
	* there are 25 lines each of 80 columns; each element takes 2 byes */
	while (j < 80 * 25 * 2) {
		/* blank character */
		vidptr[j] = ' ';
		/* attribute-byte - green on black screen */
		vidptr[j + 1] = 0x02;
		j = j + 2;
	}

	j = 0;

	/* this loops writes the string to video memory */
	while (str[j] != '\0') {
		/* the character's ascii */
		vidptr[i] = str[j];
		/* attribute-byte: give character black bg and green fg */
		vidptr[i + 1] = 0x02;
		j++;
		i += 2;
	}

	return;
}
