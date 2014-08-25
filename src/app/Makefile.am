#
AM_CPPFLAGS = -I $(top_builddir)/src
#
if BUILD_CONVENIENCE_LIB_3
  AM_CPPFLAGS += -D__CL3
endif
#
# Instead of building the executable in the same directory
# as Makefile.am, send it off to a build directory.
#
bin_PROGRAMS = $(top_builddir)/build/substitution/app 
__top_builddir__build_substitution_app_SOURCES = \
  app.c \
  app.h
#
LDADD = \
  ../libapi/libapi.la
