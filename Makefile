
COPT=	-Wall -g -std=c99
CC=	gcc

# if you want your PRG to appear on "MEGA65.D81", then put your PRG in "./src/utilities/userPRGs"
# ie: COMMANDO.PRG
#
# if you want your .a65 source code compiled and then embedded within "MEGA65.D81", then put
# your source.a65 in the 'utilities' directory, and ensure it is listed below.
#
# NOTE: that all files listed below will be embedded within the "MEGA65.D81".
#
UTILITIES=	utilities/ethertest.prg \
		utilities/etherload.prg \
		utilities/test01prg.prg \
		utilities/c65test02prg.prg \
		utilities/c65-rom-910111-fastload-patch.prg \
		utilities/userPRGs/* \
		tests/test_fdc_equal_flag.prg \
		diskmenu.prg \

TOOLS=	src/monitor_load

3RDPARTY=	Ophis/bin/ophis



# c-programs
tools:	$(TOOLS)

# assembly files (a65 -> prg)
utilities:	$(UTILITIES)

all:	TOOLS

# ============================
#$(SDCARD_DIR)/CHARROM.M65:
#	$(warning =============================================================)
#	$(warning ~~~~~~~~~~~~~~~~> Making: $(SDCARD_DIR)/CHARROM.M65)
#	wget -O $(SDCARD_DIR)/CHARROM.M65 http://www.zimmers.net/anonftp/pub/cbm/firmware/characters/c65-caff.bin


# ============================
Ophis/src/Ophis/Main.py:	Ophis/bin/ophis
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Cloning: Ophis)
	git clone https://github.com/gardners/Ophis.git
Ophis/bin/ophis:	Ophis/src/Ophis
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Dummy: Ophis)

# ============================
$(SDCARD_DIR)/MEGA65.D81:	$(UTILITIES)
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: $(SDCARD_DIR)/MEGA65.D81)
	cbmconvert -v2 -D8o $(SDCARD_DIR)/MEGA65.D81 $(UTILITIES)

# ============================
utilities/etherload.prg:	utilities/etherload.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: utilities/etherload.prg)
	./../../Ophis/bin/ophis -4 utilities/etherload.a65 -l utilities/etherload.list -m utilities/etherload.map


# ============================
src/asm/test01prg.prg:	src/asm/test01prg.a65
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/asm/test01prg.prg)
	./Ophis/bin/ophis -4 src/asm/test01prg.a65 -l src/asm/test01prg.list -m src/asm/test01prg.map


# ============================ OK
src/monitor_load:	src/monitor_load.c Makefile
	$(warning =============================================================)
	$(warning ~~~~~~~~~~~~~~~~> Making: src/monitor_load)
	$(CC) $(COPT) -o src/monitor_load src/monitor_load.c

# ============================
clean:
	rm -f src/monitor_load
	rm -f src/asm/test01prg.prg src/asm/test01prg.list src/asm/test01prg.map

	rm -f KICKUP.M65 kickstart.list kickstart.map
	rm -f diskmenu.prg diskmenuprg.list diskmenuprg.map
	rm -f diskmenu_c000.bin diskmenuc000.list diskmenuc000.map
	rm -f tools/etherkick/etherkick
	rm -f tools/etherload/etherload
	rm -f tools/hotpatch/hotpatch
	rm -f tools/pngprepare/pngprepare
	rm -f utilities/etherload.prg utilities/etherload.list utilities/etherload.map
	rm -f utilities/ethertest.prg utilities/ethertest.list utilities/ethertest.map
	rm -f utilities/c65test02prg.prg utilities/c65test02prg.list utilities/c65test02prg.map
	rm -f iomap.txt
	rm -f utility.d81
	rm -f tests/test_fdc_equal_flag.prg tests/test_fdc_equal_flag.list tests/test_fdc_equal_flag.map
	rm -rf $(SDCARD_DIR)
	rm -f $(VHDLSRCDIR)/kickstart.vhdl $(VHDLSRCDIR)/charrom.vhdl $(VHDLSRCDIR)/version.vhdl version.a65
	rm -f c65-rom-911001.txt c65-911001-rom-annotations.txt c65-dos-context.bin c65-911001-dos-context.bin
	rm -f thumbnail.prg
	rm -f textmodetest.prg textmodetest.list etherload_done.bin etherload_stub.bin
	rm -f videoproxy

cleangen:
	rm $(VHDLSRCDIR)/kickstart.vhdl $(VHDLSRCDIR)/charrom.vhdl *.M65
