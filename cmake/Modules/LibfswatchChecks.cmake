include(CheckCXXSourceCompiles)
include(CheckIncludeFiles)
include(CheckStructHasMember)

check_include_files(atomic HAVE_CXX_ATOMIC LANGUAGE CXX)
check_include_files(mutex HAVE_CXX_MUTEX LANGUAGE CXX)
check_include_files(unordered_map HAVE_UNORDERED_MAP LANGUAGE CXX)
check_include_files(unordered_set HAVE_UNORDERED_SET LANGUAGE CXX)

check_cxx_source_compiles(
    "int main() {
        using namespace std;
        static thread_local int x;
    }" HAVE_CXX_THREAD_LOCAL)

check_struct_has_member("struct stat" st_mtime sys/stat.h
        HAVE_STRUCT_STAT_ST_MTIME)
check_struct_has_member("struct stat" st_mtimespec sys/stat.h
        HAVE_STRUCT_STAT_ST_MTIMESPEC)

check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)
if (HAVE_SYS_INOTIFY_H)
    set(libfswatch_SOURCE_FILES
            ${libfswatch_SOURCE_FILES}
            src/libfswatch/c++/inotify_monitor.cpp
            src/libfswatch/c++/inotify_monitor.hpp)
endif (HAVE_SYS_INOTIFY_H)

check_include_files(sys/event.h HAVE_SYS_EVENT_H)
if (HAVE_SYS_EVENT_H)
    set(libfswatch_SOURCE_FILES
            ${libfswatch_SOURCE_FILES}
            src/libfswatch/c++/kqueue_monitor.cpp
            src/libfswatch/c++/kqueue_monitor.hpp)
endif (HAVE_SYS_EVENT_H)

check_include_files(port.h HAVE_PORT_H)
if (HAVE_PORT_H)
    set(libfswatch_SOURCE_FILES
            ${libfswatch_SOURCE_FILES}
            src/libfswatch/c++/fen_monitor.cpp
            src/libfswatch/c++/fen_monitor.hpp)
endif (HAVE_PORT_H)

if (WIN32)
    check_include_files(sys/cygwin.h HAVE_CYGWIN)

    if (HAVE_CYGWIN)
        set(libfswatch_SOURCE_FILES
                ${libfswatch_SOURCE_FILES}
                src/libfswatch/c++/windows/win_directory_change_event.cpp
                src/libfswatch/c++/windows/win_directory_change_event.hpp
                src/libfswatch/c++/windows/win_error_message.cpp
                src/libfswatch/c++/windows/win_error_message.hpp
                src/libfswatch/c++/windows/win_handle.cpp
                src/libfswatch/c++/windows/win_handle.hpp
                src/libfswatch/c++/windows/win_paths.cpp
                src/libfswatch/c++/windows/win_paths.hpp
                src/libfswatch/c++/windows/win_strings.cpp
                src/libfswatch/c++/windows/win_strings.hpp
                src/libfswatch/c++/windows_monitor.cpp
                src/libfswatch/c++/windows_monitor.hpp)
        set(HAVE_WINDOWS YES)
    endif (HAVE_CYGWIN)
endif (WIN32)

if (APPLE)
    check_include_files(CoreServices/CoreServices.h HAVE_FSEVENTS_FILE_EVENTS)

    if (HAVE_FSEVENTS_FILE_EVENTS)
        find_library(CORESERVICES_LIBRARY CoreServices)
        set(EXTRA_LIBS ${CORESERVICES_LIBRARY})

        set(libfswatch_SOURCE_FILES
                ${libfswatch_SOURCE_FILES}
                src/libfswatch/c++/fsevents_monitor.cpp
                src/libfswatch/c++/fsevents_monitor.hpp)

    endif (HAVE_FSEVENTS_FILE_EVENTS)
endif (APPLE)
