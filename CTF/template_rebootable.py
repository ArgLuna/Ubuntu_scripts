#!/usr/bin/python2

from pwn import *

# running configs
local = True
local = False
env_var = {'LD_PRELOAD' : './libc.so.6'}
enable_env = False
#enable_env = True
enable_gdb = True
enable_gdb = False
elf = './'
host = 'csie.ctf.tw'
port = 11008

def boot():
    if local == True:
        if enable_env == False:
            r = process(elf)
        else:
            r = process(elf, env = env_var)
    else:
        r = remote(host, port)
    return r

def gdbat(r, auto_key_in = ''):
    if local == True and enable_gdb == True:
        if len(auto_key_in) > 0:
            gdb.attach(r, auto_key_in)
        else:
            gdb.attach(r)

def wait(isLocal = local, msg = 'pause', stime = 0.2):
	if isLocal == True:
		raw_input(msg)
	else:
		time.sleep(stime)

def padtoN(string, size, char = '\x00'):
	return string.ljust(size, char)

# plt & got

# main

# rop gadgets

# lib offsets
libc_base = 0
if local and enable_env == False:
    libc = ELF('./libc.so.6.local')
else:
    libc = ELF('./libc.so.6')
# code offsets

# plt, got
got = 0     # <_GLOBAL_OFFSET_TABLE_> offset

# other

# start!
while True:
	r = boot()
	gdbat(r)
	wait()

	payload = ''
	payload += ''

	r.send(payload)
	wait()
	r.close()
	break

r.interactive()
