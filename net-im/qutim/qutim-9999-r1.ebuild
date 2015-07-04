# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3
LANGS="ar be bg cs cv de en_GB es fr he kk nds ru sk uk uz zh_CN"

DESCRIPTION="Qt4-based multi-protocol instant messenger"
HOMEPAGE="http://www.qutim.org"
EGIT_REPO_URI="git://github.com/euroelessar/qutim.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="**"
IUSE="clang debug sdl +vkontakte -indicator"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
QSETTINGS=""
use vkontakte || QSETTINGS="${QSETTINGS} vkontakteplugin.condition:false"
use indicator || QSETTINGS="${QSETTINGS} indicator.condition:false"
use sdl || QSETTINGS="${QSETTINGS} sdlsound.condition:false"

CDEPEND="
	>=dev-qt/qtcore-5.5
	>=dev-qt/qtnetwork-5.5
	>=dev-qt/qtx11extras-5.5
	>=dev-qt/qtwidgets-5.5
	>=dev-qt/qtscript-5.5
	>=dev-qt/qtquick1-5.5
	>=dev-qt/qtxmlpatterns-5.5
	>=dev-qt/qtwebsockets-5.5
	>=dev-qt/qtwebchannel-5.5
	>=dev-qt/qtconcurrent-5.5
	>=dev-qt/qtmultimedia-5.5
	sdl? ( media-libs/sdl-mixer )
	indicator? ( dev-libs/libindicate-qt )
	app-crypt/qca
	virtual/gsasl
	dev-libs/qtkeychain[qt5]
"
DEPEND="
	${CDEPEND}
	dev-util/qbs
	clang? ( >=sys-devel/clang-3.5.0 )
"
RDEPEND="${CDEPEND}"

use debug && RESTRICT=strip

src_prepare() {
	# remove unwanted translations
	local lang
	for lang in ${LANGS}; do
		use linguas_${lang} || rm -f translations/modules/*/${lang}.{po,ts}
	done
	# fix clang compilation
	use clang && epatch "${FILESDIR}/${PN}-clang.patch"
}

src_configure() {
	use clang && TC=clang || TC=gcc
	qbs-setup-toolchains --settings-dir $T /usr/bin/$TC tc
	qbs-setup-qt --settings-dir $T /usr/lib/qt5/bin/qmake qt
	qbs-config --settings-dir $T profiles.qt.baseProfile tc
	qbs-config --settings-dir $T defaultProfile qt
}

src_compile() {
	qbs build --settings-dir $T $QSETTINGS || die
}

src_install() {
	qbs install --settings-dir $T --install-root $D $QSETTINGS || die
}
