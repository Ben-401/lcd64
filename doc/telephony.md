

## MEGA65/MEGAphone Telemetry Software

Paul has developed the MEGA65 computing platform, that consists of the following:  
- softcore GS4510 processor embedded within fpga,  
- fpga interfacing logic to provide VGA, Keyboard, Sound, SDcard, etc.  
- VIC-IV advanced video processing
- etc

The MEGA65 has the ability to provide a Commodore 64 (C64) environment,
where the user can write programs and play retro-computer-games.
This environment is very similar to the real C64 but makes use of modern hardware.

The MEGAphone project is a sub-project that sits under the MEGA65 code-base.  
The MEGAphone makes use of the MEGA65-core processor and some related modules,
but is destined to be implemented upon an alternative PCB
which will be equipped with 4G Cellular radio (mobile phone), LCD and touchscreen capable, and other advanced features.
Basically,
the MEGAphone will be a handheld device,
similar in size/shape to a modern mobile phone,
capable of 4G network activities (make/receive calls/SMS),
using the fpga-based soft-core-processor developed by the MEGA65-team.

Currently, a prototype fpga board (Nexys4) and a Quectel 4G evaluation board can be used to demonstrate the C64 interfacing with the 4G modem.

### Tasks to do:

#### Task-1

Develop an existing CLI c-program to interface between PC, serial-port, Quectel-EVB, 4G-SIM to:  
- display 4G signal strength,  
- display Network Status and Operator,  
- display SIM settings (IMEI, modem firmware version etc).  
-  
- read addressbook and parse contacts  
- modify/write entries into the addressbook  
- compose and send an SMS  
- read an existing SMS  
-   
- be notified when an incoming SMS has arrived  
- be notified when an incoming call is received  
-  
- explore contacts and directly dial the contact  
-  
- unknown SIM detection, and prompt to extract/update Contacts-list.  

Task-1 will provide you with an understanding of what is required to interface to the 4G-Modem and SIM.  
You will:  
- learn how to parse the serial port messages to understand OK/ERROR/OTHER status,  
- design a state-machine to accept input from two sources, namely the user, and the modem,  
- design data management (arrays in memory) to hold the state-information,  
- design functions to perform the nessessary communications and status-updates.  

#### Task-2

Write a GUI to be executed in the Mega65 in c64 mode, to perform all of the above functionality.  
assumed:  
- serial-port interface has been developed (between Nexys/c64/QuectelEVB)  
- touchscreen and LCD interface has been developed  
- a single-bit specifies either landscape/portrait mode (optional)  
- interrupts have been confirmed to be working

specification:  
- limited to ~64KB of memory  
- toggling the landscape/portrait mode bit will result in the display-mode being toggled (optional)  

expect:  
- GUI functionality similar to recent Android/iPhone interface  
- program entry point to display a toplevel menu  
- program exit to close nicely.  
- simple text-based menu's similar to the following:  
```
/------\ /------\
|      | |      |
| OK   | | BACK |
|      | |      |
\------/ \------/
```

### REFERENCES:
```github/gardners/mega65phone/src/ec25```  
has the c-program to interface to the Quectel Evaluation Board with 4G module.

```github/ben-401/lcd64```  
has the workflow using fpga-prototype-board, mega65-bitstream, monitorload program and Ophis/cc65 compiler.

```https://github.com/gardners/mega65-phone-pcb/blob/master/datasheets/4g/EC25/Software/Quectel_EC25%26EC21_AT_Commands_Manual_V1.2.pdf```  
has the AT-modem commands that the 4G-module understands

```https://github.com/arduino/Arduino/tree/master/libraries/GSM/examples```  
```https://github.com/arduino-libraries/GSM```  
both have example-code showing how they implement their communications and state-machine. 



