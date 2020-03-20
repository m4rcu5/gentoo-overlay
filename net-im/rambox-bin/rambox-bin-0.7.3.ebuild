# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils gnome2-utils xdg unpacker

MY_PN=${PN/-bin}

DESCRIPTION="Free and Open Source messaging and emailing app that combines common web applications into one."
HOMEPAGE="http://rambox.pro/"
SRC_URI="
	amd64? ( https://github.com/ramboxapp/community-edition/releases/download/${PV}/${MY_PN^}-${PV}-linux-amd64.deb -> ${P}-amd64.deb )
	x86? ( https://github.com/ramboxapp/community-edition/releases/download/${PV}/${MY_PN^}-${PV}-linux-i386.deb -> ${P}-i386.deb )
"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RESTRICT="mirror bindist"

RDEPEND="dev-libs/nss
	media-libs/alsa-lib
	gnome-base/gconf:2
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXtst
	x11-libs/libXScrnSaver
"

QA_EXECSTACK="opt/${MY_PN^}/${MY_PN}"
QA_PRESTRIPPED="
	opt/${MY_PN^}/lib.*
	opt/${MY_PN^}/${MY_PN}
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# fix crash on some systems due to https://github.com/ramboxapp/community-edition/issues/2481
	chmod 4755 "${S}"/opt/${MY_PN}/chrome-sandbox

	mv "${S}"/{opt,usr} "${D}"/ || die
}

pkg_preinst() {
	gnome2_icon_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_pkg_postrm
}

