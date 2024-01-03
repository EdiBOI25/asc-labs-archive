bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32
    s1 db 'B', 'C', 'E', 'F', 'H'
    len1 equ $ - s1
    s2 db 'A', 'D', 'G'
    len2 equ $ - s2
    s3 times len1+len2 db 0
    format db '%c, ', 0


segment code use32
start:
    mov ecx, len1+len2
    mov eax, 0
    mov edx, 0
    mov esi, 0 ; for s1
    mov edi, 0 ; for s2
    mov ebx, 0 ; for s3
    cmp ecx, 0
    je final
    interclasare_loop:
        mov al, [s1 + esi]
        mov dl, [s2 + edi]
        
        cmp al, dl
        ja insert_from_s2
        
        insert_from_s1:
            mov [s3 + ebx], al
            inc ebx
            inc esi
            jmp after_insert
        
        insert_from_s2:
            mov [s3 + ebx], dl
            inc ebx
            inc edi
        
        after_insert:
            cmp ebx, len1+len2
            je print_result
            
            cmp esi, len1
            je add_rest_from_s2
            
            cmp edi, len2
            je add_rest_from_s1
            
        
        loop interclasare_loop
        
    add_rest_from_s1:
        mov al, [s1 + esi]
        mov [s3 + ebx], al
        inc ebx
        inc esi
        cmp ebx, len1+len2
        je print_result
        cmp esi, len1
        je print_result
        jmp add_rest_from_s1
        
    add_rest_from_s2:
        mov al, [s2 + edi]
        mov [s3 + ebx], al
        inc ebx
        inc edi
        cmp ebx, len1+len2
        je print_result
        cmp edi, len2
        je print_result
    
    
    print_result:
    ; print s3
    mov ecx, len1+len2
    mov esi, 0
    print_loop:
        push ecx
        mov eax, 0
        mov al, [s3 + esi]
        push eax
        push dword format
        call [printf]
        add esp, 8
        pop ecx
        inc esi
        loop print_loop
    

final:
    push dword 0
    call [exit]