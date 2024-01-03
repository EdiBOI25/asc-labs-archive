nasm -fobj main.asm
nasm -fobj read_strings.asm
nasm -fobj find_substring.asm
alink main.obj read_strings.obj find_substring.obj -oPE -subsys console -entry start
main.exe