# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="MultiMarkdown, is a tool to help turn minimally marked-up plain text into well formatted documents, including HTML, PDF (by way of LaTeX), OPML, or OpenDocument."
HOMEPAGE="http://fletcherpenney.net/multimarkdown/"

EGIT_REPO_URI="https://github.com/fletcher/MultiMarkdown-4"
EGIT_HAS_SUBMODULES=1
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
    emake multimarkdown || die "emake failed"
}

src_install() {
    # make pkg-install
    dobin multimarkdown

    dodoc documentation/MMD_Users_Guide.pdf
}
