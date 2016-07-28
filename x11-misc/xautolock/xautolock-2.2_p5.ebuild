# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit toolchain-funcs

DESCRIPTION="An automatic X screen-locker/screen-saver"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/screensavers/"
SRC_URI="
	${HOMEPAGE}/${P/_p*/}.tgz
	mirror://debian/pool/main/x/${PN}/${PN}_${PV/_p*/}-${PV/*_p/}.debian.tar.xz
"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"

RDEPEND="
	|| (
		x11-misc/alock
		x11-misc/i3lock
		x11-misc/slim
		x11-misc/slock
		x11-misc/xlockmore
		x11-misc/xtrlock
	)
	x11-libs/libXScrnSaver
"
DEPEND="
	${RDEPEND}
	app-text/rman
	x11-misc/imake
	x11-proto/scrnsaverproto
"

S=${WORKDIR}/${P/_p*}

PATCHES=(
	"${WORKDIR}"/debian/patches/10-fix-memory-corruption.patch
	"${WORKDIR}"/debian/patches/11-fix-no-dpms.patch
	"${WORKDIR}"/debian/patches/12-fix-manpage.patch
	"${WORKDIR}"/debian/patches/13-fix-hppa-build.patch
)

src_configure() {
	xmkmf || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}"
}

src_install () {
	dobin xautolock
	newman xautolock.man xautolock.1
	dodoc Changelog Readme Todo
}
