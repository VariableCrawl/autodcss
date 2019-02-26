#!/bin/bash

VERSION="AutoDCSS Version 2.2.0"

# ===Description===
# The purpose of this script is to setup the latest
# git version of DCSS on Debian/Ubuntu Linux. This
# script downloads the source, its dependencies,
# and compiles the game. It can also update or build
# from clean, as well as remove bones if desired.
# Select the <H> menu option to see all functionality.
#
# When running the game with this script, certain
# improvements to the color scheme are implemented,
# which can be commented out if not desired. These are
# sourced from twipley's thread on the Crawl forums:
# https://crawl.develz.org/tavern/viewtopic.php?f=9&t=17104
#
# Questions, comments, and suggestions are welcome here:
# https://crawl.develz.org/tavern/viewtopic.php?f=19&t=26108

read -n1 -p "<I>nstall, <U>pdate, <M>ake from clean, <C>ommits, or <P>lay Crawl? "
echo
case $REPLY in
   i | I)
   echo "Installing Dungeon Crawl..."
   read -p "If dependencies are not satisfied, run this script again and select <D>."
   git clone https://github.com/crawl/crawl.git
   cd crawl
   git submodule update --init
   cd crawl-ref/source
   make
   cd
   ;;
   d | D)
   echo "Installing dependencies for Dungeon Crawl..."
   sudo apt-get install build-essential libncursesw5-dev bison flex liblua5.1-0-dev libsqlite3-dev libz-dev xtermcontrol pkg-config python-yaml libsdl2-image-dev libsdl2-mixer-dev libsdl2-dev libfreetype6-dev libpng-dev ttf-dejavu-core
   echo "Run this script again to <I>nstall."
   ;;
   u | U)
   echo "Updating Dungeon Crawl..."
   cd crawl
   git pull
   cd crawl-ref/source
   make
   cd
   ;;
   m | M)
   echo "Making Dungeon Crawl from clean..."
   cd crawl
   git pull
   cd crawl-ref/source
   make clean
   make
   cd
   ;;
   c | C)
   cd crawl
   git log
   cd
   ;;
   v | V)
   cd crawl/crawl-ref/source
   echo $VERSION
   ./crawl -version
   cd
   ;;
   r | R)
   echo "Removing bones..."
   if [ -f crawl/crawl-ref/source/saves/bones.* ];
   then
   rm -i crawl/crawl-ref/source/saves/bones.*
   else
   echo "No bones exist."
   fi
   ;;
   h | H)
   echo "<C>ommits, <D>ependencies, <H>elp, <I>nstall game, <M>ake from clean, <P>lay, <R>emove bones, <U>pdate, <V>ersion."
   ;;
   p | P | $RETURN)
   cd crawl/crawl-ref/source
   xtermcontrol --color0=rgb:0000/0000/0000 --color1=rgb:cdcb/0000/0000 --color2=rgb:0000/cdcb/0000 --color3=rgb:cdcb/cdcb/0000 --color4=rgb:1e1a/908f/ffff --color5=rgb:cdcb/0000/cdcb --color6=rgb:0000/cdcb/cdcb --color7=rgb:e5e2/e5e2/e5e2 --color8=rgb:4ccc/4ccc/4ccc --color9=rgb:ffff/0000/0000 --color10=rgb:0000/ffff/0000 --color11=rgb:ffff/ffff/0000 --color12=rgb:4645/8281/b4ae --color13=rgb:ffff/0000/ffff --color14=rgb:0000/ffff/ffff --color15=rgb:ffff/ffff/ffff
   ./crawl
   cd
   ;;
   * )
   echo "You die..."
   ;;
esac
