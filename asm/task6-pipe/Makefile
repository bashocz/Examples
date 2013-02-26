TARGET=asm-process

all: $(TARGET)

%.o: %.asm
	nasm -f elf $<

clean:
	rm -rf $(TARGET) *.o

$(TARGET): asm-process.o process.c
	cc asm-process.o process.c -o $(TARGET)
