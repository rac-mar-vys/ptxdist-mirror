# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XZ) += xz

#
# Paths and names
#
XZ_VERSION	:= 5.8.4
XZ_SHA256	:= b6b34c52e672e810d339db14e0c10b5b6f5f67a30d8d05cdac5d8cb4d82f78d5
XZ		:= xz-$(XZ_VERSION)
XZ_SUFFIX	:= tar.gz
XZ_URL		:= https://github.com/tukaani-project/xz/archive/refs/tags/v$(XZ_VERSION).$(XZ_SUFFIX)
XZ_SOURCE	:= $(SRCDIR)/$(XZ).$(XZ_SUFFIX)
XZ_DIR		:= $(BUILDDIR)/$(XZ)
XZ_LICENSE	:= 0BSD AND public_domain AND LGPL-2.1-or-later AND GPL-2.0-or-later AND GPL-3.0-or-later
XZ_LICENSE_FILES := \
	file://COPYING;md5=d38d562f6112174de93a9677682231b2 \
	file://COPYING.GPLv2;md5=570a9b3749dd0463a1778803b12a6dce \
	file://COPYING.GPLv3;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://COPYING.LGPLv2.1;md5=4bf661c1e3793e55c8d1051bc5e0ae21

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XZ_CONF_TOOL	:= cmake
XZ_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF \
	-DTUKLIB_USE_UNSAFE_TYPE_PUNNING=OFF \
	-DXZ_DOC=OFF \
	-DXZ_DOXYGEN=OFF \
	-DXZ_EXTERNAL_SHA256=OFF \
	-DXZ_LZIP_DECODER=OFF \
	-DXZ_MICROLZMA_DECODER=OFF \
	-DXZ_MICROLZMA_ENCODER=OFF \
	-DXZ_NLS=OFF \
	-DXZ_SANDBOX=no \
	-DXZ_SMALL=OFF \
	-DXZ_SYMBOL_VERSIONING=linux \
	-DXZ_THREADS=yes \
	-DXZ_TOOL_LZMADEC=OFF \
	-DXZ_TOOL_LZMAINFO=OFF \
	-DXZ_TOOL_SCRIPTS=$(call ptx/onoff,PTXCONF_XZ_TOOLS) \
	-DXZ_TOOL_SYMLINKS=OFF \
	-DXZ_TOOL_SYMLINKS_LZMA=OFF \
	-DXZ_TOOL_XZ=$(call ptx/onoff,PTXCONF_XZ_TOOLS) \
	-DXZ_TOOL_XZDEC=$(call ptx/onoff,PTXCONF_XZ_TOOLS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xz.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xz)
	@$(call install_fixup, xz,PRIORITY,optional)
	@$(call install_fixup, xz,SECTION,base)
	@$(call install_fixup, xz,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xz,DESCRIPTION,missing)

	@$(call install_lib, xz, 0, 0, 0644, liblzma)
ifdef PTXCONF_XZ_TOOLS
	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xz)
	@$(call install_link, xz, xz, /usr/bin/unxz)
	@$(call install_link, xz, xz, /usr/bin/xzcat)

	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xzdec)

	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xzdiff)
	@$(call install_link, xz, xzdiff, /usr/bin/xzcmp)

	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xzgrep)
	@$(call install_link, xz, xzgrep, /usr/bin/xzegrep)
	@$(call install_link, xz, xzgrep, /usr/bin/xzfgrep)

	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xzless)
	@$(call install_copy, xz, 0, 0, 0755, -, /usr/bin/xzmore)
endif

	@$(call install_finish, xz)

	@$(call touch)

# vim: syntax=make
