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

ifeq ($(BITSIZE),64)
	COMPCERT_DIR=$(COQLIB)/user-contrib/compcert
	VST_DIR=$(COQLIB)/user-contrib/VST
else ifeq ($(BITSIZE),32)
	CLIGHTGEN=$(COQLIB)/../../variants/compcert32/bin/clightgen
	COQLIBINSTALL=$(COQLIB)/../coq-variant/$(PROJECT)-32
	COMPCERT_DIR=$(COQLIB)/../coq-variant/compcert32/compcert
	VST_DIR=$(COQLIB)/../coq-variant/VST32/VST
endif

INSTALLDIR?=$(COQLIBINSTALL)/$(PROJECT)

TARGET=x86_64-linux
ifeq ($(BITSIZE),32)
	TARGET=x86_32-linux
endif


theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v: \
	src/c/include/coq-vst-int63/src/int63.c \
	src/c/include/coq-vst-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v: \
	src/c/include/coq-vst-int63/src/int63.c \
	src/c/include/coq-vst-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_64-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN64) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@


theories/$(PROJECT)/vst/clightgen/x86_32-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN32) -Wall -Wno-unused-variable -Werror -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@


_CoqProject: theories/$(PROJECT)/vst/clightgen/$(TARGET)/int63.v
	echo "# $(TARGET)"                                                                  > $@
	@[ -z $(VST_DIR) ]          || echo "-Q $(VST_DIR) VST"                             >> $@
	@[ -z $(COMPCERT_DIR) ]     || echo "-Q $(COMPCERT_DIR) compcert"                   >> $@
	echo "-Q theories/$(PROJECT)/model                      $(PROJECT).model"           >> $@
	echo "-Q theories/$(PROJECT)/vst/ast                    $(PROJECT).vst.ast"         >> $@
	echo "-Q theories/$(PROJECT)/vst/clightgen/$(TARGET)    $(PROJECT).vst.clightgen"   >> $@
	echo "-Q theories/$(PROJECT)/vst/proof                  $(PROJECT).vst.proof"       >> $@
	echo "-Q theories/$(PROJECT)/vst/spec                   $(PROJECT).vst.spec"        >> $@
	find     theories/$(PROJECT)/model                     -name "*.v" | cut -d'/' -f1- >> $@
	find     theories/$(PROJECT)/vst/ast                   -name "*.v" | cut -d'/' -f1- >> $@
	find     theories/$(PROJECT)/vst/clightgen/$(TARGET)   -name "*.v" | cut -d'/' -f1- >> $@
	find     theories/$(PROJECT)/vst/proof                 -name "*.v" | cut -d'/' -f1- >> $@
	find     theories/$(PROJECT)/vst/spec                  -name "*.v" | cut -d'/' -f1- >> $@


Makefile.coq: Makefile _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq

theories: Makefile.coq
	$(MAKE) -f Makefile.coq -j$(J)


C_SOURCES= \
	$(shell find src/c -name "*.c" | cut -d'/' -f3-) \
	$(shell find src/c -name "*.h" | cut -d'/' -f3-)

COQ_SOURCES= \
	$(shell find theories/$(PROJECT)/model -name "*.v" | cut -d'/' -f1-) \
	$(shell find theories/$(PROJECT)/vst/ast -name "*.v" | cut -d'/' -f1-) \
	$(shell find theories/$(PROJECT)/vst/clightgen/$(TARGET) -name "*.v" | cut -d'/' -f1-) \
	$(shell find theories/$(PROJECT)/vst/proof -name "*.v" | cut -d'/' -f1-) \
	$(shell find theories/$(PROJECT)/vst/spec -name "*.v" | cut -d'/' -f1-)

COQ_COMPILED=$(COQ_SOURCES:%.v=%.vo)

.PHONY: install install-src install-vst

install-src:
	install -d "$(INSTALLDIR)"
	for d in $(sort $(dir $(C_SOURCES))); do install -d "$(INSTALLDIR)/$$d"; done
	for f in $(C_SOURCES); do install -m 0644 src/c/$$f "$(INSTALLDIR)/$$(dirname $$f)"; done

install-vst: theories
	install -d "$(INSTALLDIR)"
	for d in $(sort $(dir $(COQ_SOURCES) $(COQ_COMPILED))); do install -d "$(INSTALLDIR)/$$d"; done
	for f in $(COQ_SOURCES) $(COQ_COMPILED); do install -m 0644 $$f "$(INSTALLDIR)/$$(dirname $$f)"; done

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
