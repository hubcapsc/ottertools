#!/bin/sh
#
# This script automates the process of turning a human generated
# project skeleton into something you can "configure;make;make install"...
# 
# Here is an example project skeleton:
#
#./prepare.sh
#./Makefile.am
#./configure.additional
#./README
#./src
#./src/Makefile.am
#./src/app
#./src/app/Makefile.am
#./src/app/app.c
#./src/app/app.h
#./src/libapi
#./src/libapi/Makefile.am
#./src/convenienceLib1
#./src/convenienceLib1/Makefile.am
#./src/convenienceLib1/cl1.c
#./src/convenienceLib1/cl1.h
#./src/convenienceLib2
#./src/convenienceLib2/Makefile.am
#./src/convenienceLib2/cl2.c
#./src/convenienceLib2/cl2.h
#./src/convenienceLib3
#./src/convenienceLib3/Makefile.am
#./src/convenienceLib3/cl3.c
#./src/convenienceLib3/cl3.h
#
# Autotools thinks you should have NEWS, README, AUTHORS and ChangeLog
# files. We'll touch them into existance if you haven't created them
# yet.
#
# Only developers will ever see or use this script, when the developer
# thinks the project is worth sharing, "Make dist" will produce a
# blob.tar.gz to test and distribute.
#
# It is intended that you should be able to rerun this script
# whenever you change or add to the human generated files in the
# project, and configure will be good to go again.
# 
rm -f ltmain.sh
touch configure.ac
autoscan
cp configure.scan configure.ac
sed -i 's/^AC_INIT.*$/AC_INIT([ottertools],[0.1.0],[hubcap@clemson.edu])/' configure.ac
sed -i '/^AC_OUTPUT$/d' configure.ac
cat configure.additional >> configure.ac
echo AC_OUTPUT >> configure.ac
libtoolize
aclocal
autoheader
touch NEWS README AUTHORS ChangeLog
automake -ac
autoconf
