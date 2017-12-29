# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1

DESCRIPTION="A dotfile manager for the config files in your home folder"
HOMEPAGE="https://github.com/TheLocehiliosan/yadm/"
SRC_URI="https://github.com/TheLocehiliosan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zsh-completion test"

DOCS=( CHANGES CONTRIBUTORS README.md )

DEPEND="
	test? (
		dev-tcltk/expect
		dev-util/bats
		dev-vcs/git
	)"
RDEPEND="
    zsh-completion? ( app-shells/gentoo-zsh-completions )
	app-crypt/gnupg
	dev-vcs/git"

src_compile() {
	emake yadm.md
}

src_test() {
	# 109_accept_encryption tests are interactive, thus fail. Skip them
	# 113_accept_jinja_alt.bats are depepending on the optional envtpl
	while IFS="" read -d $'\0' -r f ; do
		bats "${f}" || die "Test ${f} failed"
	done < <(find test -name '*.bats' -and -not -name '109_accept_encryption.bats' -and -not -name '113_accept_jinja_alt.bats' -print0)
}

src_install() {
	einstalldocs

	dobin "${PN}"
	doman "${PN}.1"

	dobashcomp completion/yadm.bash_completion
	if use zsh-completion; then
        insinto /usr/share/zsh/site-functions
        newins completion/yadm.zsh_completion _${PN}
 	fi
}
