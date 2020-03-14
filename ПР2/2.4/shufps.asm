.586                                   ;��������� ������������� ������� ������ ���������� Intel.586
.xmm                                   ;��������� ������������� ���������� xmm
.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\debug.inc
includelib \masm32\lib\debug.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
;---------------------------------------


 .data
 vect1 dd 1.5, 2.8, 0.8, 4.0, 5.0, 6.0, 7.0, 8.0
vect2 dd 1.5, 2.8, 0.7, 4.0, 5.0, 6.0, 7.0, 8.0
bcd1 db 4 dup(0)
bcd2 db 4 dup(0)
    


.code
start:
movaps XMM0, vect1 ; ����������� � ��������� ������� ���0 ����������� ������, �������� 128 ��� (16 ����),
; ������� � ������ vect1, ������ ���������������� ��� ���� ��� ��������� �������� (SP)
movaps XMM1, vect2
shufps XMM1, XMM1, 10101010b
shufps XMM1, XMM1, 00011011b
movaps XMM0, vect1+16 ; ����������� � ���1 ������ ���(SP) 16 ���� ������, ������� � ������ vect1+16
movaps XMM1, vect2+16 
addps XMM0, XMM1 ;�������� ���� �������� �� ������ ��������� ���(SP) �����������:
 ; ���0[0?31]=XMM0[0?31]+XMM1[0?31] � ���0[96?127]=XMM0[96?127]+XMM1[96?127]
movss bcd1, XMM0 ; ����������� ���������� ���(SP) = ������ �������� �������� ������� �� �������� ���0
 ; � ������ �� ������ bcd1, ������ ���������������� ��� ������� ������������������ ������, ������� �
 ; ���������� ����� ����� ������������ �� ���������� ������������ (��������, ��� ��������� BCD-�����)
invoke ExitProcess, NULL
end start; ��������� ���������