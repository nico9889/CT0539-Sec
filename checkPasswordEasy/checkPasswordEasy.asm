   
   ; Save old stack pointer
   0x000000000000076a <+0>:     push   rbp							; Push stack base pointer
   0x000000000000076b <+1>:     mov    rbp,rsp						; Copy Stack Pointer into Stack Base Pointer
   0x000000000000076e <+4>:     push   rbx							; Push RBX Value (64bit, base register)
   
   0x000000000000076f <+5>:     sub    rsp,0x58						; Sub FROM RSP (Stack Pointer) 0x58 (88) rsp-88
   0x0000000000000773 <+9>:     mov    DWORD PTR [rbp-0x54],edi		; Move EDI into RBP-0x54 (16bit memory area reference)	
   0x0000000000000776 <+12>:    mov    QWORD PTR [rbp-0x60],rsi		; Move RSI (Source 64bit register) into rbp-0x60 (32bit memory area reference) (probably argv)
   0x000000000000077a <+16>:    mov    rax,QWORD PTR fs:0x28		; Move F Segment (32bit memory reference) into 64bit accumulator
   0x0000000000000783 <+25>:    mov    QWORD PTR [rbp-0x18],rax		; Move RAX (64bit acc) into rbp-0x18 (32bit memory reference)
   0x0000000000000787 <+29>:    xor    eax,eax
   
   ; Store in memory int encPassword[8] = {0xffffffff, 0x1,0x2,0x3,0x6,0x4,0x3,0x3};
   ; int enc[8] = {0xffffffff, 0x1,0x2,0x3,0x6,0x4,0x3,0x3};
   0x0000000000000789 <+31>:    mov    DWORD PTR [rbp-0x40],0xffffffff	; Riferisce a DWORD in memoria, 0xffffffff
   0x0000000000000790 <+38>:    mov    DWORD PTR [rbp-0x3c],0x1
   0x0000000000000797 <+45>:    mov    DWORD PTR [rbp-0x38],0x2
   0x000000000000079e <+52>:    mov    DWORD PTR [rbp-0x34],0x3
   0x00000000000007a5 <+59>:    mov    DWORD PTR [rbp-0x30],0x6
   0x00000000000007ac <+66>:    mov    DWORD PTR [rbp-0x2c],0x4
   0x00000000000007b3 <+73>:    mov    DWORD PTR [rbp-0x28],0x3
   0x00000000000007ba <+80>:    mov    DWORD PTR [rbp-0x24],0x3
   
   
   0x00000000000007c1 <+87>:    mov    rax,QWORD PTR [rbp-0x60]			; rbp - 0x60 (memory reference) in RAX 
   0x00000000000007c5 <+91>:    mov    rax,QWORD PTR [rax+0x8]			; RAX = [RAX+8]
   
   0x00000000000007c9 <+95>:    mov    QWORD PTR [rbp-0x48],rax			; [RBP-0x48] = RAX
   0x00000000000007cd <+99>:    cmp    DWORD PTR [rbp-0x54],0x1			; [rbp-0x54] == 0x1
   0x00000000000007d1 <+103>:   je     0x7f3 <main+137>										; if [rbp-0x54] == 0x1 JUMP Main+137
   0x00000000000007d3 <+105>:   mov    rax,QWORD PTR [rbp-0x48]								; Copy input rbp-0x48 to RAX
   0x00000000000007d7 <+109>:   mov    rdi,rax												; Copy RAX to RDI for STRLEN
   0x00000000000007da <+112>:   call   0x610 <strlen@plt>									; Call strlen
   0x00000000000007df <+117>:   mov    rbx,rax												; Salva il risultato per comparison
   0x00000000000007e2 <+120>:   lea    rdi,[rip+0x20087f]        # 0x201068 <encPassword>	; Load encoded password to strlen
   0x00000000000007e9 <+127>:   call   0x610 <strlen@plt>									; Call strlen
   0x00000000000007ee <+132>:   cmp    rbx,rax												; Compare string length
   0x00000000000007f1 <+135>:   je     0x827 <main+189>										; If string are equals jump to 189 else
   0x00000000000007f3 <+137>:   lea    rdi,[rip+0x20086e]        # 0x201068 <encPassword>	; Copy rip+0x20086e to strlen
   0x00000000000007fa <+144>:   call   0x610 <strlen@plt>									; Call strlen
   0x00000000000007ff <+149>:   mov    rdx,rax												; *dx = *ax (len result maybe)			
   0x0000000000000802 <+152>:   mov    rax,QWORD PTR [rbp-0x60]								; *ax = *bp-0x60 (old saved source index)
   0x0000000000000806 <+156>:   mov    rax,QWORD PTR [rax]									; *ax = (int32)*ax
   0x0000000000000809 <+159>:   mov    rsi,rax												; source index = *ax
   0x000000000000080c <+162>:   lea    rdi,[rip+0x125]        # 0x938						; *di = Invalid characters length pointer
   0x0000000000000813 <+169>:   mov    eax,0x0												; *ax = 0
   0x0000000000000818 <+174>:   call   0x620 <printf@plt>									; printf Invalid characters length
   0x000000000000081d <+179>:   mov    edi,0x2
   0x0000000000000822 <+184>:   call   0x640 <exit@plt>										; EXIT
   0x0000000000000827 <+189>:   mov    DWORD PTR [rbp-0x4c],0x0								; i = 0
   0x000000000000082e <+196>:   jmp    0x861 <main+247>										; JUMP TO CMP 247
   
   
   0x0000000000000830 <+198>:   mov    eax,DWORD PTR [rbp-0x4c]								; :DECODE int eax = i
   0x0000000000000833 <+201>:   movsxd rdx,eax												; int64 rdx = eax (=i)
   0x0000000000000836 <+204>:   lea    rax,[rip+0x20082b]        # 0x201068 <encPassword>	; char* rax = encPassword
   0x000000000000083d <+211>:   movzx  edx,BYTE PTR [rdx+rax*1]								; *dx = encPassword[i*1]; dx = h
   0x0000000000000841 <+215>:   mov    eax,DWORD PTR [rbp-0x4c]								; *ax = i
   0x0000000000000844 <+218>:   cdqe														; int64 *ax = *ax;
   0x0000000000000846 <+220>:   mov    eax,DWORD PTR [rbp-0x40+rax*4]						; *ax = enc[(i * 4)]  // 4 bytes because it's int,  int enc[8] = {0xffffffff, 0x1,0x2,0x3,0x6,0x4,0x3,0x3}; ax = |-1|
   0x000000000000084a <+224>:   lea    ecx,[rdx+rax*1]										; *cx = *dx+*ax*1 = h + |-1| = g
   0x000000000000084d <+227>:   mov    eax,DWORD PTR [rbp-0x4c]								; *ax = i
   0x0000000000000850 <+230>:   movsxd rdx,eax												; *dx = i
   0x0000000000000853 <+233>:   lea    rax,[rip+0x20080e]        # 0x201068 <encPassword>	; *ax = encPassword
   0x000000000000085a <+240>:   mov    BYTE PTR [rdx+rax*1],cl								; encPassword[i] = *cx
																							; (for i=0; i<=7;i++)
   0x000000000000085d <+243>:   add    DWORD PTR [rbp-0x4c],0x1								; Aggiunge 1 a rbp-0x4c 
   0x0000000000000861 <+247>:   cmp    DWORD PTR [rbp-0x4c],0x7								; Confronta rbp-04xc con 7
   0x0000000000000865 <+251>:   jle    0x830 <main+198>										; JUMP less equal :DECODE
   0x0000000000000867 <+253>:   mov    rax,QWORD PTR [rbp-0x48]
   0x000000000000086b <+257>:   mov    rsi,rax
   
   0x000000000000086e <+260>:   lea    rdi,[rip+0x2007f3]        # 0x201068 <encPassword>	; Copy string address for strcmp
   0x0000000000000875 <+267>:   call   0x630 <strcmp@plt>									; String compare
   0x000000000000087a <+272>:   test   eax,eax
   0x000000000000087c <+274>:   jne    0x894 <main+298>										;if equal
   0x000000000000087e <+276>:   lea    rdi,[rip+0xd3]        # 0x958						; 	load text
   0x0000000000000885 <+283>:   call   0x600 <puts@plt>										;  print to screen
   0x000000000000088a <+288>:   mov    edi,0x0												;  
   0x000000000000088f <+293>:   call   0x640 <exit@plt>										;  exit
																							; else
   0x0000000000000894 <+298>:   lea    rdi,[rip+0xe6]        # 0x981						;   load text
   0x000000000000089b <+305>:   call   0x600 <puts@plt>										;   print to screen