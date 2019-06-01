#
# Copyright (c) 2014-2016 Enrico M. Crisostomo
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
#
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake/Modules")
include(LibfswatchChecks)
include_directories(src/libfswatch ${CMAKE_CURRENT_BINARY_DIR})

add_compile_definitions(HAVE_CONFIG_H)
configure_file(libfswatch_config.h.in libfswatch_config.h)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads)

set(libfswatch_SOURCE_FILES
        src/libfswatch/c/cevent.cpp
        src/libfswatch/c/cevent.h
        src/libfswatch/c/cfilter.h
        src/libfswatch/c/cmonitor.h
        src/libfswatch/c/error.h
        src/libfswatch/c/libfswatch.cpp
        src/libfswatch/c/libfswatch.h
        src/libfswatch/c/libfswatch_log.cpp
        src/libfswatch/c/libfswatch_log.h
        src/libfswatch/c/libfswatch_types.h
        src/libfswatch/c++/event.cpp
        src/libfswatch/c++/event.hpp
        src/libfswatch/c++/filter.hpp
        src/libfswatch/c++/filter.cpp
        src/libfswatch/c++/libfswatch_exception.cpp
        src/libfswatch/c++/libfswatch_exception.hpp
        src/libfswatch/c++/libfswatch_map.hpp
        src/libfswatch/c++/libfswatch_set.hpp
        src/libfswatch/c++/monitor.cpp
        src/libfswatch/c++/monitor.hpp
        src/libfswatch/c++/monitor_factory.cpp
        src/libfswatch/c++/monitor_factory.hpp
        src/libfswatch/c++/path_utils.cpp
        src/libfswatch/c++/path_utils.hpp
        src/libfswatch/c++/poll_monitor.cpp
        src/libfswatch/c++/poll_monitor.hpp
        src/libfswatch/c++/string/string_utils.cpp
        src/libfswatch/c++/string/string_utils.hpp
        src/libfswatch/gettext.h
        src/libfswatch/gettext_defs.h
        libfswatch_config.h
        ${libfswatch_MONITOR_SOURCE_FILES})

add_library(fswatch ${libfswatch_SOURCE_FILES})
target_include_directories(fswatch PUBLIC src)

target_link_libraries(fswatch ${CORESERVICES_LIBRARY} Threads::Threads)
