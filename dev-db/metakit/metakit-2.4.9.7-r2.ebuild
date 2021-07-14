# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs
DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="https://github.com/RobbieAB/metakit/releases/download/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE="static tcl"

DEPEND="
	tcl? ( >=dev-lang/tcl-8.6:0= )"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-linking.patch \
		"${FILESDIR}"/${P}-tcltk86.patch
}

src_configure() {
	local myconf mycxxflags
	use tcl && myconf+=" --with-tcl=${EPREFIX}/usr/include,${EPREFIX}/usr/$(get_libdir)"
	use static && myconf+=" --disable-shared"
	use static || append-cxxflags -fPIC

	CXXFLAGS="${CXXFLAGS} ${mycxxflags}" unix/configure \
		${myconf} \
		--host=${CHOST} \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--infodir="${EPREFIX}/usr/share/info" \
		--mandir="${EPREFIX}/usr/share/man"
}

src_compile() {
	emake SHLIB_LD="$(tc-getCXX) -shared -Wl,-soname,libmk4.so.2.4"
}

src_install() {
	default

	mv "${ED}"//usr/$(get_libdir)/libmk4.so{,.2.4}
	dosym libmk4.so.2.4 /usr/$(get_libdir)/libmk4.so.2
	dosym libmk4.so.2.4 /usr/$(get_libdir)/libmk4.so

	dohtml Metakit.html
	dohtml -a html,gif,png,jpg -r doc/*
}
