# lcd64

implements toolchain to program c64-mode of mega65 in nexys boards

extra files added:
binaries from github/mega65/mega65-core

you need to get the rom from http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/c65/910111-390488-01.bin
and save it as MEGA65.ROM

command(s) to run:
sudo src/monitor_load -l /dev/ttyUSB1 -b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit -k bin-prebuilt/KICKUP.M65 -R MEGA65.ROM -C bin-prebuilt/CHARROM.M65 -4
sudo src/monitor_load -l /dev/ttyUSB1 -b bin-prebuilt/nexys4ddr-px100m-17ad715-20180208.12.bit -k bin-prebuilt/KICKUP.M65 -R MEGA65.ROM -C bin-prebuilt/CHARROM.M65 -4 bin-prebuilt/commando.prg

