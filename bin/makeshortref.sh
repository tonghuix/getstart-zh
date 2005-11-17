#!/bin/sh
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/common.sh

SOURCE=FGShortRef

cleanup
buildpdf
rm FGShortRef.dvi
#${HTLATEX} FGShortRef %1 %2 %3 %4
