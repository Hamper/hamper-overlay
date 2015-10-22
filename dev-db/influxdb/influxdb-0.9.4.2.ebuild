# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

DESCRIPTION="Scalable datastore for metrics, events, and real-time analytics"
HOMEPAGE="http://influxdb.com"
SRC_URI="https://s3.amazonaws.com/influxdb/${PN}_${PV}_amd64.deb"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/bin/${PN}"

src_unpack() {
        mkdir -p ${WORKDIR}/${P}
        cd ${WORKDIR}/${P}
src_unpack() {
        mkdir -p ${WORKDIR}/${P}
        cd ${WORKDIR}/${P}
    unpack_deb ${A}
}

src_install() {
        cp -Rp * "${D}"
    dodir /opt/bin
    dosym ../influxdb/versions/${PV}/influx /opt/bin/influx || die
    dosym ../influxdb/versions/${PV}/influxd /opt/bin/influxd || die
}
