# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module desktop

DESCRIPTION="Native API Testing Tool"
HOMEPAGE="https://chapar.rest https://github.com/chapar-rest/chapar"
SRC_URI="https://github.com/chapar-rest/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# SPDX:BSD-3-Clause is 'BSD' in Gentoo
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.22.2
"

src_configure() {
	export CGO_ENABLED=1
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	default
}

src_prepare() {
	sed -i 's/chapar.png/chapar/' build/desktop-assets/${PN}.desktop
	sed -i '/Version/d' build/desktop-assets/${PN}.desktop
	default
}

src_compile() {
	ego build
}

src_install() {
	dobin ${PN}

	domenu build/desktop-assets/${PN}.desktop
	newicon build/appicon.png ${PN}.png
}
