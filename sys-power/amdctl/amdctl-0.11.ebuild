# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Set P-State voltages and clock speeds on recent AMD CPUs on Linux."
HOMEPAGE="https://github.com/kevinlekiller/amdctl"

if [[ "${PV}" == *9999* ]]; then
		EGIT_REPO_URI="https://github.com/kevinlekiller/amdctl.git"
		inherit git-r3
else
		SRC_URI="https://github.com/kevinlekiller/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror"

src_install() {
	dosbin "${S}/${PN}"
	dodoc "${S}"/README.md
}
