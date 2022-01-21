

VASM = vasm -Ftos -devpac
LZ4 = lz4.exe

all: dmatest.prg

dmatest.prg: dmatest.s
	$(VASM) -o DMATEST.PRG dmatest.s
#	copy DMATEST.PRG Q:\DEV\DMATEST.PRG

clean:
	del dmatest.prg

	