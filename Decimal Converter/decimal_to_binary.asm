; Manmeet Singh - msingh11@ucsc.edu
; Lab 6 - decimal to 2s comp converter
; Tu/Th 6pm. TA - Steve

	.ORIG x3000
lea	r0, GREET	; greeting	
	puts

fromtop

and 	r0, r0, #0
and 	r1, r1, #0
and 	r2, r2, #0
and 	r3, r3, #0
and 	r4, r4, #0
and 	r5, r5, #0
and 	r6, r6, #0
st	r5, INT
st	r5, FLAG

lea	R0, PROMPT	; prompt
	puts

input
GETC
OUT			; Read out char from r0
add	r1, r0, #-10	; Add -10 for LF
BRz	checkflag	; Branch to checkflag and proceed further if LF

ld	r3, NEG		; Load -45 for ASCII negative sign
add	r3, r0, r3	
BRz	setflag		

ld	r4, X
add 	r4, r0, r4	; Check if char entered is x
BRz	quit		; Branch to quit if it is

st	r0, DIGIT
ld	r2, DIGIT
ld	r3, FE		; FE = -48
add	r2, r3, r2
st	r2, DIGIT

ld	r5, INTLOOP
and 	r4, r4, #0

intlp:			; does int X 10
ld	r1, INT
add	r4, r1, r4
add	r5, r5, #-1
BRp	intlp

ld	r2, DIGIT
add	r1, r2, r4
st	r1, INT

BR	input

setflag			; Adds 1 to the flag variable
ld	r1, FLAG	; and branches back to input
add	r1, r1, #1
st	r1, FLAG
BR	input

checkflag
ld	r1, FLAG	; load flag var into R1
BRp	invert		; if positive, go to inversion prodecure
BR	mask		; now jump to mask

invert
ld	r2, INT		; load int into R2
not	r2, r2		; invert bits in R2
add	r2, r2, #1	; add 1 to inverted bits
st	r2, INT		; store inversion+1 into var INT
BR	mask		; now jump to mask

mask
ld	r4, COUNT	; load count=15 into R4
lea	r1, MASK	; load the address to mask in R1
st	r1, MASKPTR	; store the address into Maskptr
BR	insidelp

insidelp
ldi	r1, MASKPTR	; load value at maskptr address into R2
ld	r2, INT		; load into into R3
and	r3, r2, r1	; int AND mask
BRnp	One
BRz	Zero

Zero 			; print 0, then goto updateptr
LD 	R0, ZeroASCII 
    	TRAP x21 
BR	updateptr

One
LD 	R0 OneASCII 	; print 1, then goto updateptr
    	TRAP x21
BR	updateptr

updateptr
ld	r5, MASKPTR	; load maskptr into R2
add	r5, r5, #1	; add 1 to maskptr
st	r5, MASKPTR	; store maskptr
add	r4, r4, #-1	; decrement count until < 0
BRzp	insidelp

BR	fromtop		; back to top for another decimal

quit			
lea	r0, QUIT
puts
BR	Done

Done
	HALT


GREET	.STRINGZ	"Welcome to Manmeet's conversion proggie\n"
PROMPT	.STRINGZ	"\nEnter a decimal or x to quit\n"
QUIT	.STRINGZ	"\nBye"

ZeroASCII	.FILL	#48
OneASCII	.FILL	#49

INT	.FILL	#0
FLAG	.FILL	#0
DIGIT	.FILL	#0

NEG	.FILL	#-45
X	.FILL	#-120
FE	.FILL	#-48
INTLOOP	.FILL	#10

MASKPTR	.BLKW	1
COUNT	.FILL	#15
MASK	.FILL	x8000
	.FILL	x4000
	.FILL	x2000
	.FILL	x1000
	.FILL	x0800
	.FILL	x0400
	.FILL	x0200
	.FILL	x0100
	.FILL	x0080
	.FILL	x0040
	.FILL	x0020
	.FILL	x0010
	.FILL	x0008
	.FILL	x0004
	.FILL	x0002
	.FILL	x0001

	.END