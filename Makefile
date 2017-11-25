
## Compiler
CC=g++

## Optimisation flag
CPP_FLAGS=-O2

## get the libs together
LIBS = `pkg-config opencv --cflags --libs`

all: run

run:
	$(CC) $(CPP_FLAGS) -o run.exe main.cpp --std=c++11 $(LIBS) -pthread

clean:
	rm run.exe
