TARGET=c-main

all: $(TARGET)

%.o: %.asm
	nasm -f elf $<

clean:
	rm -rf $(TARGET) *.o

$(TARGET): asm-tool.o c-main.c
	cc asm-tool.o c-main.c -o $(TARGET)
