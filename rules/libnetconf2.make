# -*-makefile-*-
#
# Copyright (C) 2021 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETCONF2) += libnetconf2

#
# Paths and names
#
LIBNETCONF2_VERSION		:= 2.1.31
LIBNETCONF2_MD5			:= c49f714384d08ca24d4a3f62d83c04d9
LIBNETCONF2			:= libnetconf2-$(LIBNETCONF2_VERSION)
LIBNETCONF2_SUFFIX		:= tar.gz
LIBNETCONF2_URL			:= https://github.com/CESNET/libnetconf2/archive/refs/tags/v$(LIBNETCONF2_VERSION).$(LIBNETCONF2_SUFFIX)
LIBNETCONF2_SOURCE		:= $(SRCDIR)/$(LIBNETCONF2).$(LIBNETCONF2_SUFFIX)
LIBNETCONF2_DIR			:= $(BUILDDIR)/$(LIBNETCONF2)
LIBNETCONF2_LICENSE		:= unknown
LIBNETCONF2_LICENSE_FILES	:=

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNETCONF2_CONF_TOOL	:= cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetconf2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetconf2)
	@$(call install_fixup, libnetconf2,PRIORITY,optional)
	@$(call install_fixup, libnetconf2,SECTION,base)
	@$(call install_fixup, libnetconf2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnetconf2,DESCRIPTION,missing)

	@$(call install_lib, libnetconf2, 0, 0, 0644, libnetconf2)

	@$(call install_finish, libnetconf2)

	@$(call touch)

# vim: syntax=make
