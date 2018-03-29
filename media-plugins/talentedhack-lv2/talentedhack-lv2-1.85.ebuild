# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit toolchain-funcs git-r3

DESCRIPTION="LV2 port of Autotalent pitch correction plugin"
HOMEPAGE="https://github.com/jeremysalwen/TalentedHack"
EGIT_REPO_URI="https://github.com/jeremysalwen/TalentedHack.git"
EGIT_COMMIT="c3c9dac85ed2e7b6c924796d17170ee8c2d0c83e"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	virtual/pkgconfig"

S="${WORKDIR}/talentedhack-lv2-${PV}"

src_prepare() {
	sed -e 's:-O3 -fomit-frame-pointer -fstrength-reduce -funroll-loops::g' \
		-i Makefile || die
	default
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	IDIR="${D}/usr/$(get_libdir)/lv2/talentedhack.lv2"
	install -d "${IDIR}"
	install -m644 -D "manifest.ttl" "${IDIR}" || die
	install -m644 -D "talentedhack.ttl" "${IDIR}" || die
	install -m755 -D "talentedhack.so" "${IDIR}" || die
}
