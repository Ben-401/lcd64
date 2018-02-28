
COPT=	-Wall -g -std=c99
CC=	gcc

# for cc65 (c-code)
CC65=   /usr/local/bin/cc65
CL65=   /usr/local/bin/cl65
COPTS=  -t c64 -O -Or -Oi -Os --cpu 6502
LOPTS=  




TOOLS=	src/tools/monitor_load

3RDPARTY=	Ophis/bin/ophis

CCODE=	src/c/vicii.prg

ASM=	src/asm/test01prg.prg \
        src/asm/test02prg.prg \
        src/asm/test03prg.prg

all:	$(TOOLS) $(3RDPARTY) $(ASM) $(CCODE)


# ============================ OK
Ophis/src/Ophis/Main.py:
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Cloning: Ophis)
	git clone https://github.com/gardners/Ophis.git
Ophis/bin/ophis:	Ophis/src/Ophis/Main.py

# ============================ OK
src/asm/test01prg.prg:	src/asm/test01prg.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/asm/test01prg.prg)
	./Ophis/bin/ophis -4 src/asm/test01prg.a65 -l src/asm/test01prg.list -m src/asm/test01prg.map

# ============================ OK
src/asm/test02prg.prg:	src/asm/test02prg.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/asm/test02prg.prg)
	./Ophis/bin/ophis -4 src/asm/test02prg.a65 -l src/asm/test02prg.list -m src/asm/test02prg.map

# ============================ OK
src/asm/test03prg.prg:	src/asm/test03prg.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/asm/test03prg.prg)
	./Ophis/bin/ophis -4 src/asm/test03prg.a65 -l src/asm/test03prg.list -m src/asm/test03prg.map

# ============================ OK
# for cc65
%.s:    %.c $(HEADERS) $(DATAFILES)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> cc65: using $@ $<)
	$(CC65) $(COPTS) -o $@ $<

# ============================ OK, sourced from https://github.com/MEGA65/mega65-core/blob/px100mhz/src/tests/vicii.c
src/c/vicii.prg:	src/c/vicii.s
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/c/vicii.prg)
	$(CL65) $(COPTS) $(LOPTS) -o src/c/vicii.prg src/c/vicii.s

# ============================ OK
src/tools/monitor_load:	src/tools/monitor_load.c
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/tools/monitor_load)
	$(CC) $(COPT) -o src/tools/monitor_load src/tools/monitor_load.c

# ============================ OK
# ============================ OK
# BELOW ARE TOPLEVEL TARGETS USED FOR PROGRAMMING THE FPGA
# ============================ OK
# ============================ OK
prog:	$(TOOLS) $(3RDPARTY)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming to c64 mode)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4

# ============================ OK
prog-bit:	$(TOOLS) $(3RDPARTY)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming to c64 mode with USER-SUPPLIED BITFILE)
	$(warning ~~~~~~~~~~~~~~~~> To use, do >$ make BITFILE=./../../bin/nexys4ddr.bit prog-bit)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b ${BITFILE} \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4

# ============================ OK
prog-com:	$(TOOLS) $(3RDPARTY)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming commando)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 bin-prebuilt/commando.prg

# ============================ OK
prog-test01:	$(TOOLS) $(3RDPARTY) $(ASM)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming test01prg)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 src/asm/test01prg.prg

# ============================ OK
prog-test02:	$(TOOLS) $(3RDPARTY) $(ASM)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming test02prg)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 src/asm/test02prg.prg

# ============================ OK
prog-test03:	$(TOOLS) $(3RDPARTY) $(ASM)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming test03prg)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/lcd4ddr.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 src/asm/test03prg.prg

# ============================ OK
prog-cvicii:	$(TOOLS) $(3RDPARTY) $(CCODE)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming vicii)
	sudo src/tools/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 src/c/vicii.prg

# ============================
clean:
	rm -f src/tools/monitor_load
	rm -f src/asm/test01prg.prg src/asm/test01prg.list src/asm/test01prg.map
	rm -f src/c/vicii.prg src/c/vicii.o src/c/vicii.s
	$(warning Not removing Ophis)

# ============================ not needed
$(SDCARD_DIR)/MEGA65.D81:	$(UTILITIES)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: $(SDCARD_DIR)/MEGA65.D81)
	cbmconvert -v2 -D8o $(SDCARD_DIR)/MEGA65.D81 $(UTILITIES)

# ============================ not needed
utilities/etherload.prg:	utilities/etherload.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: utilities/etherload.prg)
	./../../Ophis/bin/ophis -4 utilities/etherload.a65 -l utilities/etherload.list -m utilities/etherload.map

