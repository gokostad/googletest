#!/usr/bin/env python

import linecache
import struct
import subprocess
import sys
from optparse import OptionParser


def get_LR_instruction(MSP, LR):
    offset = LR
    if offset > 2**31:
        offset = -(2**32 - LR)
    return MSP + 20 + offset


def read_address(filename, LR_instruction):
    instruction = LR_instruction & 0x0000FFFF
    with open(filename, 'rb') as f:
        f.seek(instruction)
        s = f.read(2)
        s = struct.pack('<H', struct.unpack('>H', s)[0])
        address = s.encode('hex')
    return address


def source_code(fname, lnumber):
    N = 5
    for l in range(lnumber - N, lnumber + N):
        sys.stdout.write("{linenumber}: {linecontent}".format(linenumber=l, linecontent=linecache.getline(fname, l)))


def process(outfile, ramfile, MSP, LR, PC):
    print "======== Information extracted with program counter ======="
    print 'PC %s' % hex(PC)
    cmd = "arm-none-eabi-objdump -l -D %s | grep -F5 -B5 '%s'" % (outfile, '%x' % PC)
    stdout = subprocess.Popen(cmd, stdin=subprocess.PIPE, shell=True)
    stdout.communicate(b"\n")
    print stdout
    print ''

    print "======== Information extracted from stack (can be corrupted) ======="
    LR_instruction = get_LR_instruction(MSP, LR)
    print 'MSP: %s, LR: %s ==> return address: %s' % (hex(MSP), hex(LR), hex(LR_instruction))
    address = read_address(ramfile, LR_instruction)
    cmd = ['arm-none-eabi-addr2line', '-e', outfile, address]
    stdout = subprocess.check_output(cmd)
    (sourcefile, linenumber) = stdout.split(':')
    print 'Return address is in file %s, line %s' % (sourcefile, linenumber)
    source_code(sourcefile, int(linenumber))

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option('--file', dest='outfile', help='ELF filename, i.e. wearable-radio.out')
    parser.add_option('--data', dest='ramfile', help='RAM1 filename, i.e. ram1.bin')
    parser.add_option('--msp', dest='MSP', help='MSP value, i.e. 0x20007de8')
    parser.add_option('--lr', dest='LR', help='LR value, i.e. 0xfffffff1')
    parser.add_option('--pc', dest='PC', help='PC value, i.e. 0x12b40')

    (options, args) = parser.parse_args()

    mandatories = ['outfile', 'ramfile', 'MSP', 'LR', 'PC']
    for m in mandatories:
        if not options.__dict__[m]:
            print "Mandatory option(s) are missing\n"
            parser.print_help()
            exit(-1)

    process(options.outfile,
            options.ramfile,
            int(options.MSP, 16),
            int(options.LR, 16),
            int(options.PC, 16))
