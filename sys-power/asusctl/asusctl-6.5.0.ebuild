# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Daemon and tools to control your ASUS ROG laptop. Supersedes rog-core."
HOMEPAGE="https://asus-linux.org/"

EGIT_REPO_URI="https://github.com/OpenGamingCollective/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="network-sandbox"
IUSE=""

DEPEND="
	dev-libs/libayatana-appindicator
	sys-auth/seatd
	>=dev-lang/rust-1.90
"
RDEPEND="${DEPEND}"
BDEPEND=""

