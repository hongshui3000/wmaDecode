#             __________               __   ___.
#   Open      \______   \ ____   ____ |  | _\_ |__   _______  ___
#   Source     |       _//  _ \_/ ___\|  |/ /| __ \ /  _ \  \/  /
#   Jukebox    |    |   (  <_> )  \___|    < | \_\ (  <_> > <  <
#   Firmware   |____|_  /\____/ \___  >__|_ \|___  /\____/__/\_ \
#                     \/            \/     \/    \/            \/
# $Id: Makefile,v 1.3 2005-12-05 19:32:13 learman Exp $
#
include $(TOOLSDIR)/make.inc

INCLUDES=-I$(APPSDIR) -I.. -I. -I$(FIRMDIR)/include -I$(FIRMDIR)/export	\
 -I$(FIRMDIR)/common -I$(FIRMDIR)/drivers -I$(BUILDDIR)

ifdef APPEXTRA
   INCLUDES += $(patsubst %,-I$(APPSDIR)/%,$(subst :, ,$(APPEXTRA)))
endif

ALACOPTS = -O3
CFLAGS = $(GCCOPTS) $(ALACOPTS) $(INCLUDES) $(TARGET) $(EXTRA_DEFINES) \
 -DMEM=${MEMORYSIZE}

# This sets up 'SRC' based on the files mentioned in SOURCES
include $(TOOLSDIR)/makesrc.inc

OBJDIR=.
OUTPUT=libwma.a
SRC = wmadeci.c
OBJS2 := $(SRC:%.c=$(OBJDIR)/%.o)
OBJS = $(patsubst %.S, $(OBJDIR)/%.o, $(OBJS2))
DEPFILE = $(OBJDIR)/dep-libwma
DIRS =

all: $(OUTPUT)

$(OUTPUT): $(OBJS)
	@echo " YA $(SRC)"
	@echo "AR $@"
	@$(AR) ruv $@ $+ >/dev/null 2>&1

include $(TOOLSDIR)/make.inc

clean:
	@echo "cleaning libwma"
	@rm -f $(OBJS) $(OUTPUT) $(DEPFILE)

ifneq ($(MAKECMDGOALS),clean)
-include $(DEPFILE)
endif
