.686p
.model flat, stdcall
option casemap : none
ExitProcess PROTO STDCALL :DWORD 
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD 
.data
TextMsg db '��� ������ ��������� ��� Win32',0
TitleMsg db '���� ���������� Masm32!',0
.const
MB_OK equ 0
.code
start:
push MB_OK
push offset TitleMsg
push offset TextMsg
push 0
call MessageBoxA
push 05
call ExitProcess
end start