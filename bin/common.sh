#!/bin/sh

# Written by Martin Spott
#
# Copyright (C) 2004 - 2006  Martin Spott
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
TARGET=${1}
SRCDIR=${BASEDIR}/../source; export SRCDIR
BUILDBASE=/usr/local/src
BUILDDIR=${BUILDBASE}/getstart; export BUILDDIR
mkdir -p ${BUILDBASE} && cd ${BUILDBASE} || exit 1
# BE CAREFUL WITH THIS ONE !!!
rm -rf ${BUILDDIR} && cp -pr ${SRCDIR} ${BUILDDIR}
cd ${BUILDDIR} || exit 1
#
HTLATEX=htlatex
PDFLATEX=pdflatex

# Cleanup everything that is considered not to be present here.
cleanup () {
  rm -f *.pdf *.jpg *.html *.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg \
  *.in *.ind *.lg *.css *.log *.out *.tid *.tmp *.toc *.xref *.png
}

buildpdf() {
  CYCLE=1
  while [ ${CYCLE} -ne 2 ]; do
    ${PDFLATEX} ${SOURCE}\.tex
    CYCLE=`expr ${CYCLE} + 1`
  done
  if  [ ${SOURCE} = "getstart" ]; then
    makeindex ${SOURCE}
    ${PDFLATEX} ${SOURCE}\.tex
  fi
}
buildhtml() {
  CYCLE=1
  while [ ${CYCLE} -ne 2 ]; do
    ${HTLATEX} ${SOURCE} "html,2,info,next,sections+"
    CYCLE=`expr ${CYCLE} + 1`
  done
  if  [ ${SOURCE} = "getstart" ]; then
#    makeindex ${SOURCE} -o getstart.out getstart.in
    makeindex ${SOURCE}
    ${HTLATEX} ${SOURCE} "html,2,info,next,sections+"
  fi
}
