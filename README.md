# Concept-1-Remote
 Free Pascal Lazarus 1st Project
This was my first attempt to do some programming for fun after having some experience with HP BASIC (and a couple of other languages) long ago.

What it does
It provides an on-screen control on Windows to adjust the source and output of a Apart "Concept 1" amplifier.
The amp takes simple text commands to its serial port.
It also allows to change the name of each of the sources displayed on the amp - these then saved to disc in
the same directory as the exe.
The latest addition is a standby switch - the amp comes back on when the form is activated. Also the COM port can be chosen, this too saved in the text file.
The memo for the source names has gone and the form now shows text boxes which feed a TStringList.


RS232 codes are here amongst other places on line:
https://avdeal.de/Apart/CONCEPT1T/CONCEPT1_RS232_Manual.pdf/


The project is written with Free Pascal using the Lazarus IDE.

The slider's operation is obvious. 
The SETUP button opens a form to enter the 4 source titles (8 characters max each) and choose a COM port.
Changing the source is by a Rt click on the slider/form where a pop up menu will take the choice.

The width of the form is fixed but the length can be changed using the mouse.
It's not pretty but it works. I never have to leave my chair again.
