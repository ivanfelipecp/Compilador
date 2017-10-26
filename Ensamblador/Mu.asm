pila segment stack 'stack'

    dw 256 dup (?)

pila ends

datos segment
    string db 256 dup('$')  
    numero dw ?
    caracter db ?
    booleano db ?
    fecha dw 3 dup(0)    
    
    msg0 db "Digite el string: ",'$'
    msg1 db "El string digitado en char es -> ",'$'
    msg2 db "El string digitado en numero es -> ", '$'      
    msg3 db "El string digitado en booleano es -> ", '$' 
    msg4 db "El string digitado en fecha es -> ", '$'
    
    espacio db 13,10,'$'
datos ends
                           
codigo segment
    assume  cs:codigo, ds:datos, ss:pila     
    
LadMu proc      
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
    input:
        mov ah, 01h
        int 21h    
        
        cmp al, 13d
        je continuar
        mov ah, 0
        push ax 
        inc di
        jmp input
        
    
    continuar:   
        sub di, 2
        mov word ptr es:[si], di
        pop ax
 
    guardar:
        
        cmp di, 0
        je break                
        xor dx, dx
        pop dx       
        mov byte ptr es:[di], dl
        dec di
        jmp guardar
        
    break:
        pop ax
        pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx  
        pop ax 
        pop bp 
        ret 
    

LadMu endP

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


Mu2Jaj proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    ; ds -> 8
    ; string -> 6
    ; fecha -> 4 
    
    mov es, word ptr[bp+8]
    mov di, word ptr[bp+6] 
    mov si, word ptr[bp+4]
    
    mov bx, 0
    mov cx, 0
    mov cl, byte ptr es:[di]
    inc di
    extraer:   
        mov dx, 0
        mov dl, byte ptr es:[di]
        add bx, dx
        inc di
        loop extraer
        
    ;mov ah, 01h
    ;int 21h
    
    mov ah, 2AH
    int 21h
    
    mov ah, 0 
    mov al, dh ; ax mes
    mov dh, 0 ;dx dia  
    
    mov word ptr es:[si], dx
    add si, 2
    mov word ptr es:[si], ax
    add si, 2
    mov word ptr es:[si], bx
 
    ;cx = a�o
    ;dh = mes
    ;dl = dia
    ;al = 0 domingo, 1 lunes...
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Mu2Jaj endp   



Mu2Vit proc
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
    ; 6 string
    ; 4 boolean
    
    mov es, word ptr[bp + 8]
    mov di, word ptr[bp + 6]
    mov si, word ptr[bp + 4]
    
    mov ax, 0
    mov al, byte ptr es:[di]
    cmp al, 4
    je checkFake
    jmp Truleano            
    
    checkFake:
    inc di
    mov dx,0
    mov dl, byte ptr es:[di]
    cmp dl, 'n'
    je checkG
    cmp dl, 'N'
    jne Truleano
    
    
    
    checkG:
    inc di
    mov dl, byte ptr es:[di]
    cmp dl, 'g'
    je checkE
    
    cmp dl, 'G'
    jne Truleano
    
    checkE:
    inc di
    mov dl, byte ptr es:[di]
    cmp dl, 'e'
    je checkB
    
    cmp dl, 'E'
    jne Truleano
    
    checkB:
    inc di 
    mov dl, byte ptr es:[di]
    cmp dl, 'b'
    je zetokaiba
    
    cmp dl, 'B'
    jne Truleano
    
    zetokaiba:
    mov byte ptr es:[si], 0
    jmp exitoso
    
    Truleano:
        mov byte ptr es:[si], 1
    
    exitoso:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 
Mu2Vit endp 

Mu2Degh proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push di 
    push si
    push es
    
    ; 8 es
    ; 6 string
    ; 4 char
    
    
    
    mov es, word ptr [bp + 8]
    mov di, word ptr [bp + 6]
    
    mov ch, 0
    mov cl, byte ptr es:[di]
    mov dx, cx              
    
    ;mov ah, 01h
    ;int 21h
    
    
    inc di 
    mov bx, 0
    mov ax, 0
    sike:
        mov al, byte ptr es:[di]
        add bx, ax
        inc di
        
        loop sike
          
    mov ax, bx 
    mov bx, dx
    mov dx, 0
    div bx
    
    ;mov ah, 01h
    ;int 21h 
    
    mov si, word ptr [bp + 4]
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
Mu2Degh endp  

Mu2Mi proc
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
    ; 6 string
    ; 4 numero
    
    mov es, word ptr[bp + 8]
    mov di, word ptr[bp + 6]
    
    mov dx, 10
    mov cx, 0
    mov cl, byte ptr es:[di]
    sub cx, 2
    mov ax, 10    
    
    setUnidad:
        mul dx
        mov dx, ax
        mov ax, 10
        loop setUnidad
        
      
        
    
    mov cx, 0
    mov cl, byte ptr es:[di]
    inc di
    
    mov si, 0
    
    maincycle:
        mov bh, 0
        mov bl, byte ptr es:[di]
        sub bl, 48d
        
        menor:
            cmp bx, 0d
            jge mayor
            
            jmp set0
        mayor:
            cmp bx, 9d
            jle addN
            jmp set0
        addN: 
            ; en dx tenemos las unidades
            ; en bx tenemos el numero
            
            cmp dx, 0
            je set1
            jmp siguee
            
            set1:
            mov dx, 1
            
            siguee:
            mov ax, dx
            push dx
            mul bx
            add si, ax
            
            mov ax, 10      
            pop bx
            mov dx, 0
            div bx
            inc di

            loop maincycle
            
            jmp setN
            
        set0:
            mov ax, 0
            mov si, word ptr[bp+4]
            mov word ptr es:[si], 0 
            jmp cyanerds
            
        setN:
            mov ax, si
            mov si, word ptr[bp+4]
            mov word ptr es:[si], ax
            jmp cyanerds
    
    cyanerds:
        pop es
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
        ret 
Mu2Mi endp  

    inicio:
		mov ax, datos
        mov ds, ax
		mov ax, pila
        mov ss, ax
        
        lea dx, msg0
        mov ah, 09h
        int 21h
        
        
        push ds
        lea dx, string
        push dx
        call LadMu
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg1
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx,string
        push dx
        lea dx, caracter
        push dx
        
        call Mu2Degh  
        
        push ds
        lea dx, caracter
        push dx
        
        call GhitlhDegh   
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg2
        mov ah, 09h
        int 21h 
        
        push ds
       lea dx,string
        push dx
        lea dx, numero
        push dx
        
        call Mu2Mi
        
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
        lea dx,string
        push dx
        lea dx, booleano
        push dx
        
        call Mu2Vit
        
        push ds
        lea dx, booleano
        push dx
        
        call GhitlhVit 
        
        lea dx, espacio
        mov ah, 09h
        int 21h
        
        lea dx, msg4
        mov ah, 09h
        int 21h 
        
        push ds
        lea dx,string
        push dx
        lea dx, fecha
        push dx
        
        call Mu2Jaj
        
        push ds
        lea dx, fecha
        push dx
        
        call GhitlhJaj   
        
	salir:	
	mov ax, 4C00h
	int 21h
codigo ends
end inicio                           


