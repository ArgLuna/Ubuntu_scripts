#!/bin/sh
# This script simplify the process of compiling.
# 2017.09.08
# Only suit to Ubuntu 14.04.
# Add comments.
# Add make prepare.

clear
mv ../*image*.deb ../deb/image/
mv ../*headers*.deb ../deb/headers/
make-kpkg clean
# check before compile
# If following error occures
# SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
# Tune “High Memory Support” lower.
make prepare
# start compile
make-kpkg -j4 --initrd kernel_image kernel_headers && echo compilation complete!
