#!/usr/bin/python
import sys
import socket

if len(sys.argv) < 2:
    print sys.argv[0] + ' <00:11:22:33:44:55>'
    sys.exit(1)

hw_addr_byte = sys.argv[1].split(':')
if len(hw_addr_byte) != 6:
    print 'Invalid ethernet addr: "' + sys.argv[1] + '"'
    sys.exit(1)

try:
    hw_addr = reduce(lambda a, b: (a + chr(int(b,16))), hw_addr_byte, '')
except ValueError:
    print 'Invalid ethernet addr: "' + sys.argv[1] + '"'
    sys.exit(1)

msg = '\xff'*6 + hw_addr*16
print 'Sending WakeOnLan to ' + sys.argv[1] + '...'
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
s.sendto(msg, ('<broadcast>', 7))
s.close()
