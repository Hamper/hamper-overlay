# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Vowpal Wabbit is a machine learning system which pushes the frontier of machine learning with techniques such as online, hashing, allreduce, reductions, learning2search, active, and interactive learning."
HOMEPAGE="http://hunch.net/~vw/"
EGIT_REPO_URI="git://github.com/JohnLangford/vowpal_wabbit.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	#./autogen.sh || die "autogen failed"
	eautoreconf
	eapply_user
}

src_configure() {
	./configure --prefix=/usr || die "configure failed"
}

src_compile() {
	emake INCLUDES="${INCLUDES} -I../rapidjson/include"
}
