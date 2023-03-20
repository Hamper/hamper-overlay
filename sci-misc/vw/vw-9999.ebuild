# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Vowpal Wabbit is a machine learning system which pushes the frontier of machine learning with techniques such as online, hashing, allreduce, reductions, learning2search, active, and interactive learning."
HOMEPAGE="http://hunch.net/~vw/"
EGIT_REPO_URI="https://github.com/JohnLangford/vowpal_wabbit.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE:STRING="Release" \
		-DFMT_SYS_DEP:BOOL="ON" \
		-DRAPIDJSON_SYS_DEP:BOOL="ON" \
		-DSPDLOG_SYS_DEP:BOOL="ON" \
		-DVW_BOOST_MATH_SYS_DEP:BOOL="ON" \
		#-DVW_GTEST_SYS_DEP:BOOL="ON" \
		-DVW_ZLIB_SYS_DEP:BOOL="ON" \
		-DBUILD_TESTING:BOOL="OFF"
		-DVW_INSTALL=ON
	)
	cmake_src_configure
}
