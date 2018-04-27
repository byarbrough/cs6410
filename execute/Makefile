# Makefile for tiger compiler
# Called by tigexe
# Usage: "make TARGET=(file.tig)"
#

TIGF=$1.s
TMP=tigc.temp
ARCH=mipstig.s
COMP=tigcomp.sml

all:
	# use sml to compile
	sml $(COMP) $(TARGET)
	# concat assembly into new file
	mv $(TIGF) $(TMP)
	cp $(ARCH) $(TIGF)
	cat $(TMP) >> $(TIGF)
	rm $(TMP)

clean:
	rm $(TARGET).s
