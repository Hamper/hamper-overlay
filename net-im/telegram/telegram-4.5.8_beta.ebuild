# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Official desktop client for Telegram (binary package)"
HOMEPAGE="https://desktop.telegram.org"
MY_PV="${PV/_beta/}"
SRC_URI="
	https://github.com/telegramdesktop/tdesktop/archive/v${MY_PV}.tar.gz -> tdesktop-${MY_PV}.tar.gz
	amd64? ( https://github.com/telegramdesktop/tdesktop/releases/download/v${MY_PV}/tsetup.${MY_PV}.beta.tar.xz )
"

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="usr/bin/telegram-desktop"

RDEPEND="
	!net-im/telegram-desktop
	!net-im/telegram-desktop-bin
	sys-libs/glibc
	dev-libs/glib:2
	>=media-libs/fontconfig-2.13
	media-libs/freetype:2
	virtual/opengl
	x11-libs/libX11
	>=x11-libs/libxcb-1.10
"

RESTRICT="mirror"

S="${WORKDIR}/Telegram"

src_prepare() {
	default
	sed -i -e 's/@CMAKE_INSTALL_FULL_BINDIR@\///g' "${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.desktop || die
}

src_install() {
	newbin Telegram telegram-desktop

	insinto /etc/tdesktop
	newins - externalupdater <<<"${EPREFIX}/usr/bin/telegram-desktop"

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${WORKDIR}/tdesktop-${MY_PV}/Telegram/Resources/art/icon${icon_size}.png" \
			telegram.png
	done

	domenu "${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "spell checker support" app-text/enchant
}
