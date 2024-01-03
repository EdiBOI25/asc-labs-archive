; Checks if string1 is a substring of string2
; find_substring(string1, string2, found)
; returns 0 or 1 (false or true) in FOUND

bits 32

segment data use32
    found_address dd -1
    string1_address dd -1
    string2_address dd -1
    length1 dd -1

segment code use32 public code
global find_substring

find_substring:
    mov eax, [esp + 12]
    mov [found_address], eax ; address of found variable in main
    mov eax, [esp + 8]
    mov [string2_address], eax
    mov eax, [esp + 4]
    mov [string1_address], eax ; addresses of strings
    
    ; find length of string1
    mov eax, 0
    mov esi, [string1_address]
    str1_len:
        cmp byte [esi], 0
        je after_str1_len
        add eax, 1
        add esi, 1
        jmp str1_len
        
    after_str1_len:
        mov [length1], eax
    
    ; searches in segment of string2 starting from edx
    mov edx, [string2_address]
    search:
        cmp byte [edx], 0 ; check if we are at the end of string2
        je substring_not_found
        mov esi, [string1_address] ; esi = address of string1
        mov edi, edx ; edi = address of string2 starting from the character pointed by edx
        mov ecx, 0
        mov ecx, [length1]
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
        mov eax, 0
        mov eax, [found_address]
        mov [eax], dword 1
        jmp final
        
    substring_not_found:
        mov eax, 0
        mov eax, [found_address]
        mov [eax], dword 0
    
final:
    ret 3 * 4
    