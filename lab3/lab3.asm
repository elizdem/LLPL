.686
.model flat, stdcall, c

option casemap: none
ExitProcess PROTO STDCALL :DWORD
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
wsprintfA PROTO C :VARARG
.data
	TitleMsg db '3 лаба',0 
	buffer db 128 dup(0) ; указываем буфер для форматированного вывода
	format db '1 процедура = %d ||  2 процедура = %d', 0 ; указываем строку формата со спецификациями форматов
	; задаем исходные данные

	a dd -5
	b dd 0
	z1 dd ?
	z2 dd ?
	z3 dd ?
	y dd ?

	a1 dd 15
	a2 dd 2
	y1 dd ?
	y2 dd ?

.code
program:

	mov eax, a
	add eax, b
	mov z1, eax

	mov eax, a
	sub eax, b
	mov z2, eax

	mov eax, a
	add eax, b
	mov ebx, -1
    imul ebx
	mov z3, eax

	push z3 ; кладём параметры в стек
	push z2
	push z1
	call Procedure1
	mov y, eax 
	push 0

	push offset y2
	mov eax, a1
	add eax, a2
	mov ebx, 10
	cdq
    idiv ebx
	mov y1, eax
	push y1 ; кладём параметры в стек
	call Procedure2
	add esp, 4 ; освобождаем 4 байта стека
	push 0

	invoke wsprintfA, addr buffer, addr format, y, y2 ; формируем строку вывода по заданному формату
	invoke MessageBoxA, 0, ADDR buffer, ADDR TitleMsg,0 ; выводим результат в диалоговое окно
	call ExitProcess


Procedure1 proc ;соглашения о вызовах stdcall
	mov eax, [esp + 4] ; заносим в EAX первый параметр
	mov edx, [esp + 8] ; заносим в EDX второй параметр
	mov ebx, [esp + 12] ; заносим в EBX третий параметр

	cmp eax, 1
	jge m1 ; если больше или равно 1, то уходим на метку m1
	cmp edx, 1
	jge m2 ; если больше или равно 1, то уходим на метку m2
	cmp ebx, 1
	jge m3 ; если больше или равно 1, то уходим на метку m3
	jl m4 ; если меньше 1, то уходим на метку m4

	m1:
		mov eax, 0
		jmp konec
	m2:
		mov eax, 1
		jmp konec
	m3:
		mov eax, 2
		jmp konec
	m4:
		mov eax, 3
		jmp konec

	konec:
	ret 12 ;указываем, что надо освободить 12 байт стека

Procedure1 endp

Procedure2 proc ;соглашения о вызовах cdecl
	mov eax, [esp + 4] ; заносим в EAX первый параметр
	mov edx, [esp + 8] ; заносим в EDX адрес результата

	cmp eax, 0
	jg m1 ; если больше 0, то уходим на метку m1
	mov eax, 182 ;
	jmp konec

	m1: 
		mov eax, 255
		jmp konec

	konec:
	mov [edx], eax ; записываем результат по адресу в EDX
	ret

Procedure2 endp

end program