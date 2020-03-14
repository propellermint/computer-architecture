;---- configurations ---------------------------------------------------
.386                  ; assemble instructions up to 386 instruction sets
.model flat, stdcall  ; 32-bit memory model (flat memory model)
option casemap:none   ; case sensitive

include \masm32\include\windows.inc
include \masm32\macros\macros.asm

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\fpu.inc ;
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\fpu.lib ;

;---- section read/write data ------------------------------------------
;��������� ������� ����� S � �������� min(�,�). �������������� �������� fldpi (Intel). 
    ;��������� S ��������� � ������ ��� ����� ����������.
.data

a   dd 50.0
b   dd 25.0
s   dt 0

str1 db "1-�� ����� ������, ������� �����:   ",0
str2 db "2-�� ����� �����e, ������� �����:   ",0
str3 db "��������� ������ ���������",0
str4 db "����� �����, ������� �����:   ",0


;---- section instruction codes ----------------------------------------
.code

_start:

finit                            ;reset fpu stacks to default
    FLD    dword ptr [b] ;single_value2 to fpu stack(st1)
    FLD    dword ptr [a] ;single_value1 to fpu stack(st0)
    FCOM                             ;compare st0 with st1
    FSTSW  ax                        ;ax := fpu status register

    AND    EAX, 0100011100000000B ;take only condition code flags
    CMP    EAX, 0000000000000000B ;is st0 > source ? 
    JE     example_11_greater
    
    CMP    EAX, 0000000100000000B ;is st0 < source ?
    JE     example_11_less
    
    CMP    EAX, 0100000000000000B ;is st0 = source ?
    JE     example_11_equal
    
    JMP    example_11_error      ;else, st0 or source are undefined
 

example_11_greater:
    FLD     dword ptr [a]   ;;��������� � FPU ������ �����
    FLD     ST              ;st(1)=st(0)
    FMULP   ST(1),ST        ;�������� ������� ������� st(0)=st(0)*st(1)
    FLDPI                   ;��������� ����� ��  
    FMULP   ST(1),ST        ;����������� �� �� ������� �������
    FSTP    s               ;��������� ��������� � �������� FPU
    invoke FpuFLtoA, addr  s, 7, addr str1+32, SRC1_REAL or SRC2_DIMM or STR_REG
    invoke MessageBox, 0, addr str1, addr str3, MB_OK
    jmp    _exit

example_11_less:
    FLD     dword ptr [b]   ;;��������� � FPU ������ �����
    FLD     ST              ;st(1)=st(0)
    FMULP   ST(1),ST        ;�������� ������� ������� st(0)=st(0)*st(1)
    FLDPI                   ;��������� ����� ��  
    FMULP   ST(1),ST        ;����������� �� �� ������� �������
    FSTP    s               ;��������� ��������� � �������� FPU
    invoke FpuFLtoA, addr  s, 7, addr str2+32, SRC1_REAL or SRC2_DIMM or STR_REG
    invoke MessageBox, 0, addr str2, addr str3, MB_OK
    jmp    _exit

example_11_equal:
    FLD     dword ptr [a]   ;;��������� � FPU ������ �����
    FLD     ST              ;st(1)=st(0)
    FMULP   ST(1),ST        ;�������� ������� ������� st(0)=st(0)*st(1)
    FLDPI                   ;��������� ����� ��  
    FMULP   ST(1),ST        ;����������� �� �� ������� �������
    FSTP    s               ;��������� ��������� � �������� FPU
    invoke FpuFLtoA, addr  s, 5, addr str4+32, SRC1_REAL or SRC2_DIMM or STR_REG
    invoke MessageBox, 0, addr str4, addr str3, MB_OK
    jmp    _exit

example_11_error:
    print chr$("st(0) and source are undefined!", 0aH, 00H)


_exit:
    invoke ExitProcess, 0

end _start

