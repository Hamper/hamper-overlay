# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MY_PN=${PN/-bin/}

inherit desktop xdg

DESCRIPTION="API platform for building and using APIs"
HOMEPAGE="https://www.postman.com/"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="postman"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT="strip mirror"

S="${WORKDIR}/Postman/app"

src_install() {
	insinto /opt/${MY_PN}
	doins -r *

	exeinto /opt/${MY_PN}
	doexe Postman
	doexe postman
	doexe chrome_crashpad_handler
	doexe chrome-sandbox

	dosym /opt/${MY_PN}/Postman /usr/bin/${MY_PN}

	newicon resources/app/assets/icon.png postman.png

	make_desktop_entry "postman %U" \
		"Postman" \
		"postman" \
		"Development;Utility;" \
		"StartupWMClass=postman\nMimeType=x-scheme-handler/postman"
}
