bits 32

global _find_substring
extern _printf

segment data use32 public data
    substring_address dd -1
    otherstring_address dd -1
    length_sub dd -1
    
segment code use32 public code
; find_substring(substring, otherstring)
_find_substring:
    push ebp
    mov ebp, esp
    sub esp, 12 ; rezervam 4*3 octeti in stiva pt variabilele locale
    
    mov eax, [ebp + 8] ; substring
    mov [substring_address], eax
    mov eax, [ebp + 12] ; otherstring
    mov [otherstring_address], eax
    
    
    ; find length of substring
    mov eax, 0
    mov esi, [substring_address]
    substr_len:
        cmp byte [esi], 0
        je after_substr_len
        add eax, 1
        add esi, 1
        jmp substr_len
        
    after_substr_len:
        mov [length_sub], eax
        
        
    ; searches in segment of string2 starting from edx
    mov edx, [otherstring_address]
    search:
        cmp byte [edx], 0 ; check if we are at the end of string2
        je substring_not_found
        mov esi, [substring_address] ; esi = address of string1
        mov edi, edx ; edi = address of string2 starting from the character pointed by edx
        mov ecx, 0
        mov ecx, [length_sub]
        jecxz after_sub_loop
        sub_loop:
            mov ebx, [esi]
            mov eax, [edi]
            cmp al, bl ; check if characters are equal
            jne after_sub_loop
            add esi, 1
            add edi, 1
            loop sub_loop
        jmp substring_found
        after_sub_loop:
        add edx, 1 ; start from next character
        jmp search
    
    substring_found:
        mov eax, 1
        jmp final
        
    substring_not_found:
        mov eax, 0
    


final:
    add esp, 12
    mov esp, ebp
    pop ebp
    ret