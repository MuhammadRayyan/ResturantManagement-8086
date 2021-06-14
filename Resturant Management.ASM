.model small
.stack 100h
.data
;login details
pass1 db 'admin$'
pass2 db 'admin$'
pass3 db 'Incorrect Pass$'

;Main page after login
menu db '------- Welcome TO Resturant Management -------$'
menu1 db 'Press 1 for Rice$'
menu2 db 'Press 2 for Seafood$'
menu3 db 'Press 3 for Salad$'
menu4 db 'Press 4 to Show Bill$'
menu5 db 'Press 5 Pay Bill$'
menu6 db 'Press 6 to exit$'

msg1 db 'Full$'
msg2 db 'Wrong input$'
msg3 db 'seafood$'
msg4 db 'salad$'
msg5 db 'record$'
msg6 db 'there is more space$'
msg7 db 'the total amount is: $'
msg8 db 'Total Dishes: $'
msg9 db 'Rice Dishes: $'
msg10 db 'Seafood Dishes: $'
msg11 db 'Salad Dishes: $'
msg12 db ' BILL PAID $'
amount dw 0
count dw  '0'
am1 dw ?
am2 dw ?
am3 dw ?


r dw '0'
c db '0'
b db '0'
.code
main proc

Mov ax,@data
Mov ds, ax
mov es,ax
lea si,pass1
lea di,pass2
mov cx,4
rep cmpsb

jne not_equal

jmp l1
not_equal:
lea dx,pass3
jmp l1
l1:
mov ah,09 
int 21h


;-------------------------------


while_:   

;MENU
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu1
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu2
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu3
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu4
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset menu5
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu6
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h




;INPUT:

mov ah,1
int 21h
mov bl,al
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

;COMPARE:
mov al,bl
cmp al,'1'
je rice
cmp al,'2'
je seafood
cmp al,'3'
je salad
cmp al,'4'
je bill
cmp al,'5'
je payment
cmp al,'6'
je end_


mov dx,offset msg2
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
jmp while_

rice:
call ricee

seafood:
call seafoodd

salad:
call saladd

bill:
call bill_

payment:
call paid





end_:
mov ah,4ch
int 21h
main endp


;           -----------rice
ricee proc
cmp count,'8'
jle rice1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

rice1:
mov ax,200
add amount, ax
mov dx,0
mov bx,10 
mov cx,0
l2:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne l2
   
l3:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop l3
;mov am1,dx
inc count
;mov dx,count
inc r

jmp while_
jmp end_


;          -----------seafood
seafoodd proc
cmp count,'8'
jle seafood1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

seafood1:
mov ax,300
add amount, ax
mov dx,0
mov bx,10
mov cx,0
l22:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
       jne l22
   
l33:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop l33

inc count
inc c
jmp while_
jmp end_



;            -----------salad
saladd proc
cmp count,'8'
jle salad1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

salad1:
mov ax,400
add amount, ax
mov dx,0
mov bx,10
mov cx,0
lp2:
 div bx
 push dx
 mov dx,0
 mov ah,0
 inc cx
 cmp ax,0
 jne lp2
   
 lp3:
  pop dx
  add dx,48
  mov ah,2
  int 21h
 loop lp3

inc count
inc b
jmp while_
jmp end_


;------------------------------------- Total Bill
bill_ proc
mov dx,offset msg7
mov ah,9
int 21h


mov ax, amount

mov dx,0
mov bx,10
mov cx,0
push:
 div bx
 push dx
 mov dx,0

 inc cx
 cmp ax,0
 jne push
    
 print:
  pop dx
  add dx,48
  mov ah,2
  int 21h
loop print



mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset msg8
mov ah,9
int 21h

mov dx,count
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset msg9
mov ah,9
int 21h

mov dx,r
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

mov dx,offset msg10
mov ah,9
int 21h


mov dl,c
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset msg11
mov ah,9
int 21h

mov dl,b
mov ah,2
int 21h

jmp while_
jmp end_

; -----------------------------------Bill Paying:
paid proc
mov r,'0'
mov c,'0'
mov b,'0'
mov amount,0

mov count,'0'
mov dx,offset msg12
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

jmp while_
jmp end_

end main
