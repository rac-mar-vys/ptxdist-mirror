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
PACKAGES-$(PTXCONF_NETOPEER2) += netopeer2

#
# Paths and names
#
NETOPEER2_VERSION	:= 2.1.59
NETOPEER2_MD5		:= 6b4e0502e8338e536ed359c11b6ed004
NETOPEER2		:= netopeer2-$(NETOPEER2_VERSION)
NETOPEER2_SUFFIX	:= tar.gz
NETOPEER2_URL		:= https://github.com/CESNET/netopeer2/archive/refs/tags/v$(NETOPEER2_VERSION).$(NETOPEER2_SUFFIX)
NETOPEER2_SOURCE	:= $(SRCDIR)/$(NETOPEER2).$(NETOPEER2_SUFFIX)
NETOPEER2_DIR		:= $(BUILDDIR)/$(NETOPEER2)
NETOPEER2_LICENSE	:= unknown
NETOPEER2_LICENSE_FILES	:=

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(NETOPEER2_SOURCE):
#	@$(call targetinfo)
#	@$(call get, NETOPEER2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETOPEER2_CONF_ENV	:= $(CROSS_ENV)

#
# cmake
#
NETOPEER2_CONF_TOOL	:= cmake
NETOPEER2_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DINSTALL_MODULES=OFF \
	-DGENERATE_HOSTKEY=OFF \
	-DMERGE_LISTEN_CONFIG=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netopeer2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netopeer2)
	@$(call install_fixup, netopeer2,PRIORITY,optional)
	@$(call install_fixup, netopeer2,SECTION,base)
	@$(call install_fixup, netopeer2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, netopeer2,DESCRIPTION,missing)

	@$(call install_copy, netopeer2, 0, 0, 0755, -, /usr/bin/netopeer2-cli)
	@$(call install_copy, netopeer2, 0, 0, 0755, -, /usr/sbin/netopeer2-server)
	@$(call install_tree, netopeer2, 0, 0, -, /usr/share/yang)

	@$(call install_copy, netopeer2, 0, 0, 0755, $(NETOPEER2_DIR)/scripts/setup.sh, /usr/share/netopeer2/setup.sh)
	@$(call install_copy, netopeer2, 0, 0, 0755, $(NETOPEER2_DIR)/scripts/merge_config.sh, /usr/share/netopeer2/merge_config.sh)
	@$(call install_copy, netopeer2, 0, 0, 0755, $(NETOPEER2_DIR)/scripts/merge_hostkey.sh, /usr/share/netopeer2/merge_hostkey.sh)

	@$(call install_finish, netopeer2)

	@$(call touch)

# vim: syntax=make
