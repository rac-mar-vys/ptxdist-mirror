# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFFI) += libffi

#
# Paths and names
#
LIBFFI_VERSION		:= 3.8.0
LIBFFI_SHA256		:= 7da3e2d9a171eb0a038f592ecad3ff2bb2550f3496d87b3b29ad0cf4430c0db4
LIBFFI			:= libffi-$(LIBFFI_VERSION)
LIBFFI_SUFFIX		:= tar.gz
LIBFFI_SOURCE		:= $(SRCDIR)/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_DIR		:= $(BUILDDIR)/$(LIBFFI)
LIBFFI_URL		:= https://github.com/libffi/libffi/releases/download/v$(LIBFFI_VERSION)/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_LICENSE		:= MIT
LIBFFI_LICENSE_FILES	:= \
	file://LICENSE;md5=5e9a8df556846bb3d1edec0d968a2311

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFFI_CONF_TOOL := autoconf
LIBFFI_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-builddir \
	--disable-static \
	--enable-portable-binary \
	--disable-pax_emutramp \
	--disable-docs \
	--disable-debug \
	--enable-structs \
	--enable-raw-api \
	--enable-exec-static-tramp \
	--disable-purify-safety \
	--disable-multi-os-directory \
	--without-gcc-arch

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libffi)
	@$(call install_fixup, libffi,PRIORITY,optional)
	@$(call install_fixup, libffi,SECTION,base)
	@$(call install_fixup, libffi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libffi,DESCRIPTION,missing)

	@$(call install_lib, libffi, 0, 0, 0644, libffi)

	@$(call install_finish, libffi)

	@$(call touch)

# vim: syntax=make
