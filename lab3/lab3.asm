.686
.model flat, stdcall, c

option casemap: none
ExitProcess PROTO STDCALL :DWORD
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
wsprintfA PROTO C :VARARG
.data
	TitleMsg db '3 ����',0 
	buffer db 128 dup(0) ; ��������� ����� ��� ���������������� ������
	format db '1 ��������� = %d ||  2 ��������� = %d', 0 ; ��������� ������ ������� �� �������������� ��������
	; ������ �������� ������

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

	push z3 ; ����� ��������� � ����
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
	push y1 ; ����� ��������� � ����
	call Procedure2
	add esp, 4 ; ����������� 4 ����� �����
	push 0

	invoke wsprintfA, addr buffer, addr format, y, y2 ; ��������� ������ ������ �� ��������� �������
	invoke MessageBoxA, 0, ADDR buffer, ADDR TitleMsg,0 ; ������� ��������� � ���������� ����
	call ExitProcess


Procedure1 proc ;���������� � ������� stdcall
	mov eax, [esp + 4] ; ������� � EAX ������ ��������
	mov edx, [esp + 8] ; ������� � EDX ������ ��������
	mov ebx, [esp + 12] ; ������� � EBX ������ ��������

	cmp eax, 1
	jge m1 ; ���� ������ ��� ����� 1, �� ������ �� ����� m1
	cmp edx, 1
	jge m2 ; ���� ������ ��� ����� 1, �� ������ �� ����� m2
	cmp ebx, 1
	jge m3 ; ���� ������ ��� ����� 1, �� ������ �� ����� m3
	jl m4 ; ���� ������ 1, �� ������ �� ����� m4

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
	ret 12 ;���������, ��� ���� ���������� 12 ���� �����

Procedure1 endp

Procedure2 proc ;���������� � ������� cdecl
	mov eax, [esp + 4] ; ������� � EAX ������ ��������
	mov edx, [esp + 8] ; ������� � EDX ����� ����������

	cmp eax, 0
	jg m1 ; ���� ������ 0, �� ������ �� ����� m1
	mov eax, 182 ;
	jmp konec

	m1: 
		mov eax, 255
		jmp konec

	konec:
	mov [edx], eax ; ���������� ��������� �� ������ � EDX
	ret

Procedure2 endp

end program