.586                    ;директива использования системы команд процессора Intel.586 
.xmm                    ;директива использования технологии xmm
.model flat, stdcall
    option casemap :none
    include \masm32\include\windows.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
    include \masm32\include\debug.inc
    includelib \masm32\lib\debug.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib
;-----------------------------------------


.data

    vect1 dd 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0
    vect2 dd 5.0, 6.0, 7.0, 8.0, 1.0, 2.0, 3.0, 4.0
    bcd1 db 4 dup(0)
    bcd2 db 4 dup(0)
;-----------------------------------------

.code

    start:
    
        movaps XMM0, vect1          ; копирование в векторный регистр ХММ0 содержимого памяти, размером 128 бит (16 Байт),
                                        ; начиная с адреса vect1, данные интерпретируются как коды ЧПЗ одинарной точности (SP)
        movaps XMM1, vect1+16       ; копирование в ХММ1 четырёх ЧПЗ(SP) 16 Байт памяти, начиная с адреса vect1+16
        movaps XMM2, vect2
                                        
        movaps XMM3, vect2+16       
        subps XMM0, XMM3            ;сложение двух векторов из четырёх элементов ЧПЗ(SP) поэлементно:
        movss bcd1, XMM0                                 ; ХММ0[0?31]=XMM0[0?31]+XMM1[0?31] … ХММ0[96?127]=XMM0[96?127]+XMM1[96?127]
        addps XMM1, XMM2
        movss bcd1, XMM1            ; копирование скалярного ЧПЗ(SP) = одного младшего элемента вектора из регистра ХММ0
                                        ; в память по адресу bcd1, данные интерпретируются как простая последовательность байтов, которые в
                                            ; дальнейшем можно будет использовать по усмотрению программиста (например, как отдельные BCD-цифры)
        invoke ExitProcess, NULL
        
    end start ; окончание программы