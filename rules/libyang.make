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
PACKAGES-$(PTXCONF_LIBYANG) += libyang

#
# Paths and names
#
LIBYANG_VERSION		:= 2.1.55
LIBYANG_MD5		:= e74d7d1a1b46f11a3b00534737e3c47b
LIBYANG			:= libyang-$(LIBYANG_VERSION)
LIBYANG_SUFFIX		:= tar.gz
LIBYANG_URL		:= https://github.com/CESNET/libyang/archive/refs/tags/v$(LIBYANG_VERSION).$(LIBYANG_SUFFIX)
LIBYANG_SOURCE		:= $(SRCDIR)/$(LIBYANG).$(LIBYANG_SUFFIX)
LIBYANG_DIR		:= $(BUILDDIR)/$(LIBYANG)
LIBYANG_LICENSE		:= unknown
LIBYANG_LICENSE_FILES	:=

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBYANG_CONF_ENV	:= $(CROSS_ENV)

#
# cmake
#
LIBYANG_CONF_TOOL	:= cmake
LIBYANG_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libyang.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libyang)
	@$(call install_fixup, libyang,PRIORITY,optional)
	@$(call install_fixup, libyang,SECTION,base)
	@$(call install_fixup, libyang,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libyang,DESCRIPTION,missing)

	@$(call install_lib, libyang, 0, 0, 0644, libyang)

	@$(call install_finish, libyang)

	@$(call touch)
