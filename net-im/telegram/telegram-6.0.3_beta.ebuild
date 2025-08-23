# Copyright 1999-2025 Gentoo Authors
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

S="${WORKDIR}/Telegram"

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
	x11-libs/gtk+:3[X,wayland]
	x11-libs/libX11
	>=x11-libs/libxcb-1.10
"

RESTRICT="mirror"

src_prepare() {
	default

	sed -i -e \
		's/^Exec=@CMAKE_INSTALL_FULL_BINDIR@\/Telegram/Exec=\/usr\/bin\/telegram-desktop/' \
		"${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.service || die
	sed -i -e \
		's/Exec=Telegram/Exec=\/usr\/bin\/telegram-desktop/' \
		"${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.desktop || die
}

src_install() {
	newbin Telegram telegram-desktop

	insinto /usr/share/TelegramDesktop/externalupdater.d/
	newins - externalupdater <<<"${EPREFIX}/usr/bin/telegram-desktop"

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${WORKDIR}/tdesktop-${MY_PV}/Telegram/Resources/art/icon${icon_size}.png" \
			org.telegram.desktop.png
	done

	domenu "${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.desktop
	insinto /usr/share/dbus-1/services
	doins "${WORKDIR}/tdesktop-${MY_PV}"/lib/xdg/org.telegram.desktop.service
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "spell checker support" app-text/enchant
}
