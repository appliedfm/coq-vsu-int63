PUBLISHER=appliedfm
PROJECT=Int63


.PHONY: all theories install clightgen clean deepclean

all: theories


J?=4
BITSIZE?=opam
COQC?=coqc
SHA256SUM=sha256sum

-include CONFIGURE


COQLIB=$(shell $(COQC) -where | tr -d '\r' | tr '\\' '/')
COQLIBINSTALL=$(COQLIB)/user-contrib

CLIGHTGEN64?=$(COQLIB)/../../bin/clightgen
CLIGHTGEN32?=$(COQLIB)/../../variants/compcert32/bin/clightgen

ifeq ($(BITSIZE),64) # This is an alias for BITSIZE=opam
else ifeq ($(BITSIZE),32)
	COQLIBINSTALL=$(COQLIB)/../coq-variant/
	COMPCERT_DIR=$(COQLIB)/../coq-variant/compcert32/compcert
	VST_DIR=$(COQLIB)/../coq-variant/VST32/VST
endif

C_INSTALL_DIR=$(COQLIB)/../$(PUBLISHER)
COQ_INSTALL_DIR?=$(COQLIBINSTALL)/$(PUBLISHER)

TARGET=x86_64-linux
ifeq ($(BITSIZE),32)
	TARGET=x86_32-linux
endif


ifeq ($(SRC),opam)
	C_ROOT?=$(C_INSTALL_DIR)
else
	C_ROOT?=src/c
endif


theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v: \
	$(C_ROOT)/include/coq-vst-int63/src/int63.c \
	$(C_ROOT)/include/coq-vst-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v: \
	$(C_ROOT)/include/coq-vst-int63/src/int63.c \
	$(C_ROOT)/include/coq-vst-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_64-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN64) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@


theories/$(PROJECT)/vst/clightgen/x86_32-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN32) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@


_CoqProject: theories/$(PROJECT)/vst/clightgen/$(TARGET)/int63.v
	echo "# $(TARGET)"                                                                              > $@
	@[ -z $(VST_DIR) ]          || echo "-Q $(VST_DIR) VST"                                         >> $@
	@[ -z $(COMPCERT_DIR) ]     || echo "-Q $(COMPCERT_DIR) compcert"                               >> $@
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
	coq_makefile -f _CoqProject -o Makefile.coq

theories: Makefile.coq
	$(MAKE) -f Makefile.coq -j$(J)


.PHONY: install install-src install-vst

C_SOURCES= \
	$(shell find src/c -name "*.c" | cut -d'/' -f3-) \
	$(shell find src/c -name "*.h" | cut -d'/' -f3-)

install-src:
	install -d "$(C_INSTALL_DIR)"
	for d in $(sort $(dir $(C_SOURCES))); do install -d "$(C_INSTALL_DIR)/$$d"; done
	for f in $(C_SOURCES); do install -m 0644 src/c/$$f "$(C_INSTALL_DIR)/$$(dirname $$f)"; done

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
	for f in $(shell find "$(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/$(TARGET)" -name "*.v*"); do mv "$$f" "$(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/"; done
	rmdir "$(COQ_INSTALL_DIR)/$(PROJECT)/vst/clightgen/$(TARGET)"

install: install-src install-vst


clightgen: \
	theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v \
	theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v


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
