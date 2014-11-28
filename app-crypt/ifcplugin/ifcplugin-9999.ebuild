# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Plugin for gosuslugi.ru auth"
HOMEPAGE="http://gosuslugi.ru"
SRC_URI="
	amd64?	( https://esia.gosuslugi.ru/sia-web/htdocs/plugin/IFCPlugin-x86_64.deb )
	x86?	( https://esia.gosuslugi.ru/sia-web/htdocs/plugin/IFCPlugin-i386.deb )"

RESTRICT="strip"
LICENSE=""
SLOT="0"
KEYWORDS="**"
IUSE=""

DEPEND="sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	cd "${S}"

	# removing not necessary content
	rm control.tar.gz data.tar.gz debian-binary 
}

src_install() {
	cp -pPR * "${D}"/ || die "installing data failed"
	#Create logs dir
	mkdir -p "${D}"/var/log/ifc
	mkdir -p "${D}"/var/log/ifc/engine_logs
	chmod 777 "${D}"/var/log/ifc
	chmod 777 "${D}"/var/log/ifc/engine_logs
	cd "${D}"/etc/update_ccid_boundle
	bash ./update_ccid_boundle.sh
}
