# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop optfeature xdg

DESCRIPTION="Official desktop client for Telegram (binary package)"
HOMEPAGE="https://desktop.telegram.org"
SRC_URI="
	https://github.com/telegramdesktop/tdesktop/archive/v${PV}.tar.gz -> tdesktop-${PV}.tar.gz
	amd64? ( https://github.com/telegramdesktop/tdesktop/releases/download/v${PV}/tsetup.${PV}.tar.xz )
"

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_PREBUILT="usr/lib/telegram-desktop-bin/Telegram"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=media-libs/fontconfig-2.13
	media-libs/freetype:2
	media-libs/libglvnd[X]
	>=sys-apps/dbus-1.4.2[X]
	sys-libs/zlib
	x11-libs/libSM
	x11-libs/libdrm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/libxcb-1.10[xkb]
"

S="${WORKDIR}/Telegram"

src_install() {
	exeinto /usr/lib/telegram-desktop-bin
	doexe "Telegram"
	newbin "${FILESDIR}/telegram-desktop-bin" "telegram-desktop"

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${WORKDIR}/tdesktop-${PV}/Telegram/Resources/art/icon${icon_size}.png" \
			telegram.png
	done

	domenu "${WORKDIR}/tdesktop-${PV}"/lib/xdg/telegramdesktop.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "spell checker support" app-text/enchant
}
