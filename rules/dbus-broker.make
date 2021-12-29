# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS_BROKER) += dbus-broker

#
# Paths and names
#
DBUS_BROKER_VERSION	:= 29
DBUS_BROKER_MD5		:= 9bf9266f2874b39839cf57536ddeb899
DBUS_BROKER		:= dbus-broker-$(DBUS_BROKER_VERSION)
DBUS_BROKER_SUFFIX	:= tar.xz
DBUS_BROKER_URL		:= https://github.com/bus1/dbus-broker/releases/download/v$(DBUS_BROKER_VERSION)/$(DBUS_BROKER).$(DBUS_BROKER_SUFFIX)
DBUS_BROKER_SOURCE	:= $(SRCDIR)/$(DBUS_BROKER).$(DBUS_BROKER_SUFFIX)
DBUS_BROKER_DIR		:= $(BUILDDIR)/$(DBUS_BROKER)
DBUS_BROKER_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
DBUS_BROKER_CONF_TOOL	:= meson
DBUS_BROKER_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Daudit=false \
	-Dc-shquote:reference-test=false \
	-Ddocs=false \
	-Dlauncher=true \
	-Dreference-test=false \
	-Dselinux=false \
	-Dsystem-console-users="[]"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-broker.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus-broker)
	@$(call install_fixup, dbus-broker,PRIORITY,optional)
	@$(call install_fixup, dbus-broker,SECTION,base)
	@$(call install_fixup, dbus-broker,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, dbus-broker,DESCRIPTION,missing)

	@$(call install_copy, dbus-broker, 0, 0, 0755, -, \
		/usr/bin/dbus-broker)
	@$(call install_copy, dbus-broker, 0, 0, 0755, -, \
		/usr/bin/dbus-broker-launch)

	@$(call install_alternative, dbus-broker, 0, 0, 0644, \
		/usr/share/dbus-1/system.conf)

	@$(call install_copy, dbus-broker, 0, 0, 0644, -, \
		/usr/lib/systemd/system/dbus-broker.service)
	@$(call install_link, dbus-broker, dbus-broker.service, \
		/usr/lib/systemd/system/dbus.service)

	@$(call install_alternative, dbus-broker, 0, 0, 0644, \
		/usr/lib/systemd/system/dbus.socket)
	@$(call install_link, dbus-broker, ../dbus.socket, \
		/usr/lib/systemd/system/sockets.target.wants/dbus.socket)

	@$(call install_finish, dbus-broker)

	@$(call touch)

# vim: syntax=make
