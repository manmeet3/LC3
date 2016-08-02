 ; Manmeet Singh - msingh11@ucsc.edu
; Lab 7 - decimal to 2s Comp + left/right shifting
; Tu/Th 6pm. TA - Steve

	.ORIG x3000
lea	r0, GREET	; greeting	
	puts

fromtop
and 	r5, r5, #0
st	r5, INT
st	r5, FLAG
st	r5, SHIFTBY
st	r5, QTNT

lea	r0, PROMPT	; prompt
	puts

input
	getc
	out		; Read out char from r0
add	r1, r0, #-10	; Add -10 for LF
BRz	checkflag		; Branch to checkflag and proceed further if LF

ld	r3, NEG		; Load -45 for ASCII negative sign
add	r3, r0, r3	
BRz	setflag		

ld	r4, X
add 	r4, r0, r4	; Check if char entered is x
BRz	quit		; Branch to quit if it is

st	r0, DIGIT
ld	r2, DIGIT
ld	r3, FE		; FE = -48
add	r2, r3, r2	; char - 48
st	r2, DIGIT	; char - 48 = digit
ld	r5, TENLOOP	
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
ld	r2, INT
JSR	printR2		; now jump to mask
BR	leftshift

invert
ld	r2, INT		; load int into R2
not	r2, r2		; invert bits in R2
add	r2, r2, #1	; add 1 to inverted bits
st	r2, INT		; store inversion+1 into var INT
JSR	printR2	
BR	leftshift


	;;;;	PRINT 16bit value of R2 ;;;;
printR2
st	r7, RETADR
ld	r4, COUNT
lea	r1, MASK
st	r1, MASKPTR
BR	insidelp

insidelp
ldi	r1, MASKPTR
and	r3, r2, r1
BRnp	One
BRz	Zero
Zero
LD 	R0, ZeroASCII 
    	OUT
BR	updateptr
One
LD 	R0, OneASCII
    	OUT
BR	updateptr
updateptr
ld	r5, MASKPTR
add	r5, r5, #1	
st	r5, MASKPTR	
add	r4, r4, #-1	
BRzp	insidelp

ld	r7, RETADR
	RET
	;;;;	END PRINT SUBROUTING	;;;;

;;; STORE THE NUMBER TO SHIFT BY AND SHIFT LEFT ;;;

leftshift
lea	r0, SHFT
	PUTS
input2
	GETC
	OUT
add	r1, r0, #-10
BRz	convert
ld	r3, FE
add	r2, r0, r3
st	r2, DIGIT
ld	r5, TENLOOP	
and 	r4, r4, #0

intlp2			; does int X 10
ld	r1, SHIFTBY
add	r4, r1, r4
add	r5, r5, #-1
BRp	intlp2

ld	r2, DIGIT
add	r1, r2, r4
st	r1, SHIFTBY
BR	input2

convert
ld	r1, SHIFTBY
ld	r2, INT
lea	r0, SHFTL
	PUTS
toleft
add	r2, r2, r2	; add INT to itself to shift left one at at ime
add	r1, r1, #-1
BRp	toleft

JSR	printR2
BR	shiftright


shiftright
ld	r1, SHIFTBY
ld	r3, DVSOR

newloop
add	r3, r3, r3
add	r1, r1, #-1
BRp	newloop

not	r3, r3
add	r3, r3, #1
;st	r3, DVSOR

ld	r4, QTNT
ld	r5, INT

loop2
add	r4, r4, #1
add	r5, r5, r3
BRzp	loop2

add	r4, r4, #-1
st	r4, QTNT
lea	r0, SHFTR
	PUTS
ld	r2, QTNT

JSR	printR2
BR	fromtop

quit			
lea	r0, QUIT
puts
Done
	HALT

;;;;	Vars and Declarations	;;;;
INT	.FILL	#0
FLAG	.FILL	#0
DIGIT	.FILL	#0

NEG	.FILL	#-45
X	.FILL	#-120
FE	.FILL	#-48
TENLOOP	.FILL	#10

RETADR	.BLKW	1
SHIFTBY	.BLKW	1
DVSOR	.FILL	x1
QTNT	.FILL	#0

GREET	.STRINGZ	"Welcome to Manmeet's conversion proggie"
PROMPT	.STRINGZ	"\n\nEnter a decimal or x to quit\n"
QUIT	.STRINGZ	"\nBye"
SHFT	.STRINGZ	"\nEnter a number to shift by (0-15)\n"
SHFTL	.STRINGZ	"Left Shift:\n"
SHFTR	.STRINGZ	"\nRight Shift:\n"

ZeroASCII	.FILL	#48
OneASCII	.FILL	#49

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