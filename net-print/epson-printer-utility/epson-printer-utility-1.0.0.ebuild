# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Epson printer utility"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="
        amd64?  ( https://download3.ebz.epson.net/dsc/f/03/00/04/17/55/056ce199385983ae651da49a4d16a3fc63b8bef7/epson-printer-utility_1.0.0-1lsb3.2_amd64.deb )
        x86?    ( https://download3.ebz.epson.net/dsc/f/03/00/04/17/55/e950279db96fb89c9b38244aec00b7536a6809c8/epson-printer-utility_1.0.0-1lsb3.2_i386.deb )"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
        unpack ${A}
        unpack ./data.tar.gz

        # removing not necessary content
        rm control.tar.gz data.tar.gz debian-binary 
}

src_install() {
        cp -pPR * "${D}"/ || die "installing data failed"
}
