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
PACKAGES-$(PTXCONF_LIBSSH) += libssh

#
# Paths and names
#
LIBSSH_VERSION		:= 0.10.4
LIBSSH_MD5		:= cb2e47ac2de59eefa31a57ae53b44363
LIBSSH			:= libssh-$(LIBSSH_VERSION)
LIBSSH_SUFFIX		:= tar.xz
LIBSSH_URL		:= https://www.libssh.org/files/0.10/$(LIBSSH).$(LIBSSH_SUFFIX)
LIBSSH_SOURCE		:= $(SRCDIR)/$(LIBSSH).$(LIBSSH_SUFFIX)
LIBSSH_DIR		:= $(BUILDDIR)/$(LIBSSH)
LIBSSH_LICENSE		:= unknown
LIBSSH_LICENSE_FILES	:=

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSSH_CONF_ENV	:= $(CROSS_ENV)

#
# cmake
#
LIBSSH_CONF_TOOL	:= cmake
LIBSSH_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libssh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libssh)
	@$(call install_fixup, libssh,PRIORITY,optional)
	@$(call install_fixup, libssh,SECTION,base)
	@$(call install_fixup, libssh,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libssh,DESCRIPTION,missing)

	@$(call install_lib, libssh, 0, 0, 0644, libssh)

	@$(call install_finish, libssh)

	@$(call touch)

# vim: syntax=make
