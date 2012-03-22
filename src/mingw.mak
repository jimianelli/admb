.PHONY: dist verify

SHELL:=$(COMSPEC)
DISK=..\build\dists\admb_mingw
PWD=$(shell pwd)

CCVERSION=mingw
OSVERSION=win
COMP=g++

dist:
	if exist ${DISK} rd /S /Q ${DISK}
	mkdir $(DISK)\bin
	mkdir $(DISK)\include
	mkdir $(DISK)\lib

	if not exist df1b2-separable\${CCVERSION}-${OSVERSION}olp mkdir df1b2-separable\${CCVERSION}-${OSVERSION}olp
	if not exist df1b2-separable\${CCVERSION}-${OSVERSION}slp mkdir df1b2-separable\${CCVERSION}-${OSVERSION}slp
	if not exist linad99\${CCVERSION}-${OSVERSION}olp mkdir linad99\${CCVERSION}-${OSVERSION}olp
	if not exist linad99\${CCVERSION}-${OSVERSION}slp mkdir linad99\${CCVERSION}-${OSVERSION}slp
	if not exist nh99\${CCVERSION}-${OSVERSION}olp mkdir nh99\${CCVERSION}-${OSVERSION}olp
	if not exist tools99\${CCVERSION}-${OSVERSION}olp mkdir tools99\${CCVERSION}-${OSVERSION}olp

	$(MAKE) -C df1b2-separable CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}olp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-optg32-rh8-laplace.mak disk
	$(MAKE) -C df1b2-separable CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}slp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-safg32-rh8-laplace.mak disk
	$(MAKE) -C linad99 CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}olp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-optg32-rh8-laplace.mak disk
	$(MAKE) -C linad99 CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}slp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-safg32-rh8-laplace.mak disk
	$(MAKE) -C nh99 CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}olp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-optg32-rh8-laplace.mak disk
	$(MAKE) -C tools99 CC=${COMP} LIBPATH=${CCVERSION}-${OSVERSION}olp DISKDIR=..\${DISK} PVMOPTION=-Dlinux -f mingw-optg32-rh8-laplace.mak disk

	copy ..\LICENSE ${DISK}
	copy ..\README.txt ${DISK}
	copy ..\scripts\admb\*.bat ${DISK}\bin
	copy "..\scripts\g++\*.bat" ${DISK}\bin
	copy ..\scripts\mingw\*.bat ${DISK}\bin
	copy ..\scripts\mingw\Makefile ${DISK}

	mkdir ${DISK}\examples
	xcopy ..\examples ${DISK}\examples /S

verify:
	set ADMB_HOME=%CD%\$(DISK)& set PATH=%CD%\$(DISK)\bin;$(PATH)& set& $(MAKE) -C ${DISK} all

clean:
	if exist df1b2-separable\${CCVERSION}-${OSVERSION}olp rd /S /Q df1b2-separable\${CCVERSION}-${OSVERSION}olp
	if exist df1b2-separable\${CCVERSION}-${OSVERSION}slp rd /S /Q df1b2-separable\${CCVERSION}-${OSVERSION}slp
	if exist linad99\\${CCVERSION}-${OSVERSION}olp rd /S /Q linad99\\${CCVERSION}-${OSVERSION}olp
	if exist linad99\${CCVERSION}-${OSVERSION}slp rd /S /Q linad99\${CCVERSION}-${OSVERSION}slp
	if exist nh99\${CCVERSION}-${OSVERSION}olp rd /S /Q nh99\${CCVERSION}-${OSVERSION}olp
	if exist tools99\${CCVERSION}-${OSVERSION}olp rd /S /Q tools99\${CCVERSION}-${OSVERSION}olp
	if exist df1b2-separable\lex.yy.c del df1b2-separable\lex.yy.c
	if exist df1b2-separable\tpl2rem.c del df1b2-separable\tpl2rem.c
	if exist df1b2-separable\tpl2rem.exe del df1b2-separable\tpl2rem.exe
	if exist nh99\lex.yy.c del nh99\lex.yy.c
	if exist nh99\tpl2cpp.c del nh99\tpl2cpp.c
	if exist nh99\tpl2cpp.exe del nh99\tpl2cpp.exe
