; ----------------------------------------------
; This program takes input and outputs it.
; For x86 only (not arm)
;
; By: Aidan Lalonde-Novales
; Version: 1.2
; Since: 2022-11-25
; ----------------------------------------------

section .bss
  variable: RESD 1             ; 4 bytes

section .data
  newline db 10                               ; represents new line character
  enterNum: db "Enter a 2 Digit Number: "     ; first line to be printed
  enterNumLen: equ $-enterNum                 ; length of enterNum line
  returnNum: db "The number is: "             ; second line to be printed
  returnNumLen: equ $-returnNum               ; length of returnNum line
  done: db "Done.", 10                        ; ending line
  doneLen: equ $-done                         ; length of done

section .text
  global_start:                 ; entry point for linker

  _start:
    ; print first line
    mov rax, 1                 ; sys_write
    mov rdi, 1                 ; stdout
    mov rsi,enterNum           ; line to write
    mov rdx,enterNumLen        ; line length
    syscall                    ; call kernal

    ; read 4 bytes from stdin
    mov rax, 3                 ; sys_read
    mov rdx, 0                 ; read from standard input
    mov rcx, variable          ; address of number to input
    mov rdx, 4                 ; number of bytes
    int 0x80                   ; call the kernal

    ; print new line
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; print second line
    mov rax, 1                 ; sys_write
    mov rdi, 1                 ; stdout
    mov rsi,returnNum          ; line to write
    mov rdx,returnNumLen       ; line length
    syscall                    ; call kernal

    ; print 4 bytes to stdout
    mov rax, 4                 ; the system interprets 4 as "write"
    mov rbx, 1                 ; print from standard output
    mov rcx, variable          ; pointer to value being passed
    mov rdx, 4                 ; byte length of output
    int 0x80                   ; call the kernal

    ; print new line
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; print done
    mov rax, 1                 ; sys_write
    mov rdi, 1                 ; stdout
    mov rsi,done               ; line to write
    mov rdx,doneLen            ; line length
    syscall                    ; call kernal

    ; end program
    mov  rax,60       ; sys_exit
    mov  rdi,0        ; error_code 0 (success)
    syscall           ; call kernal
