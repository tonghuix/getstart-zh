#!/bin/sh

# Written by Michael Basler, Martin Spott
#
# Copyright (C) 2000 - 2003  Michael Basler
# Copyright (C) 2003 - 2006  Martin Spott
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/Common.sh
SOURCE=FGShortRef

mkbuilddir

cleanup

case ${1} in
  pdf)
	cleanup
	buildpdf
	mv -vf FGShortRef.pdf ~/
  ;;

  html)
	cleanup
	buildhtml
	tar cvfzp ~/FGShortRef.tgz *.html *.css
  ;;
  *)
	echo "Call build of pdf or html."
  ;;
esac

# EOF
