.386
.model flat, stdcall
option casemap :none ; case sensitive
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\fpu.inc ;
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\fpu.lib ;

;----------------------------------

    .data
str1 db     "Результат работы программы", 0
str2 db     "дробное число:     ", 0
A DD        -1.4
B DD        +2.0
sumAB DT 0.0
;------------------------------------------------
    .code
start:

    FLD A       ;занесение в вершину стека ST0 числа А из памяти
    FXTRACT     ;выделение мантиссы (в ST0) и порядка (в ST1)
    FXCH        ;обмен содержимого регистров ST0 и ST1
    FADD B      ;сложение ST0 с числом В
    FXCH        ;обмен содержимого регистров ST0 и ST1
    FSCALE      ;вычисление ST0= ST0?2ST1
    FSTP sumAB  ;сохранение в памяти результата

invoke FpuFLtoA, addr sumAB, 5, addr str2+16, SRC1_REAL or SRC2_DIMM or STR_SCI
invoke MessageBox, 0, addr str2, addr str1, MB_OK
invoke ExitProcess, NULL
end start       ;Конец программы