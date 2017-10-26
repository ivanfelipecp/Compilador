pila segment stack 'stack'

    dw 256 dup (?)

pila ends

datos segment
    string db 256 dup('$')  
    numero dw ?
    caracter db ?
    booleano db ?  
    
    msg0 db "Digite el booleano(teh/ngeb): ",'$'
    msg1 db "El booleano digitado en string es -> ",'$'
    msg2 db "El booleano digitado en numero es -> ", '$'      
    msg3 db "El booleano digitado en caracter es -> ", '$' 
    
    espacio db 13,10,'$'
datos ends
                           
codigo segment
    assume  cs:codigo, ds:datos, ss:pila     
    
LadVit proc      
    push bp
    mov bp, sp
    
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
      
    mov es, word ptr [bp + 6]  ;datos 
    mov si, word ptr [bp + 4]
    input:
        mov ax, 0
        mov ah, 01h
        int 21h    
        
        cmp al, 13d
        je verificar
        mov ah, 0
        push ax
        
        mov cx, ax
        jmp input
         
    verificar:
        pop ax
        
        cmp al, 'h'
        je t1
        
        cmp al, 'H'  
        je t1
        
        cmp al, 'b'
        je n1      
        
        cmp al, 'B'
        je n1  
        
        jmp break
         
    t1:
        pop ax
        cmp al, 'e'
        je t2    
        
        cmp al, 'E'
        je t2
       
        
        jmp break 
    t2:
        pop ax
        cmp al, 't'
        je tegh    
        
        cmp al, 'T'
        je tegh    
        
        jmp break 
        
    n1: 
        pop ax 
        cmp al, 'e'
        je n2    
        
        
        cmp al, 'E'
        je n2
        
        jmp break
        
    n2:  
        pop ax
        cmp al, 'g'
        je n3    
        
        cmp al, 'G'
        je n3
        
        jmp break
    n3:  
        pop ax
        cmp al, 'n'
        je ngeb  
        
        cmp al, 'N'
        je ngeb
        
        jmp break
            
        
    tegh:
        mov byte ptr es:[si], 1
        jmp break
           
        
    ngeb:
        mov byte ptr es:[si], 0   
        jmp break    
                 
    break:   
        pop es      
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp 
        ret 
LadVit endP

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
  

Vit2Degh proc
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
    
    cmp al, 1
    je setOne
    jne setZero
    
    setOne:
        mov byte ptr es:[si], '1'
        jmp esc
        
    setZero:
        mov byte ptr es:[si], '0'
        jmp esc 
    
    esc:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Vit2Degh endp 

Vit2Mi proc
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
    
    cmp al, 1
    je setUnazo
    jne setCerazo
    
    setUnazo:
        mov word ptr es:[si], 1
        jmp lemmego
    setCerazo:
        mov word ptr es:[si], 0

    lemmego:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Vit2Mi endp

Vit2Mu proc
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
    
    cmp al, 1
    je pongale1
    jne pongale0
    
    pongale1:
        mov byte ptr es:[si], 3
        inc si
        mov byte ptr es:[si], 't'
        inc si
        mov byte ptr es:[si], 'e'
        inc si                   
        mov byte ptr es:[si], 'h'
        jmp rollback   
    pongale0:
        mov byte ptr es:[si], 4
        inc si
        mov byte ptr es:[si], 'n'
        inc si
        mov byte ptr es:[si], 'g'
        inc si                   
        mov byte ptr es:[si], 'e'
        inc si
        mov byte ptr es:[si], 'b'        
        jmp rollback
        
    rollback:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Vit2Mu endp 

    inicio:
		mov ax, datos
        mov ds, ax
		mov ax, pila
        mov ss, ax
        
        lea dx, msg0
        mov ah, 09h
        int 21h
        
        
        push ds
        lea dx, booleano
        push dx
        call LadVit
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg1
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx, booleano
        push dx
        lea dx, string
        push dx
        
        call Vit2Mu  
        
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
        lea dx, booleano
        push dx
        lea dx, numero
        push dx
        
        call Vit2Mi
        
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
        lea dx, booleano
        push dx
        lea dx, caracter
        push dx
        
        call Vit2Degh
        
        push ds
        lea dx, caracter
        push dx
        
        call GhitlhDegh
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
	salir:	
	mov ax, 4C00h
	int 21h
codigo ends
end inicio                           


