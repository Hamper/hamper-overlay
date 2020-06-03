# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

DESCRIPTION="Official desktop client for Telegram (binary package)"
HOMEPAGE="https://desktop.telegram.org"
MY_PV="${PV/_beta/}"
SRC_URI="
	https://github.com/telegramdesktop/tdesktop/archive/v${MY_PV}.tar.gz -> tdesktop-${MY_PV}.tar.gz
	amd64? ( https://github.com/telegramdesktop/tdesktop/releases/download/v${MY_PV}/tsetup.${MY_PV}.beta.tar.xz )
	x86? ( https://github.com/telegramdesktop/tdesktop/releases/download/v${MY_PV}/tsetup32.${MY_PV}.beta.tar.xz )
"

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

QA_PREBUILT="usr/lib/telegram-desktop-bin/Telegram"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=media-libs/fontconfig-2.13
	>=sys-apps/dbus-1.4.20
	x11-libs/libX11
	>=x11-libs/libxcb-1.10[xkb]
"

RESTRICT="mirror"

S="${WORKDIR}/Telegram"

src_install() {
	exeinto /usr/lib/telegram-desktop-bin
	doexe "Telegram"
	newbin "${FILESDIR}/telegram-desktop-bin" "telegram-desktop"

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${WORKDIR}/tdesktop-${MY_PV}/Telegram/Resources/art/icon${icon_size}.png" \
			telegram.png
	done

	domenu "${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/telegramdesktop.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "spell checker support" app-text/enchant
}
