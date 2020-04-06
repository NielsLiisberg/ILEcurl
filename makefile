#-----------------------------------------------------------
# User-defined part start
#
# The shell we use

# NOTE - UTF is not allowed for ILE source (yet) - so convert to WIN-1252
# NOTE!! gmake is case sensitive for targets !!


# BIN_LIB is the destination library for the service program.
# the rpg modules and the binder source file are also created in BIN_LIB.
# binder source file and rpg module can be remove with the clean step (make clean)
.PHONY=all
BIN_LIB=ILECURL
DIR=src
LIBLIST=$(BIN_LIB) 
DBGVIEW=*ALL
TARGET_CCSID=*JOB
TARGET_RELEASE=*CURRENT
STMF=$(DIR)/$@
OBJ=$(notdir $*)

# CL - settings
CLFLAGS=DBGVIEW(*ALL)
CLINCLUDE=*SRCFILE


# C - Settings
CFLAGS=OPTIMIZE(10) ENUM(*INT) TERASPACE(*YES) STGMDL(*INHERIT) SYSIFCOPT(*IFSIO) DBGVIEW(*ALL)
CINCLUDE='/QIBM/include' 'include'

# RPG - Settings
RPGINCLUDE='./..'
RPGFLAGS=DBGVIEW(*LIST)

# SQLRPG - Settings
SQLRPGINCLUDE='./..'
SQLRPGFLAGS=DBGVIEW(*LIST) RPGPPOPT(*LVL2)


# CMD - Settings
CMDFLAGS=PRDLIB($(BIN_LIB)) REPLACE(*YES)

# DSPF - Settings
DSPFFLAGS=REPLACE(*YES)

# SQL - Settings
SQLFLAGS=COMMIT(*NONE)

#
# User-defined part end
#-----------------------------------------------------------

# Dependency list ---  list all

all:  $(BIN_LIB).lib ileCurl.srvpgm


#-----------------------------------------------------------
%.lib:
	-system -q "CRTLIB $* TYPE(*TEST)"

ILEcurl.srvpgm: ILEcurl.rpgle ILEcurl.bnddir
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" \
	--flags="MODULE(ILEcurl) ALWLIBUPD(*YES) TGTRLS($(TARGET_RELEASE)) DETAIL(*BASIC)"

ILEcurl.bnddir: 
	-system "CRTBNDDIR  BNDDIR($(BIN_LIB)/$(BIN_LIB))"
	-system "RMVBNDDIRE BNDDIR($(BIN_LIB)/$(BIN_LIB)) OBJ(($(BIN_LIB)/$(BIN_LIB) *SRVPGM))"
	-system "ADDBNDDIRE BNDDIR($(BIN_LIB)/$(BIN_LIB)) OBJ(($(BIN_LIB)/$(BIN_LIB) *SRVPGM)) POSITION(*FIRST)"

%.rpgle:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(RPGFLAGS)" --include="$(RPGINCLUDE)"

%.sqlrpgle:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(SQLRPGFLAGS)" --include="$(SQLRPGINCLUDE)"

%.c:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(CFLAGS)" --include="$(CINCLUDE)"

%.clle:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(CLFLAGS)" --include="$(CLINCLUDE)"

%.cmd:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(CMDFLAGS)"

%.dspf:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(DSPFFLAGS)"


%.menu:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(MENUFLAGS)"

%.pnlgrp:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(PNLGRPFLAGS)"

%.sql:
	compile.py --stmf="$(STMF)" --lib="$(BIN_LIB)" --liblist="$(LIBLIST)" --flags="$(SQLFLAGS)"

hdr:
	-system -q "CRTSRCPF FILE($(BIN_LIB)/QRPGLESRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('headers/ILEcurl.rpgle') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGLESRC.file/ILEcurl.mbr') MBROPT(*REPLACE)"

all:
	@echo Build success!

clean:
	-system -q "DLTOBJ OBJ($(BIN_LIB)/*ALL) OBJTYPE(*FILE)"
	-system -q "DLTOBJ OBJ($(BIN_LIB)/*ALL) OBJTYPE(*MODULE)"

release: clean
	@echo " -- Creating ILEcurl release. --"
	@echo " -- Creating save file. --"
	system "CRTSAVF FILE($(BIN_LIB)/RELEASE)"
	system "SAVLIB LIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE) OMITOBJ((RELEASE *FILE))"
	-rm -r release
	-mkdir release
	system "CPYTOSTMF FROMMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') TOSTMF('./release/release.savf') STMFOPT(*REPLACE) STMFCCSID(1252) CVTDTA(*NONE)"
	@echo " -- Cleaning up... --"
	system "DLTOBJ OBJ($(BIN_LIB)/RELEASE) OBJTYPE(*FILE)"
	@echo " -- Release created! --"
	@echo ""
	@echo "To install the release, run:"
	@echo "  > CRTLIB $(BIN_LIB)"
	@echo "  > CPYFRMSTMF FROMSTMF('./release/release.savf') TOMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') MBROPT(*REPLACE) CVTDTA(*NONE)"
	@echo "  > RSTLIB SAVLIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE)"
	@echo ""
