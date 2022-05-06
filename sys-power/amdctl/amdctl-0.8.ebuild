# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit cmake

DESCRIPTION="Set P-State voltages and clock speeds on recent AMD CPUs on Linux."
HOMEPAGE="https://github.com/kevinlekiller/amdctl"
SRC_URI="https://github.com/kevinlekiller/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND=""
#RDEPEND="${DEPEND}"
#BDEPEND=""

RESTRICT="mirror"

src_install() {
	dosbin "${S}/${PN}"
	dodoc "${S}"/README.md
}
