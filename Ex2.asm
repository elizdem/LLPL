.686p
.model flat, stdcall
option casemap: none
ExitProcess PROTO STDCALL :DWORD
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
wsprintfA PROTO C :VARARG
.data
	TitleMsg db '2 задание',0 
	buffer db 128 dup(0) ; указываем буфер для форматированного вывода
	format db '(%d - %d) * ((%d - %d) / (%d - %d)) + (%d - %d)*(%d * %d) = %d', 0 ; указываем строку формата со спецификациями форматов
	; задаем исходные данные
	mem1 dd 12
	mem2 dd 7
	mem3 dd 1920
	mem4 dd 820
	mem5 dd 120
	mem6 dd 10
	mem7 dd 14
	tmp  dd ?
	mult  dd ?
.code
program:
	mov eax, mem5 
	sub eax, mem6 ; 120-10 = 110
	mov tmp, eax
	mov eax, mem3  ;загружаем в регистр eax значение ячейки mem3
	sub eax, mem4 ; 1920-820 = 1100
	cdq ; расширяем значение в eax на edx:eax
	idiv tmp ; 1100/110 = 10
	mov tmp, eax

	mov eax, mem1
	sub eax, mem2 ; 12-7 = 5
	imul tmp ; 5*10 = 50
	mov tmp, eax

	mov eax, mem1
	sub eax, mem6 ; 12-10 = 2
	mov mult, eax

	mov eax, mem1
	mov ebx, mem7
	imul ebx ; 12*14 = 168
	imul mult ; 168*2 = 336
	add eax, tmp ; 336+50 = 386

	invoke wsprintfA, addr buffer, addr format, mem1, mem2, mem3,mem4, mem5, mem6, mem1, mem6, mem1, mem7, eax ; формируем строку вывода по заданному формату
	invoke MessageBoxA, 0, ADDR buffer, ADDR TitleMsg,0 ; выводим результат в диалоговое окно
	invoke ExitProcess,0
end program