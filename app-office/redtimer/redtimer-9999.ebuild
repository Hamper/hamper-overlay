# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils desktop

DESCRIPTION="Redmine Time Tracker"
HOMEPAGE="https://github.com/fathomssen/redtimer"
if [[ ${PV} == *9999* ]]; then
        EGIT_REPO_URI="https://github.com/fathomssen/redtimer.git"
        inherit git-r3
else
        SRC_URI="https://github.com/fathomssen/redtimer/archive/v${PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
fi


LICENSE="LGPL-3.0"
SLOT="0"
IUSE="-cli"

DEPEND="
	dev-qt/qtcore
	dev-qt/qtdeclarative
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtwidgets
	dev-qt/qtx11extras
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	eqmake5
}

src_compile() {
	emake
}

src_install() {
	dobin "gui/${PN}"
	if use cli ; then
		dobin "cli/${PN}cli"
	fi
	newicon "${S}/gui/icons/clock_red.svg" "${PN}.svg"
	make_desktop_entry "${PN}" RedTimer "${PN}"
	einstalldocs
}

