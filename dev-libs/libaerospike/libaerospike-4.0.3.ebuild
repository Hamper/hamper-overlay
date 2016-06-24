# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/aerospike/aerospike-client-c.git"

if [[ ${PV} != *9999* ]]; then
        EGIT_COMMIT="${PV}"
        KEYWORDS="~amd64 ~x86"
else
        KEYWORDS="**"
fi

inherit autotools git-r3

DESCRIPTION="Aerospike C Client"
HOMEPAGE="https://github.com/aerospike/aerospike-client-c"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="luajit +static-libs"

# tests fails to build ?
RESTRICT="test"

RDEPEND=">=dev-lang/lua-5.1.5:*
	>=dev-libs/openssl-1.0.1g:=
	dev-vcs/git
	luajit? ( >=dev-lang/luajit-2.0.3:* )"
DEPEND="${RDEPEND}"

src_prepare() {
	git submodule update --init

	# main, applies to all modules
	sed -e "s/CC = cc/CC = $(tc-getCC)/g" \
		-e "s/LD = cc/CC = $(tc-getCC)/g" \
		-i project/settings.mk || die

	# include dir
	#sed -e 's@/usr/local@/usr@g' -i Makefile -i modules/lua/Makefile -i modules/mod-lua/Makefile -i modules/luajit/src/Makefile -i modules/luajit/Makefile || die
	find -type f | xargs -I{} sed -e 's@/usr/local@/usr@g' -i {}
}

src_compile() {
	use luajit && export USE_LUAJIT = 1
	# forced MAKEOPTS, see:
	# https://github.com/aerospike/aerospike-client-c/issues/22
	CC=$(tc-getCC) LD=$(tc-getCC) MAKEOPTS="-j1" PREFIX=/usr emake all
}

src_install() {
	dolib target/Linux-x86_64/lib/libaerospike.so
	use static-libs && dolib.a target/Linux-x86_64/lib/libaerospike.a

	insinto /usr/include/
	doins -r target/Linux-x86_64/include/{aerospike,citrusleaf}

	insinto /opt/aerospike/client/sys/udf/lua/
	doins modules/lua-core/src/{aerospike,as,stream_ops}.lua
}
