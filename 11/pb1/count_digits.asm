bits 32

segment code use32 public code

global count_digits
count_digits:
    mov eax, [esp + 4]
    
    ; check if number is 0
    cmp eax, 0
    jne .not_zero
    mov ebx, 1
    jmp final
    
    .not_zero:
    mov ebx, 0 ; digits counter
    .digits_loop:
        cmp eax, 0 ; check if number reached 0
        je final
        
        mov edx, 0 ; number is in edx:eax
        mov ecx, 10
        div ecx
        
        inc ebx
        
        jmp .digits_loop

final:
    mov eax, ebx ; method returns digits number in eax
    ret 4