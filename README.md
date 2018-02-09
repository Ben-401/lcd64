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
