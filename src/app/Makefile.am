AM_CPPFLAGS = -I ..
#
if BUILD_CONVENIENCE_LIB_3
  AM_CPPFLAGS += -D__CL3
endif
#
bin_PROGRAMS = app 
app_SOURCES = app.c \
              app.h
#
LDADD = \
    ../libapi/libapi.la
