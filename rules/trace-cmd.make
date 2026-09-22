# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TRACE_CMD) += trace-cmd

#
# Paths and names
#
TRACE_CMD_VERSION	:= 3.4
TRACE_CMD_SHA256	:= 604085ab395cc2cb84397dc3d209ea0d0b15ae506f8ea91ff45c86e5a050213c
TRACE_CMD		:= trace-cmd-v$(TRACE_CMD_VERSION)
TRACE_CMD_SUFFIX	:= tar.gz
TRACE_CMD_URL		:= https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/$(TRACE_CMD).$(TRACE_CMD_SUFFIX)
TRACE_CMD_SOURCE	:= $(SRCDIR)/$(TRACE_CMD).$(TRACE_CMD_SUFFIX)
TRACE_CMD_DIR		:= $(BUILDDIR)/$(TRACE_CMD)
TRACE_CMD_LICENSE	:= LGPL-2.1-only AND GPL-2.0-only
TRACE_CMD_LICENSE_FILES := \
	file://COPYING;md5=873f48a813bded3de6ebc54e6880c4ac \
	file://LICENSES/GPL-2.0;md5=e6a75371ba4d16749254a51215d13f97 \
	file://LICENSES/LGPL-2.1;md5=b370887980db5dd40659b50909238dbd \
	file://tracecmd/trace-cmd.c;startline=1;endline=5;md5=2d40f2034a6256f8c0626afae63d082e \
	file://tracecmd/include/list.h;startline=1;endline=5;md5=59c09346cdcb6e83d9dcb190e3ea6e87

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TRACE_CMD_CONF_TOOL	:= meson

TRACE_CMD_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddoc=false \
	-Dptrace=false \
	-Dpython=false \
	-Dutest=false \
	-Dvsock=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/trace-cmd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, trace-cmd)
	@$(call install_fixup, trace-cmd,PRIORITY,optional)
	@$(call install_fixup, trace-cmd,SECTION,base)
	@$(call install_fixup, trace-cmd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, trace-cmd,DESCRIPTION,missing)

	@$(call install_copy, trace-cmd, 0, 0, 0755, -, /usr/bin/trace-cmd)

	@$(call install_finish, trace-cmd)

	@$(call touch)

# vim: syntax=make
