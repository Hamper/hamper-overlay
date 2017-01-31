# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Printer Driver  ESC/P Driver"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="
        amd64?  ( http://a1227.g.akamai.net/f/1227/40484/7d/download.ebz.epson.net/dsc/f/01/00/01/87/87/b90c68a7844fff22a3f4b4c273fcf3407699f89c/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_amd64.deb )
        x86?    ( http://a1227.g.akamai.net/f/1227/40484/7d/download.ebz.epson.net/dsc/f/01/00/01/87/87/126d18060d9881eaed0ff545ad711bd4e642b62a/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_i386.deb )"

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
