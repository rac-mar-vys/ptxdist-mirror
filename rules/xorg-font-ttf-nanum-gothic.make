# -*-makefile-*-
#
# Copyright (C) 2026 by Thorsten Scherer <t.scherer@eckelmann.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_NANUM_GOTHIC) += xorg-font-ttf-nanum-gothic

#
# Paths and names
#
XORG_FONT_TTF_NANUM_GOTHIC_VERSION	:= 20200506
XORG_FONT_TTF_NANUM_GOTHIC_SHA256	:= 157803748198151250a3cf7cb03aef844e408e9c98849dd889e191846aacad4b
XORG_FONT_TTF_NANUM_GOTHIC		:= fonts-nanum-$(XORG_FONT_TTF_NANUM_GOTHIC_VERSION)
XORG_FONT_TTF_NANUM_GOTHIC_SUFFIX	:= tar.xz
# upstream (hangeul.naver.com) has no stable URL; use the Debian archived source instead
XORG_FONT_TTF_NANUM_GOTHIC_URL		:= https://snapshot.debian.org/archive/debian/20200515T024132Z/pool/main/f/fonts-nanum/fonts-nanum_$(XORG_FONT_TTF_NANUM_GOTHIC_VERSION).orig.$(XORG_FONT_TTF_NANUM_GOTHIC_SUFFIX)
XORG_FONT_TTF_NANUM_GOTHIC_MD5		:= 6b4d390e048d809d4152cea82e5ec6c4
XORG_FONT_TTF_NANUM_GOTHIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_NANUM_GOTHIC).$(XORG_FONT_TTF_NANUM_GOTHIC_SUFFIX)
XORG_FONT_TTF_NANUM_GOTHIC_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_NANUM_GOTHIC)
XORG_FONT_TTF_NANUM_GOTHIC_LICENSE	:= OFL-1.1

XORG_FONT_TTF_NANUM_GOTHIC_CONF_TOOL	:= NO
XORG_FONT_TTF_NANUM_GOTHIC_FONTDIR	:= $(XORG_FONTDIR)/truetype/nanum

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-nanum-gothic.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# only the plain Sans-serif weights; the upstream archive also ships
# Myeongjo/Brush/Pen/BarunGothic/Square variants we don't need here
$(STATEDIR)/xorg-font-ttf-nanum-gothic.install:
	@$(call targetinfo)
	@rm -rf $(XORG_FONT_TTF_NANUM_GOTHIC_PKGDIR)
	@install -d $(XORG_FONT_TTF_NANUM_GOTHIC_PKGDIR)$(XORG_FONT_TTF_NANUM_GOTHIC_FONTDIR)
	@install -m 644 \
		$(XORG_FONT_TTF_NANUM_GOTHIC_DIR)/NanumGothic.ttf \
		$(XORG_FONT_TTF_NANUM_GOTHIC_DIR)/NanumGothicBold.ttf \
		$(XORG_FONT_TTF_NANUM_GOTHIC_PKGDIR)$(XORG_FONT_TTF_NANUM_GOTHIC_FONTDIR)
	@mkfontdir $(XORG_FONT_TTF_NANUM_GOTHIC_PKGDIR)$(XORG_FONT_TTF_NANUM_GOTHIC_FONTDIR)
	@mkfontscale $(XORG_FONT_TTF_NANUM_GOTHIC_PKGDIR)$(XORG_FONT_TTF_NANUM_GOTHIC_FONTDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-nanum-gothic.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-nanum-gothic)
	@$(call install_fixup, xorg-font-ttf-nanum-gothic,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-nanum-gothic,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-nanum-gothic,AUTHOR,"Thorsten Scherer <t.scherer@eckelmann.de>")
	@$(call install_fixup, xorg-font-ttf-nanum-gothic,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-nanum-gothic, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-nanum-gothic)
	@$(call touch)

# vim: syntax=make
