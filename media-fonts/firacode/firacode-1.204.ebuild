# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit font

MY_PN="FiraCode"

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
SRC_URI="https://github.com/tonsky/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~*"
IUSE=""

S="${WORKDIR}"

FONT_S="${S}/${MY_PN}-${PV}/distr/ttf/"
FONT_SUFFIX="ttf"
