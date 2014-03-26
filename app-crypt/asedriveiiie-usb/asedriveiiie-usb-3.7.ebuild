# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asedriveiiie-usb/asedriveiiie-usb-3.5.ebuild,v 1.3 2012/05/03 18:16:40 jdhore Exp $

EAPI=5

inherit eutils

DESCRIPTION="ASEDriveIIIe USB Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/docs/reader-drivers/asedriveiiie-usb-3-7-tar.bz2 -> ${P}.tbz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	=virtual/libusb-0*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/fix-make-${PV}.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	
	dodoc ChangeLog README
	insinto /etc/udev/rules.d/
	newins 50-pcscd-asedriveiiie.rules 50-pcscd-asedriveiiie.rules || die
}

pkg_postinst() {
	elog "NOTICE:"
	elog "You should restart pcscd."
}