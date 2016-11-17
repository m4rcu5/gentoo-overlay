# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit unpacker versionator

MY_PV=$(replace_version_separator 3 '-')
MY_P="${PN}_${MY_PV}"

DESCRIPTION="The Chef Development Kit contains everything you need to start using Chef along with the tools essential to managing the code that runs your business."
HOMEPAGE="http://downloads.getchef.com/chef-dk/"
SRC_URI_BASE="https://packages.chef.io"
SRC_URI="${SRC_URI_BASE}/stable/ubuntu/12.04/${MY_P}_amd64.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}

src_unpack() {
    unpack_deb ${A}
}

src_prepare() {
    find ${S} -name ".git" | xargs  rm -rf

    # Gentoo RUBYOPT compatibility
    for r in ${S}/opt/chefdk/embedded/lib/ruby/site_ruby/*; do echo 
        touch -- "$r/auto_gem.rb"; 
    done
}

src_install() {
    local dest="/opt/chefdk"
	local ddest="${ED}${dest}"

    dodir /usr/bin
	dodir "${dest}"

    # install source
    cp -pPR opt/chefdk/* "$ddest"

    # binaries as installed by debian/postinst
    binaries="chef chef-solo chef-apply chef-shell knife shef ohai berks chef-zero fauxhai foodcritic kitchen rubocop strain strainer chef-client"

    for binary in $binaries; do
        dosym ${dest}/bin/${binary} /usr/bin/${binary} || die "Cannot link ${binary}"
    done
}
