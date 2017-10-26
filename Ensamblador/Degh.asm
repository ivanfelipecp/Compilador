pila segment stack 'stack'

    dw 256 dup (?)

pila ends

datos segment
    string db 256 dup('$')  
    numero dw ?
    caracter db ?
    booleano db ?  
    
    msg0 db "Digite el caracter: ",'$'
    msg1 db "El caracter digitado en string es -> ",'$'
    msg2 db "El caracter digitado en numero es -> ", '$'      
    msg3 db "El caracter digitado en booleano es -> ", '$' 
    
    espacio db 13,10,'$'
datos ends
                           
codigo segment
    assume  cs:codigo, ds:datos, ss:pila     
    
LadDegh proc 
	push bp
	mov bp, sp 
	
	push ax
	push bx
	push cx
	push dx
	push si
	push di 
	push es
	
	
	mov ah, 01h
	int 21h 
	
	mov es, word ptr [bp+6]
	mov si, word ptr [bp+4]
	mov byte ptr es:[si], al
	
	 
	pop es 
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret
LadDegh endP

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
    ;mov bx, word ptr es:[si]   
    ;mov bh, 0
    ;inc si 
    
    ;ciclo:
    ;    cmp si, bx
    ;    jg retorn
        
    lea dx, byte ptr es:[si]   
    mov ah, 09h
    int 21h
    
    retorn:
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
  

Degh2Vit proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    ; 8 ds
    ; 6 degh
    ; 4 numero
    
    mov es, word ptr[bp + 8]
    mov di, word ptr[bp + 6] 
    mov si, word ptr[bp + 4]
    
    mov ax, 0
    mov al, byte ptr es:[di]
    
    cmp al, 'n'
    je set_cero
    
    cmp al, 'N'
    jne set_Uno
       
    set_cero: 
        mov byte ptr es:[si], 0 
        jmp getaway
    set_uno:
        mov byte ptr es:[si], 1
    
    getaway:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Degh2Vit endp 

Degh2Mi proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    ; 8 ds
    ; 6 degh
    ; 4 numero
    
    mov es, word ptr[bp + 8]
    mov di, word ptr[bp + 6]
    mov si, word ptr[bp + 4]
    
    mov ah, 0
    mov al, byte ptr es:[di]
    mov word ptr es:[si], ax
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Degh2Mi endp

Degh2Mu proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    ; 8 ds
    ; 6 degh
    ; 4 numero
    
    mov es, word ptr[bp + 8]
    mov di, word ptr[bp + 6]
    mov si, word ptr[bp + 4]
    
    mov al, byte ptr es:[di]  
    mov byte ptr es:[si], 1
    inc si
    mov byte ptr es:[si], al
    

    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Degh2Mu endp 

    inicio:
		mov ax, datos
        mov ds, ax
		mov ax, pila
        mov ss, ax
        
        lea dx, msg0
        mov ah, 09h
        int 21h
        
        
        push ds
        lea dx, caracter
        push dx
        call LadDegh
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg1
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx,caracter
        push dx
        lea dx, string
        push dx
        
        call Degh2Mu  
        
        push ds
        lea dx, string
        push dx
        
        call GhitlhMu   
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg2
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx, caracter
        push dx
        lea dx, numero
        push dx
        
        call Degh2Mi
        
        push ds
        lea dx, numero
        push dx
        
        call GhitlhMi
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg3
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx, caracter
        push dx
        lea dx, booleano
        push dx
        
        call Degh2Vit
        
        push ds
        lea dx, booleano
        push dx
        
        call GhitlhVit 
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
	salir:	
	mov ax, 4C00h
	int 21h
codigo ends
end inicio                           


