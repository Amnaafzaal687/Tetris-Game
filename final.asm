[org 0x0100]
    jmp start
topleft:dw 0
topright:dw 0
bottomleft:dw 0
bottomright:dw 0
score :dw 0 ;to display score of game  
message:     db   'WELCOME TO TETRIS GAME',0 
message1:     db   'Select 1 for Easy level',0 
message2:     db   'Select 2 for Hard level',0 
endstr:     db   ' GAME END ',0 
s1:db 'SCORE : ',0
time_s:db 'TIME : ',0
next_s:db 'UPCOMING SHAPE',0
second1: dw 0
second2: dw 0
minutes:dw 0
tickcount: dw 0
easyprint:db 'LEVEL :   EASY',0 
hardprint:db 'LEVEL :   HARD',0


Flag: dw 0    ;; to check first row for incoming shape
;-----------clrscr----------------
clrscr: 
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax     ; point es to video base
	xor di, di     ; point di to top left column
	mov ax, 0x0720 ; space char in normal attribute
	mov cx, 2000   ; number of screen locations
	cld            ; auto increment mode
	rep stosw      ; clear the whole screen
	pop di
	pop cx
	pop ax
	pop es
	ret
;-----------delay----------------
delay:
    push cx
    push bx
    mov cx,0xffff
l1: 
   add bx,1
   loop l1

l2: 
   add bx,1
   loop l2

   pop bx
   pop cx
   ret
;-----------background color----------------
background:
   push es
   push ax
   push cx
   push di
   mov ax, 0xb800
   mov es, ax 
   xor di, di 
   mov ax, 0x7820 
   mov cx, 2000
   cld
   rep stosw
   pop di
   pop cx
   pop ax
   pop es
   ret
;-----------coordinate----------------
coordinate:
	push bp
	mov bp,sp
	push ax
	push bx
	mov al, 80
	mul byte [bp+8]
	add ax, [bp+6]
	shl ax, 1
	mov bx,[bp+4]
	mov [bx],ax

	pop bx
	pop ax
	pop bp
	ret 6
horizontal:  ;to print landscape line
	push bp
	mov bp,sp             
	push ax
	push bx
	push di 
	push es

	mov ax, 0xb800 ; load video base in ax
	mov es, ax
	mov di,[bp+6]
	mov bx,[bp+4]
lp:  ;to print landscape line
	mov word[es:di],0x3820
	add di,2
	cmp di,bx
	jna lp

	pop es
	pop di
	pop bx
	pop ax
	pop bp
	ret 4

vertical:   ;to print in vertical line
	push bp
	mov bp,sp
	push ax
	push bx
	push di 
	push es

	mov ax, 0xb800 ; load video base in ax
	mov es, ax
	mov di,[bp+6]
	mov bx,[bp+4]
lp2:   ;to print vertical line
	mov word[es:di],0x3820
	add di,160
	cmp di,bx
	jna lp2
	pop es
	pop di
	pop bx
	pop ax
	pop bp
	ret 4
;-----------ground----------------
ground:  ;to print ground line
	push bp
	mov bp,sp             
	push ax
	push bx
	push di 
	push es

	mov ax, 0xb800 ; load video base in ax
	mov es, ax
	mov di,[bp+6]
	mov bx,[bp+4]
	mov ah,0xee
	mov al,0x20
gp:  ;to print landscape line
	mov word[es:di],ax
	add di,2
	cmp di,bx
	jna gp

	pop es
	pop di
	pop bx
	pop ax
	pop bp
	ret 4


;-----------square----------------
square:    
        push bp
	mov bp,sp             
	push ax
	push di 
	push es

        mov ax, 0xb800 ; load video base in ax
	    mov es, ax
        mov di,[bp+4]
        mov al,0x20
        mov ah,[bp+6]
       
        mov word[es:di],ax
        add di,2
        mov word[es:di],ax
        pop es
	pop di
	
	pop ax
	pop bp
	ret 4

;-----------shape1----------------    to print L shape  
shape1:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x10    ;color
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x40     ;color
        push si       
        add ax,4
        push ax
        call square

        mov si,0x20     ;color
        push si
        add ax, 4
        push ax
        call square

        mov si,0xD0     ;color
        push si 
        add ax, 160
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------shape2----------------      
shape2:    
    push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x10
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x40
        push si       
        add ax,156
        push ax
        call square

        mov si,0x20
        push si
        add ax, 4
        push ax
        call square

        mov si,0xD0
        push si
        add ax, 4
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------shape3----------------      
shape3:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x10
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x40
        push si       
        add ax,160
        push ax
        call square

        mov si,0x20
        push si
        add ax, 160
        push ax
        call square

       
        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------shape4----------------      
shape4:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x10
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x40
        push si       
        add ax,4
        push ax
        call square

        mov si,0x20
        push si
        add ax, 156
        push ax
        call square

        mov si,0xD0
        push si
        add ax, 4
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------shape5----------------   
shape5:  ;for simple square
    push bp
	mov bp,sp
	push ax
    mov ax,0
	mov ax,0x58
	push ax
    mov ax,[bp+4]
	push ax
	call square
    pop ax
	pop bp
	ret 2   

;-----------clear shape1----------------    to print L shape  
clearshape1:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x78    ;color
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x78     ;color
        push si       
        add ax,4
        push ax
        call square

        mov si,0x78      ;color
        push si
        add ax, 4
        push ax
        call square

        mov si,0x78      ;color
        push si 
        add ax, 160
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------clear shape2----------------      
clearshape2:    
    push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x78 
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x78 
        push si       
        add ax,156
        push ax
        call square

        mov si,0x78 
        push si
        add ax, 4
        push ax
        call square

        mov si,0x78 
        push si
        add ax, 4
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------clear shape3----------------      
clearshape3:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x78 
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x78 
        push si       
        add ax,160
        push ax
        call square

        mov si,0x78 
        push si
        add ax, 160
        push ax
        call square

       
        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------clear shape4----------------      
clearshape4:    
        push bp
	mov bp,sp             
	push ax
	push si
	push di 
	push es

	xor si, si
        mov si, 0x78 
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x78 
        push si       
        add ax,4
        push ax
        call square

        mov si,0x78 
        push si
        add ax, 156
        push ax
        call square

        mov si,0x78 
        push si
        add ax, 4
        push ax
        call square

        pop es
	pop di
	pop si
	pop ax
	pop bp
	ret 2
;-----------clear shape5----------------   
clearshape5:  ;for simple square
    push bp
	mov bp,sp
	push ax
	mov ax,0x78 
	push ax
    mov ax,[bp+4]
	push ax
	call square
    pop ax
	pop bp
	ret 2   

;--------------next_shape-------------------
next_shape:
   push bp
   mov bp,sp
   mov ax,0
   mov ax,2680            ;row 0x10 column 0x40
mov cx,[bp+4]
cmp cx,1
je e1
cmp cx,2
je e2
cmp cx,3
je e3
cmp cx,4
je e4
cmp cx,5
je e5
 
e1:
     push ax
    call shape1
    jmp next_shape_end
e2:
	push ax
	call shape2
	jmp next_shape_end
e3:
	push ax
	call shape3
	jmp next_shape_end
e4:
	push ax
	call shape4
	jmp next_shape_end
e5:
	push ax
	call shape5
	jmp next_shape_end


next_shape_end:
	pop bp
	ret 2
;--------------m_shape1-------------------------
m_shape1:
    push bp
	mov bp,sp
	mov cx,[bp+4]
	
cmp cx,1
	je m1_2
m1_2:
     push 2
     call next_shape
      jmp re1
re1:     
	 push word[topleft]
	 call shape1
	 
	 push word[topleft]
	 call movepixels1
mov cx,[bp+4] 
cmp cx,1
je m1_2c
m1_2c:
	push 2680
	call clearshape2
	jmp re1c
re1c:
	inc cx
m1_pop:
    pop bp
	ret 2
;--------------movepixels1-------------------
movepixels1:
        push bp
	mov bp,sp             
        push ax
        push bx
        push cx
        push si
	push di 
	push ds
        push es

        mov bx,[bp+4]

        
in1:        

        mov ah,0x01     ; to check is there any key press
	int 16h 
		
        jz sim1   ;if not then jump to simple
		
	mov ah,0x0
	int 16h 
checks1:

        cmp al,'l'
	je left_pixelmove1
	cmp al,'L'
        je left_pixelmove1
        cmp al,'r'
	je right_pixelmove1
	cmp al,'R'
	je right_pixelmove1
		
sim1:
        jmp simple1

left_pixelmove1: 


        mov di,bx 
        sub di,4        ;;;; check for block  
         
        mov ax, 0xb800 
	mov es, ax
        cmp word[es:di],0x7820
        jne kk1
        add di ,2     ;;;; check for boundary 
        cmp word[es:di],0x7820
        jne kk1
        add di ,166      ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk1
        push bx
        call delay
        call delay
        call delay
        call clearshape1 
        sub bx,4 
        push bx 
        call shape1
        jmp simple1
kk1:
     jmp simple1

right_pixelmove1: 
        
 
        mov di,bx 
        add di,12        ;;;; check for block 
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne kk1
        add di ,2     ;;;; check for boundary  
        cmp word[es:di],0x7820
        jne kk1
        add di ,158       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk1

        
        push bx
        call delay
        call delay
        call delay

        call clearshape1
        add bx,4
        push bx 
        call shape1
        jmp simple1	

simple1:
       
        cmp bx, 3046
        jnl popping1
       
        mov di,bx
        add di ,160      
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne popping1
 
     
        add di,4
        cmp word[es:di],0x7820
        jne popping1

        add di,164
        cmp word[es:di],0x7820
        jne popping1 
 
        push bx
        call delay
        call delay
        call delay

        call clearshape1
        add bx,160
        push bx
        call shape1

        jmp in1

popping1:
	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret 2
;-------------m_shape2--------------------
m_shape2:
    push bp
	mov bp,sp
	mov cx,[bp+4]
cmp cx,2
	je m2_3
	cmp cx,9
	je m2_1
m2_3:
	push 3
	call next_shape
	jmp re2
m2_1:
	push 1
	call next_shape
re2:
	push word[topleft]
	call shape2
	
	push word[topleft]
	call movepixels2 ;;; control movement of block
mov cx,[bp+4] 
	cmp cx,2
	je m2_3c
	cmp cx,9
	je m2_1c
m2_3c:
	push 2680
	call clearshape3
	jmp re2c
m2_1c:
	push 2680
	call clearshape1
re2c:
	inc cx
m2_pop:
    pop bp
	ret 2
;--------------movepixels2-------------------
movepixels2:
        push bp
	mov bp,sp             
        push ax
        push bx
        push cx
        push si
	push di 
	push ds
        push es

        mov bx,[bp+4]

        
in2:        
        mov ah,0x01     ; to check is there any key press
	int 16h 
		
        jz sim2   ;if not then jump to simple
		
	mov ah,0x0
	int 16h 
checks2:

        cmp al,'l'
	je left_pixelmove2
	cmp al,'L'
        je left_pixelmove2
        cmp al,'r'
	je right_pixelmove2
	cmp al,'R'
	je right_pixelmove2
		
sim2:
        jmp simple2

left_pixelmove2: 


        mov di,bx 
        sub di,4        ;;;; check for block  
         
        mov ax, 0xb800 
	mov es, ax
        cmp word[es:di],0x7820
        jne kk2
        add di ,158     ;;;; check for boundary 
        cmp word[es:di],0x7820
        jne kk2
        sub di ,2      ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk2
        push bx
        call delay
        call delay
        call delay
        call delay
        call clearshape2 
        sub bx,4 
        push bx 
        call shape2
        jmp simple2
kk2:
     jmp simple2

right_pixelmove2: 
        
 
        mov di,bx 
        add di,4        ;;;; check for block 
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne kk2
        add di ,166     ;;;; check for boundary  
        cmp word[es:di],0x7820
        jne kk2
        sub di ,2       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk2

        
        push bx
        call delay
        call delay
        call delay

        call clearshape2
        add bx,4 
        push bx 
        call shape2
        jmp simple2	

simple2:
       
        cmp bx, 3046
        jnl popping2
       
        mov di,bx
        add di ,320      
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne popping2
 
        add di,4
        cmp word[es:di],0x7820
        jne popping2

        sub di,8 
        cmp word[es:di],0x7820
        jne popping2  
        push bx
        call delay
        call delay
        call delay
        call delay
        call clearshape2
        add bx,160
        push bx
        call shape2
        cmp bx, 3046
        jnl popping2
        jmp in2

popping2:
	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret 2
	
;--------------m_shape3-------------------
m_shape3:
    push bp
	mov bp,sp
	mov cx,[bp+4]
	
 cmp cx,3
	je m3_4
	cmp cx,7
	je m3_5
	 cmp cx,6
	 je m3_3
m3_4:
	push 4
	call next_shape
	jmp re3
m3_5:
	push 5
	call next_shape
	jmp re3
m3_3:
     push 3
     call next_shape
re3:
	push word[topleft]
	call shape3
	
	push word[topleft]
	call movepixels3
mov cx,[bp+4] 
	cmp cx,3
	je m3_4c
	cmp cx,7
	je m3_5c
	cmp cx,6
    je m3_3c
m3_4c:
	push 2680
	call clearshape4
	jmp re3c
m3_5c:
	push 2680
	call clearshape5
		jmp re3c
m3_3c:
	push 2680
	call clearshape3	

re3c:
	inc cx
m3_pop:
    pop bp
	ret 2

;--------------movepixels3-------------------
movepixels3:
        push bp
	mov bp,sp             
        push ax
        push bx
        push cx
        push si
	push di 
	push ds
        push es
        mov bx,[bp+4] 
in3:        
        mov ah,0x01     ; to check is there any key press
	int 16h 
		
        jz sim3   ;if not then jump to simple
		
	mov ah,0x0
	int 16h 
checks3:

        cmp al,'l'
	je left_pixelmove3
	cmp al,'L'
        je left_pixelmove3
        cmp al,'r'
	je right_pixelmove3
	cmp al,'R'
	je right_pixelmove3
		
sim3:
        jmp simple3

left_pixelmove3: 
        mov di,bx 
        sub di,4        ;;;; check for block  
         
        mov ax, 0xb800 
	mov es, ax
        cmp word[es:di],0x7820
        jne kk3
        add di ,2     ;;;; check for boundary 
        cmp word[es:di],0x7820
        jne kk3
        add di ,158      ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk3
        add di ,160      ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk3
        push bx

        call delay
        call delay
        call delay
        call clearshape3 
        sub bx,4 
        push bx 
        call shape3
        jmp simple3
kk3:
     jmp simple3

right_pixelmove3: 
        
        mov di,bx 
        add di,4        ;;;; check for block 
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne kk3
        add di ,2     ;;;; check for boundary  
        cmp word[es:di],0x7820
        jne kk3
        add di ,162       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk3
        add di ,160       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk3
        
        push bx
        call delay
        call delay
        call delay
        call clearshape3
        add bx,4
        push bx 
        call shape3
        jmp simple3	
simple3:
        cmp bx, 2886
        jnl popping3
       
        mov di,bx
        add di ,480      
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne popping3
 
        push bx
        call delay
        call delay
        call delay
        call clearshape3
        add bx,160
        push bx
        call shape3
        jmp in3

popping3:
	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret 2
;--------------m_shape4-------------------
m_shape4:
    push bp
	mov bp,sp
	mov cx,[bp+4]
cmp cx,4
jne m4_pop
	push  5
	call next_shape
	push word[topleft]
	call shape4
	
	push word[topleft]
	call movepixels4
mov cx,[bp+4] 
	push 2680
	call clearshape5
	inc cx
m4_pop:
    pop bp
	ret 2
;--------------m_shape4 for simple -------------------
m_shape4_1:
    push bp
	mov bp,sp
	mov cx,[bp+4]
cmp cx,4
jne m4_pop_1
	push  3
	call next_shape
	push word[topleft]
	call shape4
	
	push word[topleft]
	call movepixels4
mov cx,[bp+4] 
	push 2680
	call clearshape3
	inc cx
m4_pop_1:
    pop bp
	ret 2
;--------------movepixels4-------------------
movepixels4:
        push bp
	mov bp,sp             
        push ax
        push bx
        push cx
        push si
	push di 
	push ds
        push es

        mov bx,[bp+4]
in4:        
        mov ah,0x01     ; to check is there any key press
		int 16h 
		jz sim4   ;if not then jump to simple
	    mov ah,0x0
	    int 16h 
checks4:

        cmp al,'l'
	je left_pixelmove4
	cmp al,'L'
        je left_pixelmove4
        cmp al,'r'
	je right_pixelmove4
	cmp al,'R'
	je right_pixelmove4
		
sim4:
        jmp simple4

left_pixelmove4: 


        mov di,bx 
        sub di,4        ;;;; check for block  
         
        mov ax, 0xb800 
	mov es, ax
        cmp word[es:di],0x7820
        jne kk4
        add di ,2     ;;;; check for boundary 
        cmp word[es:di],0x7820
        jne kk4
        add di ,158      ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk4

        push bx
        call delay
        call delay
        call delay
        call clearshape4
        sub bx,4 
        push bx 
        call shape4
        jmp simple4
kk4:
     jmp simple4

right_pixelmove4: 
        
 
        mov di,bx 
        add di,8        ;;;; check for block 
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne kk4
        add di ,2     ;;;; check for boundary  
        cmp word[es:di],0x7820
        jne kk4
        add di ,158       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk4

        
        push bx
        call delay
        call delay
        call delay
        call clearshape4
        add bx,4
        push bx 
        call shape4
        jmp simple4

simple4:
       
        cmp bx, 3046
        jnl popping4
       
        mov di,bx
        add di ,320      
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne popping4
 
        add di ,4
        cmp word[es:di],0x7820
        jne popping4

        push bx
        call delay
        call delay
        call delay
        call clearshape4
        add bx,160
        push bx
        call shape4

        jmp in4

popping4:
	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret 2
;--------------m_shape5-------------------
m_shape5:
    push bp
	mov bp,sp
	mov cx,[bp+4]
	cmp cx,5
	je m5_3
	cmp cx,8
	je m5_2
m5_3:
	push 3
	call next_shape
	jmp re5
m5_2:
    push 2
	call next_shape
re5:
	push word[topleft]
	call shape5
	
	push word[topleft]
	call movepixels5
mov cx,[bp+4] 
	cmp cx,5
	je m5_1c
	cmp cx,8
	je m5_2c
m5_1c:
	push 2680
	call clearshape3
	jmp re5c
m5_2c:
	push 2680
	call clearshape2
re5c:
	inc cx

m5_pop:
    pop bp
	ret 2
;--------------movepixels5-------------------
movepixels5:
        push bp
	mov bp,sp             
        push ax
        push bx
        push cx
        push si
	push di 
	push ds
        push es

        mov bx,[bp+4]
in5:        
        mov ah,0x01     ; to check is there any key press
	int 16h 
        jz sim5   ;if not then jump to simple
	mov ah,0x0
	int 16h 
checks5:

        cmp al,'l'
	je left_pixelmove5
	cmp al,'L'
        je left_pixelmove5
        cmp al,'r'
	je right_pixelmove5
	cmp al,'R'
	je right_pixelmove5
		
sim5:
        jmp simple5

left_pixelmove5: 


        mov di,bx 
        sub di,4        ;;;; check for block  
         
        mov ax, 0xb800 
	mov es, ax
        cmp word[es:di],0x7820
        jne kk5
        add di ,2     ;;;; check for boundary 
        cmp word[es:di],0x7820
        jne kk5
        
        push bx
        call delay
        call delay
        call delay
        call clearshape5
        sub bx,4 
        push bx 
        call shape5
        jmp simple5
kk5:
     jmp simple5

right_pixelmove5: 
        
 
        mov di,bx 
        add di,4        ;;;; check for block 
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne kk5
        add di ,2     ;;;; check for boundary  
        cmp word[es:di],0x7820
        jne kk5
        add di ,158       ;;;; check for block  
        cmp word[es:di],0x7820
        jne kk5

        
        push bx
        call delay
        call delay
        call delay

        call clearshape5
        add bx,4
        push bx 
        call shape5
        jmp simple5

simple5:
       
        cmp bx, 3206
        jnl popping5
       
        mov di,bx
        add di ,160      
        mov ax, 0xb800 ; load video base in ax
	mov es, ax
        cmp word[es:di],0x7820
        jne popping5

        push bx
        call delay
        call delay
        call delay

        call clearshape5
        add bx,160
        push bx
        call shape5

        jmp in5

popping5:
	pop es
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret 2

;--------------movement-------------------
movement:
push bp 
mov bp,sp
push ax
push di
push es

mov ax,0
mov al,0x3
push ax
mov al,0x15
push ax
push topleft
call coordinate
mov cx,3 ;move cx 3 because shapes print according to cx
found:
    call functioncombo
	cmp word[cs:minutes],5
	je finish_
	;checking end game condition

	mov ax,[topleft]
	add ax,160
	mov di,ax 
    mov ax, 0xb800 
	mov es, ax
    cmp word[es:di],0x7820  ;;;; check for white background
	jne fin_end
	 
cmp cx,1
je m1
cmp cx,2
je m2
cmp cx,3
je m3
cmp cx,4
je m4
cmp cx,5
je m5
cmp cx,6
je m3
cmp cx,7
je m3
cmp cx,8
je m5
cmp cx,9
je m2

jmp finish_

fin_end:
   jmp finish_end
finish_:
 cmp word[cs:minutes],5
 je finish_end
  

m1:
   push cx
   call m_shape1
     call sound
   cmp cx,0xa
   jl found
   cmp cx,0xa
   je finish     
m2:
    push cx
    call m_shape2
	  call sound
	cmp cx,0xa
	jl found
	cmp cx,0xa
	je finish
m3:
    push cx
    call m_shape3
	  call sound
	cmp cx,0xa
	jl found
	cmp cx,0xa
	je finish
m4:
    push cx
    call m_shape4
	  call sound
	cmp cx,0xa
	jl found
	cmp cx,0xa
	je finish
m5:
    push cx
    call m_shape5
	  call sound
	cmp cx,0xa
	jl found
	cmp cx,0xa
	je finish
	

finish:
    mov cx,1
	jmp found
finish_end:
       
pop es
pop di
pop ax
pop bp
    ret
;--------------movement1 for essay level -------------------
movement_1:
push bp 
mov bp,sp
push ax
push di
push es

mov ax,0
mov al,0x3
push ax
mov al,0x15
push ax
push topleft
call coordinate
mov cx,3 ;move cx 3 because shapes print according to cx
found1:
    call functioncombo_1
	cmp word[cs:minutes],5
	je finish_1
	;checking end game condition

	mov ax,[topleft]
	add ax,160
	mov di,ax 
    mov ax, 0xb800 
	mov es, ax
    cmp word[es:di],0x7820  ;;;; check for white background
	jne fin_end1
	 
cmp cx,3
je m3_
cmp cx,4
je m4_

jmp finish_1

fin_end1:
   jmp finish_end1
finish_1:
 cmp word[cs:minutes],5
 je fin_end1

m3_:
    push cx
    call m_shape3
	  call sound
	cmp cx,0x5
	jl found1
	cmp cx,0x5
	je finish1
m4_:
    push cx
    call m_shape4_1
	  call sound
	cmp cx,0x5
	jl found1
	cmp cx,0x5
	je finish1
finish1:
    mov cx,3
	jmp found1
finish_end1:
       
pop es
pop di
pop ax
pop bp
    ret
;-----------printstr----------------
printstr:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	push ds
	pop es 
	mov di, [bp+4] 
	mov cx, 0xffff 
	xor al, al 
	repne scasb 
	mov ax, 0xffff 
	sub ax, cx 
	dec ax
	jz exit 
	mov cx, ax 
	mov ax, 0xb800
	mov es, ax
	mov al, 80 
	mul byte [bp+8] 
	add ax, [bp+10] 
	shl ax, 1
	mov di,ax 
	mov si, [bp+4]
	mov ah, [bp+6]
	cld 
nextchar: 
	lodsb 
	stosw
	loop nextchar
exit:
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 8
printnum: 
    push bp 
    mov  bp, sp
    push es 
    push ax 
    push bx 
    push cx 
    push dx 
    push di 
    mov ax, [bp+4] 
    mov bx, 10       
    mov cx, 0       
    nextdigit: 
        mov dx, 0    
        div bx      
        add dl, 0x30 
        push dx     
        inc cx       
        cmp ax, 0   
        jnz nextdigit 
    mov ax, 0xb800 
    mov es, ax 
    mov di, [bp+6]
    nextpos: 
        pop dx    
        mov dh, 0x70   
        mov [es:di], dx 
        add di, 2 
        loop nextpos    
    pop di 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    pop es
    pop bp 
    ret 4 
;------------------rectangle----------------------
rectangle:

        push bp
	mov bp,sp
	push ax
	push cx
	push di
	push es
       
       mov di,[bp+4]
       
       mov ax,0xb800
       mov es,ax
       xor ax,ax
       mov ax,[bp+6]
       mov cx,46

printing:
       
       mov word[es:di],ax
       add di,2
       loop printing

	pop es
	pop di
	pop cx
	pop ax
	pop bp
	ret 4
;------------------	Scroll ----------------------
Scroll:
	push bp
	mov bp,sp
	push ax
	push cx
	push si
	push di
	push es
	push ds
	
	mov ax,0xb800
	mov es,ax 
	mov ds,ax 
	
	mov di,[bp+4] ;starting point of line to be removed
	add di,90 ; total 45 columns: 1 column = 2 bytes
	mov si,di
	sub si,160 ;line above the line to be removed
	
	scrollrow:
		push di
		push si
		mov cx,46 ;width
		
		std 
		rep movsw
		pop si
		pop di
		
		;moving si and di to point one row above the current positions:
		sub di,160
		sub si,160
		cmp si,0x1e6 ;0x1e6 is the starting point of out main frame
		ja scrollrow
		
	;printing top row of the main frame:
	mov ax,7820h 
	mov di,0x1e6
	mov cx,46
	cld
	rep stosw
	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 2
;------------------	functioncombo ----------------------
functioncombo:   ;that compare and add score 
	push bp
	mov bp,sp
	push ax
	push cx
	push di
	push es
	
	push 0xB800
	pop es
	mov ax,7820h 
	mov di,486		;starting point of main frame
	mov cx,18		;number of rows of main frame
	foundcompleterow:
		push di
		push cx
		mov cx,46	;width of main frame
		cld
		repne scasw
		cmp cx,0      
		pop cx
		pop di
		jne notfound  ;to chk next row without doing anything
		
       
		blinking:
		    push 0x0020
            push di
            call rectangle
            call delay
			call delay
			push 0x0020
            push di
            call rectangle
            call delay
			call delay
			
;-------------score--------------- 	 
        add word[score],10
		
		mov ax,0x446
	    push ax
	    push word[score]
	    call printnum
;--------------Scroll---------------
		push di
		call Scroll
		notfound:
		add di,160
		loop foundcompleterow
	pop es
	pop di
	pop cx
	pop ax
	pop bp
	ret	
	functioncombo_1:   ;that compare and add score 
	push bp
	mov bp,sp
	push ax
	push cx
	push di
	push es
	
	push 0xB800
	pop es
	mov ax,7820h 
	mov di,486		;starting point of main frame
	mov cx,18		;number of rows of main frame
	foundcompleterow_1:
		push di
		push cx
		mov cx,46	;width of main frame
		cld
		repne scasw
		cmp cx,0      
		pop cx
		pop di
		jne notfound_1 ;to chk next row without doing anything
		
       
		
			
;-------------score--------------- 	 
        add word[score],10
		
		mov ax,0x446
	    push ax
	    push word[score]
	    call printnum
;--------------Scroll---------------
		push di
		call Scroll
		notfound_1:
		add di,160
		loop foundcompleterow_1
	pop es
	pop di
	pop cx
	pop ax
	pop bp
	ret	
;-----------; timer interrupt service routine---------------------
timer: 
	push ax
	cmp word[cs:minutes],5
	je kl
	inc word [cs:tickcount]; increment tick count
	cmp word[cs:tickcount],18
	je update
	cmp word[cs:tickcount],18
	jne k2
update:
    mov word[cs:tickcount],0
	inc word[cs:second2]
    cmp word[cs:second2],10
	jl k2
	mov word[cs:second2],0
	inc word[cs:second1]
	cmp word[cs:second1],6	
	jne k2
	inc word [cs:minutes] 
	mov word [cs:second1],0
k2:
    mov ax,0x628
	push ax
	push word [cs:minutes]
	call printnum 
	
	mov ax,0xb800
		mov es,ax
		mov ah,0x07
		mov al,':'
		mov word[es:0x630],ax
		
    mov ax,0x632
	push ax
	push word [cs:second1]
	call printnum 
	
	 mov ax,0x634
	push ax
	push word [cs:second2]
	call printnum 
	
kl:
mov al, 0x20
out 0x20, al ; end of interrupt
pop ax
iret ; return from interrupt
;-------------------sound-----------------
sound:
push ax
push bx
push cx
mov al,182
out 43h,al
mov ax,4560	
out 42h,al
mov al,ah
out 42h,al
in al,61h	
or al,00000011b
out 61h,al
mov bx,25

pause1:
mov cx,20000

pause2:
dec cx
jne pause2
dec bx
jne pause1
in al,61h	
and al,11111100b
out 61h,al
	
pop cx
pop bx
pop ax
ret

;-----------Ist_screen_veiw----------------
front_screen:
    call background
	mov ax,0
	mov al,6
	push ax
	mov al,0x12
	push ax
	push topleft
	call coordinate
	mov al,6
	push ax
	mov al,0x3b
	push ax
	push topright
	call coordinate
	mov al,0xa
	push ax
	mov al,0x12
	push ax
	push bottomleft
	call coordinate
	mov al,0xa
	push ax
	mov al,0x3b
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	mov ax, 28
	push ax ; push x position
	mov ax, 8
	push ax ; push y position
	mov ax, 0xf4 ; blue on black attribute
	push ax
	mov ax, message
	push ax
	call printstr 
	
	mov ax, 9
	push ax ; push x position
	mov ax, 15
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, message1
	push ax
	call printstr 
	
		mov ax, 9
	push ax ; push x position
	mov ax, 17
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, message2
	push ax
	call printstr 
	
ret
;-------------EndGameGraphics-------------------
forline:
    push bp
	mov bp,sp             
	push ax
	push si
	push es

	xor si, si
        mov si, 0x40
        push si
        mov ax,[bp+4]
        push ax
        call square
        
        mov si,0x40
        push si       
        add ax,160
        push ax
        call square

        mov si,0x40
        push si
        add ax, 160
        push ax
        call square

        mov si,0x40
        push si
        add ax, 160
        push ax
        call square

        mov si,0x40
        push si
        add ax, 160
        push ax
        call square
		
    pop es
	pop si
	pop ax
	mov sp,bp
	pop bp
	ret 2
Graphics:
    push bp            
	push ax
	push si
	push es   
    
    
	xor si, si
	xor ax, ax
        mov si, 0x40 
        push si
        mov ax,2100
        push ax
        call square
        
      
        add ax,4
        push ax
        call forline

        mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		

        add ax, 8
        push ax
        call forline
		

        add ax, 12
        push ax
        call forline
		
		xor ax, ax
		mov si,0x40
        push si
        add ax, 0x986
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		

        mov ax,0x856
        push ax
        call forline
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        mov ax, 0x99a
        push ax
        call square
			
		mov si,0x40
        push si
        mov ax, 0xada
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	

		mov ax,0x86a
        push ax
        call forline
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        mov ax, 0x9ae
        push ax
        call square
			
		mov si,0x40
        push si
        add ax, 320
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square			
		
		
		mov ax,0x87a
        push ax
        call forline
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        add ax, 160
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 160
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	

		mov si,0x40
        push si
        add ax, 160
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	

		mov si,0x40
        push si
        add ax, 160
        push ax
        call square
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square			
		
		mov ax,0x88e
        push ax
        call forline
		
		mov ax,0x896
        push ax
        call forline
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        mov ax,0xb1a
        push ax
        call square	
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov si,0x40
        push si
        add ax, 4
        push ax
        call square	
		
		mov ax,0x8a6
        push ax
        call forline
		
    pop es

	pop si
	pop ax
	pop bp
	ret
;-----------End_screen_veiw----------------
end_screen:
	call clrscr
    call background
	mov ax,0      
	mov al,6
	push ax
	mov al,0x12
	push ax
	push topleft
	call coordinate
	mov al,6
	push ax
	mov al,0x2b
	push ax
	push topright
	call coordinate
	mov al,0xa
	push ax
	mov al,0x12
	push ax
	push bottomleft
	call coordinate
	mov al,0xa
	push ax
	mov al,0x2b
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	mov ax, 20
	push ax ; push x position
	mov ax, 8
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, s1
	push ax
	call printstr 
		
    call sound
	 
	mov ax, 25
	push ax ; push x position
	mov ax, 3
	push ax ; push y position
	mov ax, 0x84 ; blue on black attribute
	push ax
	mov ax, endstr
	push ax
	call printstr 

	mov ax,0x53e
	push ax
	push word[score]
	call printnum

call Graphics   ;for the end

	mov ah, 0x1   
	int 0x21 
	mov ax, 0x4c00 
	int 0x21 
;------------------------------------------------------------------------
start:

    call clrscr
	call front_screen
Repeating:
	mov ah,0x0
	int 16h 
	
    cmp al,'1'
	je easylevel
	cmp al,'2'
	jne Repeating
	jmp hard_level
;----------------------easy level-------------------
easylevel:	
	call clrscr
    call background
	mov ax,0
	mov al,0
	push ax
	mov al,0
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,0
	push ax
	mov al,0x4e
	push ax
	push topright
	call coordinate
	mov al,0x18
	push ax
	mov al,0
	push ax
	push bottomleft
	call coordinate
	mov al,0x18
	push ax
	mov al,0x4e
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line

	mov ax,0
	mov al,2
	push ax
	mov al,2
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,2
	push ax
	mov al,0x31
	push ax
	push topright
	call coordinate
	mov al,0x16
	push ax
	mov al,2
	push ax
	push bottomleft
	call coordinate
	mov al,0x16
	push ax
	mov al,0x31
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	
;--------to print ground-----------
	mov al,0x15
	push ax
	mov al,2
	push ax
	push bottomleft
	call coordinate
	mov al,0x15
	push ax
	mov al,0x31
	push ax
	push bottomright
	call coordinate
	push word[bottomleft]
	push word[bottomright]
	call ground  ;to print buttom line
	
;-----  to print border of next block ------
		
	mov ax,0
	mov al,0xd
	push ax
	mov al,0x35
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,0xd
	push ax
	mov al,0x49
	push ax
	push topright
	call coordinate
	mov al,0x16
	push ax
	mov al,0x35
	push ax
	push bottomleft
	call coordinate
	mov al,0x16
	push ax
	mov al,0x49
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	
	mov ax, 0x35
	push ax ; push x position
	mov ax, 6
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, s1
	push ax
	call printstr 
	
	mov ax, 0x35
	push ax ; push x position
	mov ax, 4
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, easyprint
	push ax
	call printstr

	mov ax,0x446
	push ax
	push word[score]
	call printnum

	mov ax, 0x35
	push ax ; push x position
	mov ax, 9
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, time_s
	push ax
	call printstr
;--------------hooking-------------------	
	xor ax, ax
	mov es, ax
	push word[es:8*4]
	push word[es:8*4+2]
	cli
	mov word [es:8*4], timer 
	mov word[es:8*4+2], cs
	sti
	mov ax, 0x35
	push ax ; push x position
	mov ax, 12
	push ax ; push y position
	mov ax, 0xf1 ; blue on black attribute
	push ax
	mov ax, next_s
	push ax
	call printstr
repeat_1:
	call movement_1
	  cli
    pop word[es:8*4+2]
	pop word[es:8*4]
    sti
	call end_screen
	jmp terminate1
loop1_:	
	cmp word[cs:minutes],5
	jb loop1_
    cli
    pop word[es:8*4+2]
	pop word[es:8*4]
    sti
	
	  call sound
    call end_screen
terminate1:

	mov ax, 0x4c00 
	int 21h 
	
;-----------Main_screen_veiw----------------
hard_level:
	call clrscr
    call background
	mov ax,0
	mov al,0
	push ax
	mov al,0
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,0
	push ax
	mov al,0x4e
	push ax
	push topright
	call coordinate
	mov al,0x18
	push ax
	mov al,0
	push ax
	push bottomleft
	call coordinate
	mov al,0x18
	push ax
	mov al,0x4e
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line

	mov ax,0
	mov al,2
	push ax
	mov al,2
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,2
	push ax
	mov al,0x31
	push ax
	push topright
	call coordinate
	mov al,0x16
	push ax
	mov al,2
	push ax
	push bottomleft
	call coordinate
	mov al,0x16
	push ax
	mov al,0x31
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	
;--------to print ground-----------
	mov al,0x15
	push ax
	mov al,2
	push ax
	push bottomleft
	call coordinate
	mov al,0x15
	push ax
	mov al,0x31
	push ax
	push bottomright
	call coordinate
	push word[bottomleft]
	push word[bottomright]
	call ground  ;to print buttom line
	
;-----  to print border of next block ------
		
	mov ax,0
	mov al,0xd
	push ax
	mov al,0x35
	push ax
	push topleft
	call coordinate
	mov ax,0
	mov al,0xd
	push ax
	mov al,0x49
	push ax
	push topright
	call coordinate
	mov al,0x16
	push ax
	mov al,0x35
	push ax
	push bottomleft
	call coordinate
	mov al,0x16
	push ax
	mov al,0x49
	push ax
	push bottomright
	call coordinate
	push word[topleft]
	push word[bottomleft]
	call vertical   ;to print left line
	push word[topright]
	push word[bottomright] 
	call vertical   ;to print right line
	push word[topleft]
	push word[topright]
	call horizontal  ;to print top line
	push word[bottomleft]
	push word[bottomright]
	call horizontal  ;to print buttom line
	
	mov ax, 0x35
	push ax ; push x position
	mov ax, 6
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, s1
	push ax
	call printstr 

	mov ax,0x446
	push ax
	push word[score]
	call printnum

	mov ax, 0x35
	push ax ; push x position
	mov ax, 9
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, time_s
	push ax
	call printstr
	
	mov ax, 0x35
	push ax ; push x position
	mov ax, 4
	push ax ; push y position
	mov ax, 0x71 ; blue on black attribute
	push ax
	mov ax, hardprint
	push ax
	call printstr
;--------------hooking-------------------	
	xor ax, ax
	mov es, ax
	push word[es:8*4]
	push word[es:8*4+2]
	cli
	mov word [es:8*4], timer 
	mov word[es:8*4+2], cs
	sti
	mov ax, 0x35
	push ax ; push x position
	mov ax, 12
	push ax ; push y position
	mov ax, 0xf1 ; blue on black attribute
	push ax
	mov ax, next_s
	push ax
	call printstr
repeat_:
	call movement
	  cli
    pop word[es:8*4+2]
	pop word[es:8*4]
    sti
	call end_screen
	jmp terminate
loop1:	
	cmp word[cs:minutes],5
	jb loop1
    cli
    pop word[es:8*4+2]
	pop word[es:8*4]
    sti
	
	  call sound
    call end_screen
terminate:

	mov ax, 0x4c00 
	int 21h 