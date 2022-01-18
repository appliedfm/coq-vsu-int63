.PHONY: all theories clightgen install clean deepclean

all: theories


#
# meta
#

PUBLISHER=appliedfm
PROJECT=Int63


#
# configure
#

J?=4
BITSIZE?=opam
COQC?=coqc
SHA256SUM?=sha256sum
VSUTOOL?=vsu

-include CONFIGURE


VSU_INCLUDE_DIR=$(shell $(VSUTOOL) -I)
CLIGHTGEN64?=$(shell $(VSUTOOL) --show-compcert-tool-path=coq-compcert/clightgen)
CLIGHTGEN32?=$(shell $(VSUTOOL) --show-compcert-tool-path=coq-compcert-32/clightgen)


TARGET=x86_64-linux
COMPCERT_PACKAGE=coq-compcert
VST_PACKAGE=coq-vst


COQLIB=$(shell $(COQC) -where | tr -d '\r' | tr '\\' '/')

COQLIBINSTALL=$(COQLIB)/user-contrib
COQ_INSTALL_DIR?=$(COQLIBINSTALL)/$(PUBLISHER)

ifeq ($(BITSIZE),64) # This is an alias for BITSIZE=opam
else ifeq ($(BITSIZE),32)
	TARGET=x86_32-linux
	COMPCERT_PACKAGE=coq-compcert-32
	VST_PACKAGE=coq-vst-32
	COQLIBINSTALL=$(COQLIB)/../coq-variant
	COQ_INSTALL_DIR=$(COQLIBINSTALL)/$(PUBLISHER)/32
endif


#
# theories
#

_CoqProject: theories/$(PROJECT)/vst/clightgen/$(TARGET)/int63.v
	echo "# $(TARGET)"                                                                              > $@
	echo `$(VSUTOOL) --show-coq-q-arg=$(COMPCERT_PACKAGE)`                                          >> $@
	echo `$(VSUTOOL) --show-coq-q-arg=$(VST_PACKAGE)`                                               >> $@
	echo "-Q theories/$(PROJECT)/model                      $(PUBLISHER).$(PROJECT).model"          >> $@
	echo "-Q theories/$(PROJECT)/vst/ast                    $(PUBLISHER).$(PROJECT).vst.ast"        >> $@
	echo "-Q theories/$(PROJECT)/vst/clightgen/$(TARGET)    $(PUBLISHER).$(PROJECT).vst.clightgen"  >> $@
	echo "-Q theories/$(PROJECT)/vst/proof                  $(PUBLISHER).$(PROJECT).vst.proof"      >> $@
	echo "-Q theories/$(PROJECT)/vst/spec                   $(PUBLISHER).$(PROJECT).vst.spec"       >> $@
	find     theories/$(PROJECT)/model                     -name "*.v" | cut -d'/' -f1-             >> $@
	find     theories/$(PROJECT)/vst/ast                   -name "*.v" | cut -d'/' -f1-             >> $@
	find     theories/$(PROJECT)/vst/clightgen/$(TARGET)   -name "*.v" | cut -d'/' -f1-             >> $@
	find     theories/$(PROJECT)/vst/proof                 -name "*.v" | cut -d'/' -f1-             >> $@
	find     theories/$(PROJECT)/vst/spec                  -name "*.v" | cut -d'/' -f1-             >> $@


Makefile.coq: Makefile _CoqProject
	cat _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq

theories: Makefile.coq
	$(MAKE) -f Makefile.coq -j$(J)


#
# clightgen
#

ifeq ($(SRC),opam)
	C_ROOT?=$(VSU_INCLUDE_DIR)
else
	C_ROOT?=src/c/include
endif


theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v: \
	$(C_ROOT)/coq-vsu-int63/src/int63.c \
	$(C_ROOT)/coq-vsu-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v: \
	$(C_ROOT)/coq-vsu-int63/src/int63.c \
	$(C_ROOT)/coq-vsu-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_64-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN64) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@

theories/$(PROJECT)/vst/clightgen/x86_32-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN32) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@

clightgen: \
	theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v \
	theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v


#
# install
#

.PHONY: install install-src install-vst

C_SOURCES= \
	$(shell find src/c/include -name "*.c" | cut -d'/' -f4-) \
	$(shell find src/c/include -name "*.h" | cut -d'/' -f4-)

install-src:
	install -d "$(VSU_INCLUDE_DIR)"
	for d in $(sort $(dir $(C_SOURCES))); do install -d "$(VSU_INCLUDE_DIR)/$$d"; done
	for f in $(C_SOURCES); do install -m 0644 src/c/include/$$f "$(VSU_INCLUDE_DIR)/$$(dirname $$f)"; done
	tree "$(VSU_INCLUDE_DIR)" || true

COQ_SOURCES= \
	$(shell find theories/$(PROJECT)/model                      -name "*.v" | cut -d'/' -f2-) \
	$(shell find theories/$(PROJECT)/vst/ast                    -name "*.v" | cut -d'/' -f2-) \
	$(shell find theories/$(PROJECT)/vst/clightgen/$(TARGET)    -name "*.v" | cut -d'/' -f2-) \
	$(shell find theories/$(PROJECT)/vst/proof                  -name "*.v" | cut -d'/' -f2-) \
	$(shell find theories/$(PROJECT)/vst/spec                   -name "*.v" | cut -d'/' -f2-)

COQ_COMPILED=$(COQ_SOURCES:%.v=%.vo)

install-vst: theories
	install -d "$(COQ_INSTALL_DIR)"
	for d in $(sort $(dir $(COQ_SOURCES) $(COQ_COMPILED))); do install -d "$(COQ_INSTALL_DIR)/$$d"; done
	for f in $(COQ_SOURCES) $(COQ_COMPILED); do install -m 0644 theories/$$f "$(COQ_INSTALL_DIR)/$$(dirname $$f)"; done
	mv    $(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/$(TARGET)/* $(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/
	rmdir $(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/$(TARGET)
	tree "$(COQ_INSTALL_DIR)" || true

install: install-src install-vst


#
# clean
#

clean:
	[ ! -f Makefile.coq ] || $(MAKE) -f Makefile.coq clean
	rm -f `find ./ -name "*Makefile.coq*"`
	rm -f `find ./ -name ".*.cache"`
	rm -f `find ./ -name "*.aux"`
	rm -f `find ./ -name "*.glob"`
	rm -f `find ./ -name "*.vo*"`

deepclean: clean
	rm -f _CoqProject

verydeepclean: deepclean
	rm -rf theories/$(PROJECT)/vst/clightgen
