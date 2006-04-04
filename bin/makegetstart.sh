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
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/common.sh
SOURCE=getstart

cleanup

for FILENAME in *.eps; do
  NAMEBASE=`echo ${FILENAME} | cut -f 1 -d \.`
  RESOLUTION=`identify ${FILENAME} | awk '{print $3}'`
  XRES=`echo "${RESOLUTION}" | awk -F x '{print $1}'`
  YRES=`echo "${RESOLUTION}" | awk -F x '{print $2}'`
  # Never scale the image if the smaller edge is already below 480 dots
  if [ ${XRES} -lt 480 -o ${YRES} -lt 480 ]; then
    echo "leave image unchanged"
    RESIZE=""
  else
    # Determine the small edge of the image
    echo "change image size"
    if [ ${XRES} -lt ${YRES} ]; then
      SMALL=${XRES}
      LARGE=${YRES}
    else
      SMALL=${YRES}
      LARGE=${XRES}
    fi
    # Determine scaling factor - rough, but working as expected;
    # scale the image so that the smaller edge is in the proximity but
    # never below 480 dots
    DIVISOR=`expr ${SMALL} / 480`
    SIZE=`expr ${LARGE} / ${DIVISOR}`
    RESIZE="-resize ${SIZE}x${SIZE}"
  fi
  convert -depth 16 -normalize ${RESIZE} ${FILENAME} ${NAMEBASE}\.jpg
done

buildpdf

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
cleanup

buildhtml
# Run the packaging script _now_ !
