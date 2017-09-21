# 
#
#

.PHONY: all clean init repatch

SRCDIR := ardupilot-source/
ROVERDIR := $(SRCDIR)APMrover2/

# - Files with associated patches
PATCHED_FILES := APMrover2/make.inc
PATCHED_FILES += APMrover2/APMrover2.cpp APMrover2/Rover.h APMrover2/Rover.cpp
PATCHED_FILES += APMrover2/GCS_Mavlink.cpp	# Support for the MANUAL_CONTROL command
# - Brand-new files
NEW_FILES := APMrover2/satellite_telemetry.h APMrover2/satellite_telemetry.cpp
NEW_FILES += libraries/UWA_IridiumSBD/UWA_IridiumSBD.h libraries/UWA_IridiumSBD/UWA_IridiumSBD.cpp

NEW_FILES := $(addprefix $(SRCDIR),$(NEW_FILES))
PATCHED_FILES := $(addprefix $(SRCDIR),$(PATCHED_FILES))

APMROVER2_BIN := APMrover2.elf

all: $(APMROVER2_BIN)


$(APMROVER2_BIN): ardupilot-source/APMrover2/APMrover2.elf

ardupilot-source/APMrover2/APMrover2.elf: ardupilot-source/APMrover2/Makefile $(PATCHED_FILES) $(NEW_FILES)
	mkdir -p builddir
	BUILDROOT=$(abspath builddir/) $(MAKE) -C $(dir $@) apm2

init:
	-git clone https://github.com/ArduPilot/ardupilot.git ardupilot-source
	(cd ardupilot-source; git checkout master-AVR)
	(cd ardupilot-source; git submodule update --init --recursive)

ardupilot-source/APMrover2/Makefile:
	test -e ardupilot-source/APMrover2/Makefile || echo "Run `make init` to check out the ArduPilot code"

$(PATCHED_FILES): $(SRCDIR)%: mods/%.patch
	cd $(dir $@); git checkout $(notdir $@)
	patch $@ $<

$(NEW_FILES): $(SRCDIR)%: mods/%
	cp $< $@

repatch:
	$(foreach f,$(PATCHED_FILES:$(SRCDIR)%=%), (cd $(SRCDIR)$(dir $f); git diff $(notdir $f)) > mods/$f.patch &&) true
	$(foreach f,$(NEW_FILES:$(SRCDIR)%=%), cp $(SRCDIR)$f mods/$f &&) true

