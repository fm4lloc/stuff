# Simple generic Makefile 1.0 - (Fm4lloc)
#
# ======================================================================
# This Makefile was written with bad practices. Not recommend  using 
# it on big projects.
# ======================================================================
# Create a folder named "src" to place your project's source files; 
# The Makefile is in the same directory it;
# ======================================================================
 
#-----------------------------------------------------------------------
# EDIT HERE
#-----------------------------------------------------------------------
RM          = /bin/rm -f
CC          = gcc
DEFS        = -O3 -Wall -fmessage-length=0
PROGNAME    = generic
INCLUDES    = 
LIBS        = 
#-----------------------------------------------------------------------
 
DEFINES     = $(INCLUDES) $(DEFS)
CFLAGS      = $(DEFINES)
 
SRC         = $(wildcard src/*.c) $(wildcard src/**/*.c)
HEADERS     = $(wildcard src/*.h) $(wildcard src/**/*.h)
OBJS        = $(SRC:.c=.o)
 
DATE        = $(shell date +%Y-%d-%m)
 
.c.o:
    @echo 'Building file: $<'
    @echo 'Invoking: Cross GCC Compiler'
    $(CC) $(CFLAGS) -c $*.c -o $*.o
    @echo 'Finished building: $<'
    @echo ' '
     
all: $(PROGNAME)
 
$(PROGNAME) : $(OBJS)
    @echo 'Building target: $@'
    @echo 'Invoking: Cross GCC Linker'
    $(CC) $(LIBS) $(OBJS) -o $(PROGNAME)
    @echo 'Finished building target: $@'
    @echo ' '
     
.PHONY: clean tar
clean:
    $(RM) $(PROGNAME) $(OBJS)
    @echo ' '
     
tar:
    tar cvjf cryptus_src_$(DATE).tar.bz2 $(SRC) $(HEADERS) Makefile
    @echo ' '
