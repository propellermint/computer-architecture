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
str1 db     "��������� ������ ���������", 0
str2 db     "������� �����:     ", 0
A DD        -1.4
B DD        +2.0
sumAB DT 0.0
;------------------------------------------------
    .code
start:

    FLD A       ;��������� � ������� ����� ST0 ����� � �� ������
    FXTRACT     ;��������� �������� (� ST0) � ������� (� ST1)
    FXCH        ;����� ����������� ��������� ST0 � ST1
    FADD B      ;�������� ST0 � ������ �
    FXCH        ;����� ����������� ��������� ST0 � ST1
    FSCALE      ;���������� ST0= ST0?2ST1
    FSTP sumAB  ;���������� � ������ ����������

invoke FpuFLtoA, addr sumAB, 5, addr str2+16, SRC1_REAL or SRC2_DIMM or STR_SCI
invoke MessageBox, 0, addr str2, addr str1, MB_OK
invoke ExitProcess, NULL
end start       ;����� ���������