# ste_dmatest
Check for faulty shifter on Atari STE/Mega STE

Some shifter ICs on Mega STE seem to generate audio bugs when the audio PCM DMA play a sound and blitter transfers are in progress.

This small program plays an empty audio buffer at 50kHz and runs blitter transfers in loop. If you can hear audio clicks/cracks/pops, then your shifter IC may be faulty.  
You cannot exit cleanly the tool: you must reset the STE (sorry, it was done in 5min).

In my tests, an STE with C300588 shifter is okay while a Mega STE with C301712 has the bug.  

It looks like there was at least two revisions of the C301712 because of this bug, but the combo GST-MCU chip may also have a role in this issue.  
Also, it seems like the C301712 does not always run fine on STE (see the exxos post below).

In my case I swapped the two chips in my STE/Mega STE and the issue was gone on Mega STE.


More information:  
https://www.atari-forum.com/viewtopic.php?f=16&t=41328  
https://www.exxoshost.co.uk/forum/viewtopic.php?f=23&t=4797&start=40  
https://atariage.com/forums/topic/198648-wanted-atari-c300588-stemega-ste-shifter-chip/  
