;// Program 2          (Program2.asm)
;// Calculating mean and variance of array raw
;// Mark LaFreniere
;// Creation: 2/21/2021
;// Revisions: 0
;// Date: 2/21/2021    Modified: 2/21/2021

INCLUDE Irvine32.inc
.data
	raw		WORD	10, 12, 8, 17, 9, 22, 18, 11, 23, 7, 30, 22, 19, 60, 71		;// array of integers
	rawSize = ($ - raw) / 2														;// size of array
	varSum WORD		0															;// used to store sum of squares
	savVal WORD		?															;// saves value for squaring raw - mean		
	mean	BYTE	?															;// mean of raw
	variance WORD	?															;// variance of raw
	strMean BYTE "MEAN ",0
	strVar  BYTE "VAR ",0
.code
main proc
	mov eax,0				;// readying for division
	mov ebx,rawsize			

	mov edi, OFFSET raw		;// readying Loop for adding array
	mov ecx,rawsize
	mov edx,0

	L1:add edx,ecx			;// loop for adding integers in array
		add ax,[edi]
		add edi,TYPE raw
		loop L1

	div bl					;// find mean and assign it to mean
	mov mean,al
	
	mov edi, OFFSET raw		;// readying loop for adding variance sum
	mov ecx,rawsize
	mov edx,0
	mov eax,0

	L2:add edx,ecx			;// Loop for finding sum of squares
		mov al,[edi]
		sub al,mean
		mov savVal,ax
		neg al
		cmovl ax, savVal
		mov bl,al
		mul bl
		add varSum,ax
		add edi,TYPE raw
		loop L2

	mov ax,varSum			;// Finds variance and assigns it to variance
	mov bx,rawSize
	xor dx,dx
	div bx
	mov variance,ax
	
	mov eax,0				;// Display Results
	mov edx,OFFSET strMean
	call WriteString
	mov al,mean
	call WriteDec
	call Crlf
	mov edx,OFFSET strVar
	call WriteString
	mov ax,variance
	call WriteDec
	call Crlf
	
	exit
main endp
end main