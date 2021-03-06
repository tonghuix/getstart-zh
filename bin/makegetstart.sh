#!/bin/sh
#
# Shell script for building FlightGear getting Started manual.
# Supposes a working TeX system including LaTeX and pdflatex
# plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)

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

export BASEDIR=`dirname $0`
export TARGET=`pwd`
. ${BASEDIR}/Common.sh

LANG=${1}

case ${LANG} in
  en)
	echo "Building English manual."
	SOURCE=getstart-en
  ;;

  fr)
	echo "Building French manual."
	SOURCE=getstart-fr
  ;;

  de)
	echo "Building German manual."
	SOURCE=getstart-de
  ;;

  it)
	echo "Building Italian manual."
	SOURCE=getstart-it
  ;;


  zh)
	echo "Building Chinese manual."
	SOURCE=getstart-zh
  ;;

  *)
	echo "Usage: makegetstart.sh [en|fr|de|it|zh] [pdf|html]"
        exit;
  ;;
esac

mkbuilddir

case ${2} in
  pdf)
	cleanup
	scaleimages
	cd img && scaleimages; cd ../
	buildpdf # && mv -vf ${SOURCE}.pdf ${HOME}/
  ;;

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.

  html)
	cleanup
	epsfix
	buildhtml && tar cvfzp getstarthtml-${LANG}.tgz *.html *.css *.png
  ;;
  *)
	echo "Call build of pdf or html."
  ;;
esac

# EOF
