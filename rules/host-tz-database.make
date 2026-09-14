# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TZ_DATABASE) += host-tz-database

#
# Paths and names
#
HOST_TZ_DATABASE	:= tz-database
HOST_TZ_DATABASE_DIR	:= $(HOST_BUILDDIR)/$(HOST_TZ_DATABASE)
HOST_TZ_DATABASE_VERSION:= 2026d

TZCODE_VERSION		:= $(HOST_TZ_DATABASE_VERSION)
TZCODE_SHA256		:= 2f5c9f7fe29e6b8cb863583667884b8ce17b0a485355a054b591c6bdfcd81791
TZCODE			:= tzcode$(TZCODE_VERSION)
TZCODE_SUFFIX		:= tar.gz
TZCODE_URL		:= \
	http://www.iana.org/time-zones/repository/releases/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_SOURCE		:= $(SRCDIR)/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_DIR		:= $(HOST_TZ_DATABASE_DIR)
TZCODE_STRIP_LEVEL	:= 0

TZDATA_VERSION		:= $(HOST_TZ_DATABASE_VERSION)
TZDATA_SHA256		:= 0cb2aa8e333c3dc049badc42a0c61f21987b8cd44e107fa900bad764aacc7767
TZDATA			:= tzdata$(TZDATA_VERSION)
TZDATA_SUFFIX		:= tar.gz
TZDATA_URL		:= \
	http://www.iana.org/time-zones/repository/releases/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_SOURCE		:= $(SRCDIR)/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_DIR		:= $(HOST_TZ_DATABASE_DIR)
TZDATA_STRIP_LEVEL	:= 0

HOST_TZ_DATABASE_PARTS	:= TZCODE TZDATA
HOST_TZ_DATABASE_LICENSE := public_domain AND BSD-3-Clause
HOST_TZ_DATABASE_LICENSE_FILES := \
	file://LICENSE;md5=c679c9d6b02bc2757b3eaf8f53c43fba \
	file://date.c;startline=3;endline=28;md5=0b516100709f6de9dc65257bf91e6dd0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TZ_DATABASE_CONF_TOOL	:= NO
HOST_TZ_DATABASE_MAKE_OPT	:= \
	zic TZDIR=/usr/share/zoneinfo CFLAGS=-DSTD_INSPIRED
HOST_TZ_DATABASE_INSTALL_OPT	:= \
	REDO=posix_only TZDIR=/usr/share/zoneinfo install

# vim: syntax=make
