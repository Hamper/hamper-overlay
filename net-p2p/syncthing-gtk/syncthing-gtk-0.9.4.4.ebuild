EAPI=6
PYTHON_COMPAT=( python2_7 )
inherit eutils distutils-r1

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/syncthing/syncthing-gtk/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
    KEYWORDS="amd64 x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/syncthing/syncthing-gtk.git"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="inotify libnotify nautilus caja"
RESTRICT="mirror"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
		${DEPEND}
		dev-python/bcrypt[${PYTHON_USEDEP}]
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		dev-python/python-dateutil[$(python_gen_usedep 'python2*')]
		dev-python/python-dateutil
		sys-process/psmisc
		gnome-base/librsvg[introspection]
		x11-libs/gtk+:3
		>=net-p2p/syncthing-0.13
		inotify? ( dev-python/pyinotify[${PYTHON_USEDEP}] )
		libnotify? ( x11-libs/libnotify )
		nautilus? ( dev-python/nautilus-python[${PYTHON_USEDEP}] )
		caja? ( dev-python/python-caja[${PYTHON_USEDEP}] )"

DOCS=( README.md LICENSE )

