nasm -fobj lab11_proc_main.asm
nasm -fobj factorial.asm
alink lab11_proc_main.obj factorial.obj -oPE -subsys console -entry start
lab11_proc_main.exe
