SUBDIRS = ../convenienceLib1 \
          ../convenienceLib2
if BUILD_CONVENIENCE_LIB_3
  SUBDIRS += ../convenienceLib3
endif
lib_LTLIBRARIES = libapi.la
libapi_la_SOURCES =
libapi_la_LIBADD = \
  ../convenienceLib1/libconveniencelib1.la \
  ../convenienceLib2/libconveniencelib2.la
if BUILD_CONVENIENCE_LIB_3
  libapi_la_LIBADD += ../convenienceLib3/libconveniencelib3.la
endif
