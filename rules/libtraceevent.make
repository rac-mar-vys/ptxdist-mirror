# -*-makefile-*-
#
# Copyright (C) 2024 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTRACEEVENT) += libtraceevent

#
# Paths and names
#
LIBTRACEEVENT_VERSION	:= 1.9.0
LIBTRACEEVENT_SHA256	:= 1ed2e47cfd44080fda9c9e33be4b128680958001ced286fe719abc85136b259d
LIBTRACEEVENT		:= libtraceevent-$(LIBTRACEEVENT_VERSION)
LIBTRACEEVENT_SUFFIX	:= tar.xz
LIBTRACEEVENT_URL	:= https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git;tag=libtraceevent-$(LIBTRACEEVENT_VERSION)
LIBTRACEEVENT_SOURCE	:= $(SRCDIR)/$(LIBTRACEEVENT).$(LIBTRACEEVENT_SUFFIX)
LIBTRACEEVENT_DIR	:= $(BUILDDIR)/$(LIBTRACEEVENT)
LIBTRACEEVENT_LICENSE	:= LGPL-2.1-only AND GPL-2.0-only
LIBTRACEEVENT_LICENSE_FILES := \
	file://LICENSES/GPL-2.0;md5=e6a75371ba4d16749254a51215d13f97 \
	file://LICENSES/LGPL-2.1;md5=b370887980db5dd40659b50909238dbd \
	file://plugins/plugin_scsi.c;startline=1;endline=1;md5=50d2ba0afecd20f74c12a4bdbcfcfe61 \
	file://src/event-parse.c;startline=1;endline=11;md5=3373f94e7cee2c35310a0e3bf7ebf6dc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBTRACEEVENT_CONF_ENV	:= $(CROSS_ENV)

#
# meson
#
LIBTRACEEVENT_CONF_TOOL	:= meson

# There are some more configuration variables that don't have any effect given
# -Ddoc=false.
# Currently these are: docbook-suppress-sp, docbook-xls-172, htmldir, man-bold-literal
#
# The variable plugindir defaults to '' which is then interpreted as
# join_paths(libdir, 'traceevent/plugins')
LIBTRACEEVENT_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddoc=false \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtraceevent.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtraceevent)
	@$(call install_fixup, libtraceevent, PRIORITY, optional)
	@$(call install_fixup, libtraceevent, SECTION, base)
	@$(call install_fixup, libtraceevent, AUTHOR, "Uwe Kleine-König <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, libtraceevent, DESCRIPTION, missing)

	@$(call install_lib, libtraceevent, 0, 0, 0644, libtraceevent)

	@for plugin in cfg80211 function futex hrtimer jbd2 kmem kvm mac80211 sched_switch scsi tlb xen; do \
		$(call install_lib, libtraceevent, 0, 0, 0644, traceevent/plugins/plugin_$${plugin}); \
	done

	@$(call install_finish, libtraceevent)

	@$(call touch)

# vim: syntax=make
