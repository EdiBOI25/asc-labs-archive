nasm -fobj main.asm
nasm -fobj count_digits.asm
alink main.obj count_digits.obj -oPE -subsys console -entry start
main.exe