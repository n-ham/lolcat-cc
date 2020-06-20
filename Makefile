#basic Makefile for lolcat-cc

DESTDIR?=
PREFIX?=/usr/local
BINDIR=${DESTDIR}${PREFIX}/bin
LIBDIR=${DESTDIR}${PREFIX}/lib

CXX?=g++
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic -O3
LINK=

ifeq ($(OS),Windows_NT) 
    detected_OS := Windows
else
    detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

###

lolcat-cc: lolcat-cc.cc 
	$(CXX) $(CXXFLAGS) -o $@ $<

###

install:
ifeq ($(detected_OS),Windows)  # Windows
	@echo "Will need to manually add 'lolcat-cc.exe'"
	@echo " to a location searched by your path "
	@echo "variable, for example try 'C:\Windows\System32'"
else                           # (Free)BSD, Linux, OSX
	mkdir -p ${BINDIR}
	chmod 755 lolcat-cc
	mv lolcat-cc ${BINDIR}
endif 

uninstall:
ifeq ($(detected_OS),Windows)  # Windows
	@echo "Will need to manually delete 'lolcat-cc.exe' "
	@echo " from install location, typically "
	@echo "'C:\Windows\System32'"
else                           # (Free)BSD, Linux, OSX
	rm ${BINDIR}/lolcat-cc
endif 

clean:
ifeq ($(detected_OS),Windows)  # Windows
	del lolcat-cc.exe
else                           # (Free)BSD, Linux, OSX
	rm -f lolcat-cc
endif