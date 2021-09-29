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
PACKAGES-$(PTXCONF_SYSREPO) += sysrepo

#
# Paths and names
#
SYSREPO_VERSION		:= 2.2.60
SYSREPO_MD5		:= f3658f093deb4b64717817c21d1375c9
SYSREPO			:= sysrepo-$(SYSREPO_VERSION)
SYSREPO_SUFFIX		:= tar.gz
SYSREPO_URL		:= https://github.com/sysrepo/sysrepo/archive/refs/tags/v$(SYSREPO_VERSION).$(SYSREPO_SUFFIX)
SYSREPO_SOURCE		:= $(SRCDIR)/$(SYSREPO).$(SYSREPO_SUFFIX)
SYSREPO_DIR		:= $(BUILDDIR)/$(SYSREPO)
SYSREPO_LICENSE		:= unknown
SYSREPO_LICENSE_FILES	:=

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSREPO_CONF_ENV	:= $(CROSS_ENV)

#
# cmake
#
SYSREPO_CONF_TOOL	:= cmake
SYSREPO_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DSYSREPO_GROUP=sysrepo \
	-DSYSREPO_UMASK=00007

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysrepo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysrepo)
	@$(call install_fixup, sysrepo,PRIORITY,optional)
	@$(call install_fixup, sysrepo,SECTION,base)
	@$(call install_fixup, sysrepo,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, sysrepo,DESCRIPTION,missing)

	@$(call install_copy, sysrepo, 0, 119, 0755, -, /usr/bin/sysrepocfg)
	@$(call install_copy, sysrepo, 0, 119, 0755, -, /usr/bin/sysrepoctl)
	@$(call install_copy, sysrepo, 0, 119, 0755, -, /usr/bin/sysrepo-plugind)
	@$(call install_lib, sysrepo, 0, 0, 0644, libsysrepo)

	@$(call install_finish, sysrepo)

	@$(call touch)

# vim: syntax=make
