# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="List of packages I want o install everywhere"
#HOMEPAGE=""
#SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	sys-apps/usbutils
	sys-apps/pciutils
	sys-process/lsof
	app-misc/tmux
	app-portage/gentoolkit
	app-portage/layman
	net-analyzer/traceroute
	sys-apps/iproute2
	sys-apps/smartmontools
	sys-block/parted
	sys-process/iotop
"
RDEPEND="${DEPEND}"
