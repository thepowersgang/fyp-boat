# 
#
#

.PHONY: all clean init repatch

SRCDIR := ardupilot-source/
ROVERDIR := $(SRCDIR)APMrover2/

# - Files with associated patches
PATCHED_FILES := APMrover2/APMrover2.cpp
# - Brand-new files
NEW_FILES := 

NEW_FILES := $(addprefix $(SRCDIR),$(NEW_FILES))
PATCHED_FILES := $(addprefix $(SRCDIR),$(PATCHED_FILES))

BIN := APMrover2.elf

all: $(BIN)


$(BIN): ardupilot-source/APMrover2/APMrover2.elf

ardupilot-source/APMrover2/APMrover2.elf: ardupilot-source/APMrover2/Makefile $(PATCHED_FILES) $(NEW_FILES)
	$(MAKE) -C $(dir $@) apm2

ardupilot-source/APMrover2/Makefile:
	git clone https://github.com/ArduPilot/ardupilot.git ardupilot-source
	(cd ardupilot-source; git checkout master-AVR)
	(cd ardupilot-source; git submodule update --init --recursive)

$(PATCHED_FILES): $(SRCDIR)%: mods/%.patch
	cp -n $@ $@.orig && cp $@.orig $@
	patch $@ $<

$(NEW_FILES): $(SRCDIR)%: mods/%
	cp $@ $<


