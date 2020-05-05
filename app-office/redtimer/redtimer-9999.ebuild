# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

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
IUSE=""

DEPEND="
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
        eqmake5
}

src_install() {
        emake INSTALL_ROOT="${D}" install
        einstalldocs
}

