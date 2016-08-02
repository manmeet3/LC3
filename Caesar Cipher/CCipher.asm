; Manmeet Singh - msingh11@ucsc.edu
; Lab 7B	- Encryption and Decryption
; Tu/Thu 6-8pm TA: Steve
	.ORIG x3000

ARRAY2	.BLKW	200
DIGIT	.FILL	#0

fromtop
lea	r0, HELLO
	puts

backtop
lea	r0, EORD	; prompt to input d	e	x
	puts
	getc
	out
ld	r4, X
add 	r4, r0, r4
BRz	quit		; quit if x entered

add	r6, r0, #0	; save entered value in R6 for future

lea	r0, CPRPT	; prompt for cipher value
	puts
input
	getc
	out
add	r1, r0, #-10	; Add -10 for LF and exit when enter
BRz	getstring
st	r0, DIGIT
ld	r2, DIGIT
ld	r3, FE		; FE = -48
add	r2, r3, r2	; char - 48
st	r2, DIGIT	; char - 48 = digit
ld	r5, TENLOOP	
and 	r4, r4, #0

intlp:			; does cipher X 10
ld	r1, CIPHER	; to shift positions
add	r4, r1, r4
add	r5, r5, #-1
BRp	intlp

ld	r2, DIGIT	; add digit+cipher
add	r1, r2, r4
st	r1, CIPHER	; store cipher value into a var
BR	input


checkopt
st	r7, R7ADR
add	r5, r5, r6
BRz	decrypt		; Branch decrypt
BRp	encrypt		; Branch encrypt

getstring
lea	r4, ARRAY1
lea	r3, ARRAY2
lea	r2, ARRAY2
lea	r0, STRP
	puts
stringin
	getc
	out
add	r5, r0, #-10
BRz	addnull

str	r0, r4, #0	; Save to array 1 - COUNTER R4
add	r4, r4, #1	; increment pointer
JSR	checkopt
BR	stringin

encrypt

add	r3, r3, #1
ld	r7 R7ADR
	RET
decrypt

add	r3, r3, #1
ld	r7 R7ADR
	RET

addnull			; Branches out from the input loop to append null to the arrays and print
ld	r5, NULL
str	r5, r4, #0	
str	r5, r3, #0	; appends null to the end upon LF	
; here load array1 and then array 2 into R4, printing appropriate messages before user entered and encrypter/decrypted string
lea	r0, YE
	puts
lea	r4, ARRAY1
JSR	print
and	r4, r4, #0
add	r4, r4, r2
add	r5, r5, r6
BRz	dc	; Branch decrypt
dc
lea	r0, DDD
	puts
BRp	en	; Branch encrypt
en	
lea	r0, EDD
	puts
JSR	print


print
st	r7, R7ADR
inner
ldr	r0, r4, #0
	out
add	r4, r4, #1
add	r1, r0, r0
BRp	inner
ld	r7, R7ADR
	RET

quit			
lea	r0, QUIT
puts
	HALT

TENLOOP	.FILL	#10
NULL	.FILL	#0
R7ADR	.BLKW	1
CIPHER	.BLKW	1
D	.FILL	#-100
X	.FILL	#-120
FE	.FILL	#-48

HELLO	.STRINGZ	"Welcome to Manmeet Singh's Cipher Prog"
EORD	.STRINGZ	"\n\n(e)ncrypt   (d)ecrypt    e(x)it\n"
CPRPT	.STRINGZ	"\nEnter cipher for the string (1-25)\n"
STRP	.STRINGZ	"Enter the string ( < 200 chars )\n"
QUIT	.STRINGZ	"\nGoodbye !!!"
EDD	.STRINGZ	"\n<ENCRYPTED>	"
DDD	.STRINGZ	"\n<DECRYPTED>	"
YE	.STRINGZ	"\n<USER INPUT>	"

ARRAY1	.BLKW	200
	.END