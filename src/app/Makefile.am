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
bin_PROGRAMS = $(top_builddir)/build/$(PLATFORM_TYPE)/app 
__top_builddir__build___PLATFORM_TYPE__app_SOURCES = \
  app.c \
  app.h
#
LDADD = \
  ../libapi/libapi.la
