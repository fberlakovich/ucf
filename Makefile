############################ -*- Mode: Makefile -*- ###########################
## Makefile<ucf> --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Tue Nov 18 22:00:27 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Tue Nov 18 22:43:32 2003
## Last Machine Used: glaurung.green-gryphon.com
## Update Count     : 2
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
###############################################################################
prefix    =
package   = ucf

ETCDIR    = $(prefix)/etc
BINDIR    = $(prefix)/usr/bin
DEBLIBDIR = $(prefix)/var/lib/$(package)
DEBDOCDIR = $(prefix)/usr/share/doc/$(package)
MANDIR    = $(prefix)/usr/share/man/
MAN1DIR   = $(MANDIR)/man1
MAN5DIR   = $(MANDIR)/man5

# install commands
install_file    := /usr/bin/install -p    -o root -g root -m 644
install_program := /usr/bin/install -p    -o root -g root -m 755
make_directory  := /usr/bin/install -p -d -o root -g root -m 755

all build: check

check:
	bash -n ucf
	bash -n debian/preinst
	bash -n debian/postinst
	bash -n debian/postrm

install:
	$(make_directory)   $(BINDIR)
	$(make_directory)   $(ETCDIR)
	$(make_directory)   $(MAN1DIR)
	$(make_directory)   $(MAN5DIR)
	$(make_directory)   $(DEBLIBDIR)
	$(make_directory)   $(DEBDOCDIR)/examples
	$(install_program)  ucf               $(BINDIR)
	$(install_file)     ucf.1             $(MAN1DIR)
	gzip -9fq           $(MAN1DIR)/ucf.1
	$(install_program)  lcf               $(BINDIR)
	$(install_file)     lcf.1             $(MAN1DIR)
	gzip -9fq           $(MAN1DIR)/lcf.1
	$(install_file)     ucf.conf.5        $(MAN5DIR)
	gzip -9fq           $(MAN5DIR)/ucf.conf.5 
	$(install_file)     ucf.conf          $(ETCDIR)
	$(install_file)     debian/changelog  $(DEBDOCDIR)/changelog
	gzip -9frq          $(DEBDOCDIR)
# make sure the copyright file is not compressed
	$(install_file)     debian/copyright  $(DEBDOCDIR)/copyright
	$(install_file)     examples/postinst $(DEBDOCDIR)/examples/
	$(install_file)     examples/postrm   $(DEBDOCDIR)/examples/

clean distclean:
	@echo nothing to do for clean

