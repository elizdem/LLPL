.686p
.model flat, stdcall
option casemap: none
ExitProcess PROTO STDCALL :DWORD
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
wsprintfA PROTO C :VARARG
.data
	TitleMsg db '1 �������',0 
	buffer db 128 dup(0); ��������� ����� ��� ���������������� ������
	format db '(%d * %d) + ((%d - %d) / %d) + %d = %d', 0  ; ��������� ������ ������� �� �������������� ��������
	; ������ �������� ������
	mem1 dd 3
	mem2 dd 5
	mem3 dd 1982
	mem4 dd 1857
	mem5 dd 25
	mem6 dd 497
	tmp  dd ?
.code
program:
	mov eax, mem3 ; ��������� � ������� eax �������� ������ mem3
	sub eax, mem4 ; 1982-1857 = 125
	cdq ; ��������� �������� � eax �� edx:eax
	mov ebx, mem5
	idiv ebx  ; 125/25 = 5
	add eax, mem6 ; 5+497 = 502
	mov tmp, eax
	mov eax, mem1
	mov ebx, mem2
	imul ebx ; 5*3 = 15
	add eax, tmp ; 502+15 = 517

	invoke wsprintfA, addr buffer, addr format, mem1, mem2, mem3,mem4, mem5, mem6, eax ; ��������� ������ ������ �� ��������� �������
	invoke MessageBoxA, 0, ADDR buffer, ADDR TitleMsg,0 ; ������� ��������� � ���������� ����
	invoke ExitProcess,0
end program