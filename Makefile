.PHONY: all theories clightgen clean deepclean

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
CLIGHTGEN64?=$(shell $(VSUTOOL) --show-tool-path=coq-compcert/clightgen)
CLIGHTGEN32?=$(shell $(VSUTOOL) --show-tool-path=coq-compcert-32/clightgen)


TARGET=x86_64-linux
VARIANT=
COMPCERT_PACKAGE=coq-compcert
VST_PACKAGE=coq-vst


COQLIB=$(shell $(COQC) -where | tr -d '\r' | tr '\\' '/')

COQLIBINSTALL=$(COQLIB)/user-contrib
COQ_INSTALL_DIR?=$(COQLIBINSTALL)/$(PUBLISHER)/$(PROJECT)

ifeq ($(BITSIZE),64) # This is an alias for BITSIZE=opam
else ifeq ($(BITSIZE),32)
	TARGET=x86_32-linux
	COMPCERT_PACKAGE=coq-compcert-32
	VST_PACKAGE=coq-vst-32
	COQLIBINSTALL=$(COQLIB)/../coq-variant
	VARIANT=32/
endif


COQ_INSTALL_DIR=$(COQLIBINSTALL)/$(PUBLISHER)/$(VARIANT)$(PROJECT)
CLIGHT_TARGETS=theories/$(PROJECT)/vst/clightgen/$(TARGET)/int63.v

ifeq ($(SUBPROJECT),model)
	SKIP_VST=1
	CLIGHT_TARGETS=
else ifeq ($(SUBPROJECT),vst)
	SKIP_MODEL=1
endif


#
# clightgen
#

ifeq ($(SRC),opam)
	C_INCLUDE_PATH?=$(VSU_INCLUDE_DIR)
else
	C_INCLUDE_PATH?=src/c/include
endif


theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v: \
	$(C_INCLUDE_PATH)/coq-vsu-int63/src/int63.c \
	$(C_INCLUDE_PATH)/coq-vsu-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v: \
	$(C_INCLUDE_PATH)/coq-vsu-int63/src/int63.c \
	$(C_INCLUDE_PATH)/coq-vsu-int63/int63.h

theories/$(PROJECT)/vst/clightgen/x86_64-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN64) -Wall -Wno-unused-variable -I`$(VSUTOOL) -I` -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@

theories/$(PROJECT)/vst/clightgen/x86_32-linux/%.v:
	mkdir -p `dirname $@`
	$(CLIGHTGEN32) -Wall -Wno-unused-variable -I`$(VSUTOOL) -I` -normalize -o $@ $<
	echo "(*\nInput hashes (sha256):\n\n`$(SHA256SUM) $^`\n*)" >> $@

clightgen: \
	theories/$(PROJECT)/vst/clightgen/x86_64-linux/int63.v \
	theories/$(PROJECT)/vst/clightgen/x86_32-linux/int63.v


#
# theories
#

_CoqProject: $(CLIGHT_TARGETS)
	echo "# $(TARGET)"                          > $@
	echo `$(VSUTOOL) -Q $(COMPCERT_PACKAGE)`    >> $@
	echo `$(VSUTOOL) -Q $(VST_PACKAGE)`         >> $@
	[ -n "$(SKIP_MODEL)" ] || echo "-Q theories/$(PROJECT)/model                      $(PUBLISHER).$(PROJECT).model"          >> $@
	[ -n "$(SKIP_MODEL)" ] || find     theories/$(PROJECT)/model                     -name "*.v" | sort                       >> $@
	[ -n "$(SKIP_VST)" ]   || echo "-Q theories/$(PROJECT)/vst/ast                    $(PUBLISHER).$(PROJECT).vst.ast"        >> $@
	[ -n "$(SKIP_VST)" ]   || find     theories/$(PROJECT)/vst/ast                   -name "*.v" | sort                       >> $@
	[ -n "$(SKIP_VST)" ]   || echo "-Q theories/$(PROJECT)/vst/clightgen/$(TARGET)    $(PUBLISHER).$(PROJECT).vst.clightgen"  >> $@
	[ -n "$(SKIP_VST)" ]   || find     theories/$(PROJECT)/vst/clightgen/$(TARGET)   -name "*.v" | sort                       >> $@
	[ -n "$(SKIP_VST)" ]   || echo "-Q theories/$(PROJECT)/vst/verif                  $(PUBLISHER).$(PROJECT).vst.verif"      >> $@
	[ -n "$(SKIP_VST)" ]   || find     theories/$(PROJECT)/vst/verif                 -name "*.v" | sort                       >> $@
	[ -n "$(SKIP_VST)" ]   || echo "-Q theories/$(PROJECT)/vst/spec                   $(PUBLISHER).$(PROJECT).vst.spec"       >> $@
	[ -n "$(SKIP_VST)" ]   || find     theories/$(PROJECT)/vst/spec                  -name "*.v" | sort                       >> $@


Makefile.coq: Makefile _CoqProject
	cat _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq

theories: Makefile.coq
	$(MAKE) -f Makefile.coq -j$(J)


#
# install
#

.PHONY: install install-src install-model install-vst


C_SOURCES= \
	$(shell find src/c/include -name "*.c" | sort | cut -d'/' -f4-) \
	$(shell find src/c/include -name "*.h" | sort | cut -d'/' -f4-)

install-src:
	install -d "$(VSU_INCLUDE_DIR)"
	for d in $(sort $(dir $(C_SOURCES))); do install -d "$(VSU_INCLUDE_DIR)/$$d"; done
	for f in $(C_SOURCES); do install -m 0644 src/c/include/$$f "$(VSU_INCLUDE_DIR)/$$(dirname $$f)"; done
	tree "$(VSU_INCLUDE_DIR)" || true


COQ_SOURCES_MODEL= \
	$(shell find theories/$(PROJECT)/model                      -name "*.v" | cut -d'/' -f3-)

COQ_COMPILED_MODEL=$(COQ_SOURCES_MODEL:%.v=%.vo)

install-model: theories
	install -d "$(COQ_INSTALL_DIR)"
	for d in $(sort $(dir $(COQ_SOURCES_MODEL) $(COQ_COMPILED_MODEL))); do install -d "$(COQ_INSTALL_DIR)/$$d"; done
	for f in $(COQ_SOURCES_MODEL) $(COQ_COMPILED_MODEL); do install -m 0644 theories/$(PROJECT)/$$f "$(COQ_INSTALL_DIR)/$$(dirname $$f)"; done
	tree "$(COQ_INSTALL_DIR)" || true


COQ_SOURCES_VST= \
	$(shell find theories/$(PROJECT)/vst/ast                    -name "*.v" | sort | cut -d'/' -f3-) \
	$(shell find theories/$(PROJECT)/vst/clightgen/$(TARGET)    -name "*.v" | sort | cut -d'/' -f3-) \
	$(shell find theories/$(PROJECT)/vst/verif                  -name "*.v" | sort | cut -d'/' -f3-) \
	$(shell find theories/$(PROJECT)/vst/spec                   -name "*.v" | sort | cut -d'/' -f3-)

COQ_COMPILED_VST=$(COQ_SOURCES_VST:%.v=%.vo)

install-vst: theories
	[ -z $(PACKAGE_NAME) ] || echo "{" > install-meta.json
	[ -z $(PACKAGE_NAME) ] || echo "    \"coq-library-name\": \"$(PUBLISHER).$(PROJECT)\"," >> install-meta.json
	[ -z $(PACKAGE_NAME) ] || echo "    \"coq-library-path\": \"$(COQ_INSTALL_DIR)\"" >> install-meta.json
	[ -z $(PACKAGE_NAME) ] || echo "}" >> install-meta.json
	[ -z $(PACKAGE_NAME) ] || install -d `$(VSUTOOL) --show-unit-metadata-path`
	[ -z $(PACKAGE_NAME) ] || install -m 0644 install-meta.json `$(VSUTOOL) --show-unit-metadata-path`/$(PACKAGE_NAME).json
	install -d "$(COQ_INSTALL_DIR)"
	for d in $(sort $(dir $(COQ_COMPILED_VST) $(COQ_COMPILED_VST))); do install -d "$(COQ_INSTALL_DIR)/$$d"; done
	for f in $(COQ_COMPILED_VST) $(COQ_COMPILED_VST); do install -m 0644 theories/$(PROJECT)/$$f "$(COQ_INSTALL_DIR)/$$(dirname $$f)"; done
	mv    $(COQ_INSTALL_DIR)/vst/clightgen/$(TARGET)/* $(COQ_INSTALL_DIR)/vst/clightgen/
	rmdir $(COQ_INSTALL_DIR)/vst/clightgen/$(TARGET)
	tree "$(COQ_INSTALL_DIR)" || true


#
# clean
#

clean:
	[ ! -f Makefile.coq ] || $(MAKE) -f Makefile.coq clean
	rm -f install-meta.json
	rm -f `find ./ -name "*Makefile.coq*"`
	rm -f `find ./ -name ".*.cache"`
	rm -f `find ./ -name "*.aux"`
	rm -f `find ./ -name "*.glob"`
	rm -f `find ./ -name "*.vo*"`

deepclean: clean
	rm -f _CoqProject

verydeepclean: deepclean
	rm -rf theories/$(PROJECT)/vst/clightgen
