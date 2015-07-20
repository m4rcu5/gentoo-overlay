# Copyright 2015 Digital Integrity GmbH
# Distributed under the terms of the GNU General Public License v3

EAPI=5

inherit git-2

DESCRIPTION="Backup tool for btrfs volumes"
HOMEPAGE="http://www.digint.ch/btrbk/"
EGIT_REPO_URI="git://dev.tty0.ch/btrbk.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="dev-lang/perl
         dev-perl/Date-Calc
         sys-fs/btrfs-progs"

src_install() {
        dosbin btrbk
	dodoc README.md
	dodoc ChangeLog
	doman doc/btrbk.1
	doman doc/btrbk.conf.5
	insinto /etc/${PN}
	doins btrbk.conf.example
	insinto /usr/share/${PN}/
	doins ssh_filter_btrbk.sh
}
