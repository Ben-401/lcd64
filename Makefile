
COPT=	-Wall -g -std=c99
CC=	gcc

TOOLS=	src/monitor_load

3RDPARTY=	Ophis/bin/ophis

ASM=	src/asm/test01prg.prg

all:	$(TOOLS) $(3RDPARTY) $(ASM)

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
src/monitor_load:	src/monitor_load.c
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/monitor_load)
	$(CC) $(COPT) -o src/monitor_load src/monitor_load.c

# ============================ OK
prog:	$(TOOLS) $(3RDPARTY)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming to c64 mode)
	sudo src/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4

# ============================ OK
prog-com:	$(TOOLS) $(3RDPARTY)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Programming commando)
	sudo src/monitor_load \
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
	sudo src/monitor_load \
		-l /dev/ttyUSB1 \
		-b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit \
		-k bin-prebuilt/KICKUP.M65 \
		-R MEGA65.ROM \
		-C bin-prebuilt/CHARROM.M65 \
		-4 src/asm/test01prg.prg

# ============================
clean:
	rm -f src/monitor_load
	rm -f src/asm/test01prg.prg src/asm/test01prg.list src/asm/test01prg.map
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

