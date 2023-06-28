# make makefile
# 
# Tools used:
#  Compile::Resource Compiler
#  Compile::GNU C
#  Make: make

CFLAGS=-Wall -Zomf -c -O2
DEBUGFLAGS=-g

HEADERS = main.h xtrn.h help.c
OBJS = main.obj user.obj init.obj pnt.obj dlg.obj help.obj file.obj edit.obj thrd.obj
ALL_IPF = template.ipf file.ipf edit.ipf help.ipf dlg.ipf menu.ipf

all : template.exe template.hlp

template.exe: $(OBJS) template.res
	gcc -Zomf -Zmap $(OBJS) template.def template.res -o $@
	wrc template.res

main.obj: main.c $(HEADER)
	gcc $(CFLAGS) $(DEBUGFLAGS) main.c -o main.obj

file.obj: file.c $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) file.c -o file.obj

edit.obj: edit.c $(HEADERS) 
	gcc $(CFLAGS) $(DEBUGFLAGS) edit.c -o edit.obj

user.obj: user.c $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) user.c -o user.obj

init.obj: init.c $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) init.c -o init.obj

pnt.obj: pnt.c  $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) pnt.c -o pnt.obj

dlg.obj: dlg.c  $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) dlg.c -o dlg.obj

help.obj: help.c $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) help.c -o help.obj

thrd.obj: thrd.c $(HEADERS)
	gcc $(CFLAGS) $(DEBUGFLAGS) thrd.c -o thrd.obj

main.res: main.rc main.ico template.dlg help.rc prodinfo.bmp $(HEADERS)
	wrc -r main.rc

template.res: main.res main.ico
	$(shell mv main.res template.res)

template.hlp: $(ALL_IPF)
	wipfc template.ipf -o template.hlp

.PHONY : clean

clean :
	rm -rf *exe *res *obj *lib *.hlp

# MAKEFILE NOTES
#
# $@ is the name of the target being generated.
#
# .PHONY - Read about .PHONY at: https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
#