pila segment stack 'stack'

    dw 256 dup (?)

pila ends

datos segment            
    
    espacio db 13,10,'$'
    msg0 db "Digite el numero: ",'$'
    msg1 db "El numero digitado en char es -> ",'$'
    msg2 db "El numero digitado en string es -> ", '$'      
    msg3 db "El numero digitado en booleano es -> ", '$' 
    msg4 db "El numero digitado en fecha es -> ", '$'
    
    string db 256 dup('$')
    numero dw ?
    caracter db ?
    booleano db ?
    fecha dw 3 dup(0)       
    aux dw ?

datos ends        


codigo segment 
    assume  cs:codigo, ds:datos, ss:pila
              

LadMi proc      
    push bp
    mov bp, sp
    
    push ax           
    push bx
    push cx
    push dx
    push si
    push di
    push es
           
    mov es, word ptr [bp + 6]  ;datos 
    mov si, word ptr [bp + 4]
    mov cx, 1 
    push 13d
    input:
        mov ax, 0
        mov ah, 01h
        int 21h    
        
        cmp al, 13d
        je continuar
        mov ah, 0
        push ax
        
        mov cx, ax
        jmp input
        
    
    continuar:
        mov cx, 1
        mov bx, 0  
 
    guardar:
        
        pop dx  
        cmp dx, 13d
        je asignar
        
        sub dx, 30h
        
        mov ax, cx
        mul dx 
        
        add bx, ax
        
        mov ax, 10
        mul cx
        mov cx, ax
        jmp guardar
        
    asignar:
        mov word ptr es:[si], bx
                
    break:   
        pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp 
        ret 
LadMi endP           


GhitlhMi proc
    push bp
    
    mov bp, sp   
    
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es          
    
    xor ax, ax
    xor cx, cx
    
    
    mov di, word ptr [bp + 4]
    mov es, word ptr [bp + 6]
    mov ax, word ptr es:[di]
    
    push 30h
    imp:     
        xor dx, dx
        mov cx, 10
        div cx 
        push dx
        cmp ax, 0
        jbe sig       
        jmp imp
        
    sig:
        pop dx
        cmp dx, 30h
        je cont
        add dx, 30h
        mov ah, 2
        int 21h
        jmp sig
    cont:  
        pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
        ret

GhitlhMi endP


GhitlhDegh proc
    push bp
    mov bp, sp
    
    push ax
	push bx
	push cx
	push dx
	push si
	push di 
	push es
	
	mov es, word ptr [bp + 6]
	mov si, word ptr [bp + 4] 
	
	mov dl, byte ptr es:[si] 
	mov ah,02h
	int 21h
	        
	pop es 
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret

GhitlhDegh endP

GhitlhMu proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    
    mov es, word ptr [bp + 6]
    mov si, word ptr [bp + 4] 
    inc si
        
    lea dx, byte ptr es:[si]   
    mov ah, 09h
    int 21h
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret                     
    
GhitlhMu endp   

GhitlhVit proc
    push bp
    mov bp, sp
    
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
        
    mov ah, 02h
    mov es, word ptr[bp + 6]
    mov si, word ptr[bp + 4]
    mov bl, byte ptr es:[si]
    cmp bl, 1
    je true
    
    cmp bl,0
    je false
    
    true: 
        
        mov dl, 't'
        int 21h
        
        mov dl, 'e'
        int 21h
        
        mov dl, 'h'
        int 21h
        
        jmp retorno
    false:
        mov dl, 'n'
        int 21h
        
        mov dl, 'g'
        int 21h
        
        mov dl, 'e'
        int 21h
        
        mov dl, 'b'
        int 21h
    
    retorno:
        pop es
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
        ret

GhitlhVit endP      

GhitlhJaj proc
    push bp
    mov bp, sp        
    
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    xor ax, ax
    xor cx, cx 
     
    mov bx,0 
    mov es, word ptr [bp + 6]
    mov si, word ptr [bp + 4]
          
    
    while: 
        push 30h
        mov ah, 02h 
        mov dx, '|'
        int 21h
        cmp bx, 3
        je cant            
        mov ax, word ptr es:[si]
        add si,2 
        inc bx
    print:     
        xor dx, dx
        mov cx, 10
        div cx 
        push dx
        cmp ax, 0
        jbe sog       
        jmp print
        
    sog:
        pop dx
        cmp dx, 30h
        je while
        add dx, 30h
        mov ah, 2
        int 21h
        jmp sog
    cant:
        pop ax      
        pop es
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
        ret

GhitlhJaj endP

Mi2Degh proc
    push bp
    mov bp, sp
    
    push ax
	push bx
	push cx
	push dx
	push si
	push di 
	push es
	
	; el char donde se va guardar   4  
	; el numero                     6
	; el ds                         8
	
	mov es, word ptr [bp + 8]
	mov di, word ptr [bp + 6] ; numero
	mov si, word ptr [bp + 4] ; char
	
	mov ax, word ptr es:[di] ; bx tiene el numero
	mov bx, 256
	mov dx, 0
	div bx  ; en dl queda el residuo bro
	
	mov word ptr es:[si], dx
	
    pop es 
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret
Mi2Degh endp

Mi2Mu proc
    push bp
    
    mov bp, sp   
    
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es          
    
    xor ax, ax
    xor cx, cx
    
    ; el ds 8
    ; el numero 6
    ; el string 4
    
    mov di, word ptr [bp + 6]     
    mov si, word ptr [bp + 4]
    mov es, word ptr [bp + 8]
    mov ax, word ptr es:[di]
    mov cx, 10                
    mov bx, 0
    
    push 30h
    extraer:     
        xor dx, dx      
        div cx 
        add dx, 48d
        push dx   
        
        inc bx
        cmp ax, 0
        jbe preguardar      
        jmp extraer
    
    preguardar:
        mov byte ptr es:[si], bl
        inc si
    cicloGuardado:
        pop dx
        cmp dx, 30h
        je salirMain
        
        mov byte ptr es:[si], dl
        inc si
        jmp cicloGuardado
        
        
    
    salirMain:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret              
          
Mi2Mu endp   

Mi2Vit proc
    push bp
    mov bp, sp   
    
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    
    ; ds -> 8
    ; numero -> 6
    ; vit -> 4
    
    mov es, word ptr [bp + 8]
    mov di, word ptr [bp + 6]
    mov si, word ptr [bp + 4]
    
    mov ax, word ptr es:[di]
    cmp ax, 0
    je setCero
    jne setUno
    
    setUno:
        mov byte ptr es:[si], 1
        jmp lemmego
    
    setCero:
        mov byte ptr es:[si], 0
        jmp lemmego
   
    lemmego:
    
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret    
    
Mi2Vit endp

Mi2Jaj proc
    push bp
    mov bp, sp   
    
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    
    ; ds -> 8
    ; numero -> 6
    ; fecha -> 4
    
    mov es, word ptr [bp + 8]
    mov di, word ptr [bp + 6]
    mov si, word ptr [bp + 4]

    mov ah, 2AH
    int 21h
    
    ;cx = año
    ;dh = mes
    ;dl = dia
    ;al = 0 domingo, 1 lunes...
    
    mov cl, dh ;cx mes
    mov dh, 0  ;dx dia
    mov ch, 0         
    
    mov word ptr es:[si], dx
    add si, 2
    mov word ptr es:[si], cx
    add si, 2
    mov cx, word ptr es:[di]
    mov word ptr es:[si], cx
           
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret    
    
Mi2Jaj endp
    
endp
	inicio:
		mov ax, datos
        mov ds, ax
		mov ax, pila
        mov ss, ax
		      
	    lea dx, msg0
	    mov ah, 09h
	    int 21h
	    
		push ds
		lea dx, numero
		push dx
		       
		call LadMi
		
		lea dx, espacio
		mov ah, 09h
		int 21h
		
		lea dx, msg1
		mov ah, 09h
		int 21h
		
		push ds
		lea dx, numero
		push dx
		lea dx, caracter
		push dx
		call Mi2Degh
		
		push ds
		lea dx, caracter
		push dx
		call GhitlhDegh
		          
		lea dx, espacio
		mov ah, 9h
		int 21h
		 ;************
		lea dx, msg2
		mov ah, 09h
		int 21h
				
		push ds
		lea dx, numero
		push dx
		lea dx, string
		push dx
		call Mi2Mu
		
		push ds
		lea dx, string
		push dx
		call GhitlhMu   
		; ************  
		
		; ************
	    lea dx, espacio
		mov ah, 09h
		int 21h
		
		lea dx, msg3
		mov ah, 09h
		int 21h
				
		push ds
		lea dx, numero
		push dx
		lea dx, booleano
		push dx
		call Mi2Vit
		
		push ds
		lea dx, booleano
	    push dx
		call GhitlhVit 
		; ************
		
		; ************
	    lea dx, espacio
		mov ah, 09h
		int 21h
		
		lea dx, msg4
		mov ah, 09h
		int 21h
				
		push ds
		lea dx, numero
		push dx
		lea dx, fecha
		push dx
		call Mi2Jaj
		
		push ds
		lea dx, fecha
		push dx
		call GhitlhJaj 
		; ************
		
	salir:	
		mov ax, 4C00h
		int 21h
codigo ends
end inicio