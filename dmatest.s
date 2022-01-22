
* STE DMA test by Cyril Lambin (2022)
*
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.


DMASNDST	MACRO
	;move.l	\1,d0
	swap	d0
	move.b	d0,$ffff8903.w
	swap	d0
	move.w	d0,d1
	lsr.w	#8,d0
	move.b	d0,$ffff8905.w
	move.b	d1,$ffff8907.w
	ENDM

DMASNDED	MACRO
	;move.l	\1,d0
	swap	d0
	move.b	d0,$ffff890F.w
	swap	d0
	move.w	d0,d1
	lsr.w	#8,d0
	move.b	d0,$ffff8911.w
	move.b	d1,$ffff8913.w
	ENDM



	*** SUPER
	clr.l	-(sp)
	move.w	#$20,-(sp)		; super
	trap	#1
	addq.w	#6,sp
	
	move.b     #%11,$FFFF8921.w	; 50kHz stereo
	move.l	#buf_nothing,d0
	DMASNDST
	move.l 	#buf_nothing_end,d0
	DMASNDED
	move.b	#%11,$ffff8901.w


	move.w	#$2700,sr
	move.w	#$F00,$ffff8240.w

	move.w	#2,$ffff8a20.w   ; src x byte increment
	move.w	#2,$ffff8a2e.w ; dst x increment
	clr.b	$ffff8a3d.w    ; skew
	move.w	#-1,$ffff8a28.w ; endmask1
	move.w	#-1,$ffff8a2a.w ; endmask2
	move.w	#-1,$ffff8a2c.w ; endmask3
	move.w	#$0203,$ffff8a3a.w    ; HOP+OP: $010F=1fill/$0203=copy
	move.w	#2,$ffff8a22.w   ; src y byte increment
	move.w	#800,$ffff8a30.w ; dst y increment

main	
	move.w	#1,$ffff8a38.w ; y count		; 16
	move.w	#46+92,$ffff8a36.w  ; x word count	; 16
	move.l	#buf_nothing,$ffff8a24.w	   	; src	; 24
	move.l	#buf_nothing+16000,$ffff8a32.w   	; dest 	; 24
mod	move.b	#%11000000,$ffff8a3c.w ; start HOG	; 16
	nop	; 4
	nop	; 4
	nop
	nop
	not.w	$ffff8240.w	; 8+8=16

	bra.s	main		; 12
	; 136
	; +8*words (blitter) 47*8=376
	; = 512


	clr.w	-(sp)
	trap #1

	SECTION BSS

buf_nothing
	ds.w	1000
buf_nothing_end
buf_blitter
	ds.w	32000
