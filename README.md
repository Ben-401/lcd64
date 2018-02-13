# lcd64

implements a toolchain to program c64-mode of mega65 on nexys4ddr boards

files have been added from:  
binaries from github/mega65/mega65-core  
binaries from zimmers re *.prg  

you need to get the rom from http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/c65/910111-390488-01.bin  
and save it as MEGA65.ROM  

command(s) to run:  
```make``` - makes all then stops  
```make prog``` - makes all and then programs the board to goto c64 mode  
```make prog-com``` - makes all and then programs the board with a game (commando)  
```make prog-test01``` - makes all and then programs the board with the ```test01prg```  

## hardware setup

nexys4ddr board VGA to vga monitor  
nexys4ddr board AUDIO to headphones  
nexys4ddr board PROG/UART to ubuntu-USB-port  
nexys4ddr board USB-HOST to usb-keyboard  

## operating

The USB keyboard can operate the c64, allowing basic functions.  
Keypad is used for joystick operation.  
ESC = run-stop  
PGUP = restore  
refer to https://github.com/MEGA65/mega65-core/blob/master/doc/index.md for more details.  

The Ubuntu o/s can be used to interface with the c64, using a serial-port program on ubuntu connecting via /dev/ttyUSB1 (or similar).  
```sudo minicom -b 2000000 -D /dev/ttyS1```  
you may need to change the tty#  
yes, the baud-rate is 2Mbit.  

## resources

https://michaelcmartin.github.io/Ophis/book/book1.html

## compiler -- cc65

you are recommended to use the cc65 program to write ```c``` programs and have them compiled into ```6502``` assembly.  
refer to  
https://wiki.nesdev.com/w/index.php/Installing_CC65  
section ```Building from git```  

## compiler -- Ophis

the current build incorporates Ophis, which compiles ASM into machine code.  
PGS has suggested that we want to phase away from Ophis, but for now I will leave it in until confidence is gained from cc65.

