all: compile

compile: 
	g++ server_procesy.cpp -o server_procesy.o
	g++ server_vlakna.cpp -D__USE_REENTRANT -lpthread -o server_vlakna.o
	g++ klient.cpp -o klient.o
	@echo "Kompilace uspesne dokoncena"

clean:
	rm -f *.o
	@echo "Smazany prelozene soubory"


