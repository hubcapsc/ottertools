# libtoolize suggested that I add '-I m4' to ACLOCAL_AMFLAGS
ACLOCAL_AMFLAGS = -I m4
# SUBDIRS indicates where to look for stuff to build and controls 
# component build order.
SUBDIRS = ./src/convenienceLib1 \
          ./src/convenienceLib2 \
          ./src

# Something we did during configure controls whether or not
# convenience library 3 gets built or not.
if BUILD_CONVENIENCE_LIB_3
  SUBDIRS += ./src/convenienceLib3
endif

SUBDIRS += ./src/libapi \
           ./src/app
