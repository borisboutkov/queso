# SYNOPSIS
#
#   Test for HPCT 
#
#   AM_PATH_HPCT([, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]]])
#
# DESCRIPTION
#
#   Provides a --with-hpct=DIR option. Searches --with-hpct,
#   $HPCT_DIR, and the usual places for HPCT headers and libraries.
#
#   On success, sets HPCT_CFLAGS, HPCT_LIBS, and
#   #defines HAVE_HPCT.  When ACTION-IF-NOT-FOUND is not specified,
#   the default behavior is for configure to fail.
#
# LAST MODIFICATION
#
#   2009-07-14
#
# COPYLEFT
#
#   Copyright (c) 2009 Rhys Ulerich <rhys.ulerich@gmail.com>
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2008 Caolan McNamara <caolan@skynet.ie>
#   Copyright (c) 2008 Alexandre Duret-Lutz <adl@gnu.org>
#   Copyright (c) 2008 Matthew Mueller <donut@azstarnet.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_PATH_HPCT],
[


AC_ARG_VAR(HPCT_DIR,[root directory of HPCT installation])
HPCT_PREFIX=${HPCT_DIR}

AC_ARG_WITH(hpct, [AS_HELP_STRING([--with-hpct[=DIR]],[root directory of HPCT installation (default = HPCT_DIR)])],
		  [HPCT_PREFIX="$withval"],[])

echo hpct_PREFIX = $HPCT_PREFIX

# HPCT is required - test for availability.

#if test "${with_hpct}" != no ; then

    if test -d "${HPCT_PREFIX}/lib" ; then
       HPCT_LIBS="-L${HPCT_PREFIX}/lib -lhpct"
    fi

    if test -d "${HPCT_PREFIX}/include" ; then
        HPCT_CFLAGS="-I${HPCT_PREFIX}/include"
    fi

    ac_HPCT_save_CFLAGS="$CFLAGS"
    ac_HPCT_save_CPPFLAGS="$CPPFLAGS"
    ac_HPCT_save_LDFLAGS="$LDFLAGS"
    ac_HPCT_save_LIBS="$LIBS"

    CFLAGS="${HPCT_CFLAGS} ${CFLAGS}"
    CPPFLAGS="${HPCT_CFLAGS} ${CPPFLAGS}"
    LDFLAGS="${HPCT_LIBS} ${LDFLAGS}"
    AC_LANG_PUSH([C])
    AC_CHECK_HEADER([hpct.h],[found_header=yes],[found_header=no])
    AC_CHECK_LIB([hpct],hpct_input_fopen,[found_library=yes],[found_library=no])
    AC_LANG_POP([C])

    CFLAGS="$ac_HPCT_save_CFLAGS"
    CPPFLAGS="$ac_HPCT_save_CPPFLAGS"
    LDFLAGS="$ac_HPCT_save_LDFLAGS"
    LIBS="$ac_HPCT_save_LIBS"

    succeeded=no
    if test "$found_header" = yes; then
        if test "$found_library" = yes; then
            succeeded=yes
        fi
    fi

    if test "$succeeded" = no; then
        ifelse([$2],,AC_MSG_ERROR([HPCT not found.  Try either --with-hpct or setting HPCT_DIR.]),
            [$2])
    else
        AC_DEFINE(HAVE_HPCT,1,[Define if HPCT is available])
        AC_SUBST(HPCT_CFLAGS)
        AC_SUBST(HPCT_LIBS)
        ifelse([$1],,,[$1])
    fi

#fi

])