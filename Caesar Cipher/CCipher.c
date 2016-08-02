
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// C code for the cipher algorithm

int cipher(char* sentence, int length, int rot){
int i;
for (i=0; i<length; i++{
  if ( isalpha(sentence[i]) ){
  if ( sentence[i] < 'm' || sentence[i] < 'M' ) 
    sentence[i] = sentence[i] + rot;
  else{ 
    sentence[i] = sentence[i] - rot;
  }
  printf ("%c", sentence[i]);
}
  printf("\n");
}

