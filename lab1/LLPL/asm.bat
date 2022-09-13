@echo off
MY_SDK\ml.exe /c %1.asm
MY_SDK\link.exe /DEFAULTLIB:MY_SDK\kernel32.Lib /DEFAULTLIB:MY_SDK\User32.Lib /DEFAULTLIB:MY_SDK\Gdi32.Lib /SUBSYSTEM:WINDOWS %1.obj
if exist %1.obj del %1.obj
dir %1.*
pause