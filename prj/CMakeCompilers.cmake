# CMake build compilers script
# This file is part of NAppGUI-SDK project
# See README.txt and LICENSE.txt

#------------------------------------------------------------------------------

function(removeFlag var flag)
    if ("${${var}}" STREQUAL ${flag})
        string(REGEX REPLACE ${flag} "" var_without_flag ${${var}})
    endif()
    set(${var} ${var_without_flag} PARENT_SCOPE)
endfunction()

#------------------------------------------------------------------------------

function(addFlag var flag)
    set(var_with_flag "${${var}} ${flag}")
    set(${var} ${var_with_flag} PARENT_SCOPE)
endfunction()

#------------------------------------------------------------------------------

# Avoid error in CMake [Generate]
set(CMAKE_SHARED_LINKER_FLAGS_RELEASEWITHASSERT ${CMAKE_SHARED_LINKER_FLAGS_RELEASE})

#------------------------------------------------------------------------------

# Compiler Settings for all targets in the solution
# Windows configuration (only for Microsoft VC Compiler)
#------------------------------------------------------------------------------
if (WIN32)

    set(NAPPGUI_STATIC_LIB_PREFIX "")
    set(NAPPGUI_STATIC_LIB_SUFFIX ".lib")
    set(NAPPGUI_DYNAMIC_LIB_PREFIX "")
    set(NAPPGUI_DYNAMIC_LIB_SUFFIX ".dll")
    unset(CMAKE_INSTALL_PREFIX CACHE)

    if (${CMAKE_SIZEOF_VOID_P} STREQUAL 4)
        set(NAPPGUI_HOST "x86")
        set(NAPPGUI_ARCH "x86")
    elseif (${CMAKE_SIZEOF_VOID_P} STREQUAL 8)
        set(NAPPGUI_HOST "x64")
        set(NAPPGUI_ARCH "x64")
    else ()
        message (FATAL_ERROR "Unknown processor architecture")
    endif()

    if (MSVC)

        checkVisualStudioVersion()
        message(STATUS "- Platform Toolset: ${CMAKE_VS_PLATFORM_TOOLSET}/${NAPPGUI_ARCH}")

        # Warnings
        setVisualStudioWarnings()

        # Disable C++ Exceptions
        removeFlag(CMAKE_CXX_FLAGS "/EHsc")

        # Standard C Library Static or Dynamic
        #set(NAPPGUI_RUNTIME_LIBRARY static CACHE STRING "C Standard library static or dynamic linking.")
        #set_property(CACHE NAPPGUI_RUNTIME_LIBRARY PROPERTY STRINGS "static;dynamic")
        set(NAPPGUI_RUNTIME_LIBRARY "static")
        removeFlag(CMAKE_CXX_FLAGS_RELEASEWITHASSERT "/MD")
        removeFlag(CMAKE_CXX_FLAGS_RELEASE "/MD")
        removeFlag(CMAKE_CXX_FLAGS_DEBUG "/MDd")
        removeFlag(CMAKE_C_FLAGS_RELEASEWITHASSERT "/MD")
        removeFlag(CMAKE_C_FLAGS_RELEASE "/MD")
        removeFlag(CMAKE_C_FLAGS_DEBUG "/MDd")
        if (${NAPPGUI_RUNTIME_LIBRARY} STREQUAL "static")
            addFlag(CMAKE_CXX_FLAGS_RELEASEWITHASSERT "/MT")
            addFlag(CMAKE_CXX_FLAGS_RELEASE "/MT")
            addFlag(CMAKE_CXX_FLAGS_DEBUG "/MTd")
            addFlag(CMAKE_C_FLAGS_RELEASEWITHASSERT "/MT")
            addFlag(CMAKE_C_FLAGS_RELEASE "/MT")
            addFlag(CMAKE_C_FLAGS_DEBUG "/MTd")
        elseif (${NAPPGUI_RUNTIME_LIBRARY} STREQUAL "dynamic")
            addFlag(CMAKE_CXX_FLAGS_RELEASEWITHASSERT "/MD")
            addFlag(CMAKE_CXX_FLAGS_RELEASE "/MD")
            addFlag(CMAKE_CXX_FLAGS_DEBUG "/MDd")
            addFlag(CMAKE_C_FLAGS_RELEASEWITHASSERT "/MD")
            addFlag(CMAKE_C_FLAGS_RELEASE "/MD")
            addFlag(CMAKE_C_FLAGS_DEBUG "/MDd")
        else()
            message(FATAL_ERROR "Unknown NAPPGUI_RUNTIME_LIBRARY property")
        endif()

        # Visual Studio properties
        string(REPLACE ";" " " AdditionalDefinitions "${AdditionalDefinitions}")
        string(REGEX REPLACE "/W[1-3]" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /fp:fast ${AdditionalDefinitions}")
        string(REGEX REPLACE "/W[1-3]" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /fp:fast ${AdditionalDefinitions}")
        add_definitions(-DUNICODE -D_UNICODE /nologo)

        # Package tool
        # set(CMAKE_PACKAGE FALSE CACHE BOOL "Pack executables On/Off")
        # set(CMAKE_PACKAGE_PATH "" CACHE PATH "Path to generated packages")
        # set(CMAKE_PACKAGE_GEN "NSIS" CACHE STRING "Package generator utility")
        # set_property(CACHE CMAKE_PACKAGE_GEN PROPERTY STRINGS "NSIS;TGZ")

        # Enhaced instruction set x86 Processors
        if (${NAPPGUI_ARCH} STREQUAL "x86")
            if (${CMAKE_VS_PLATFORM_TOOLSET} STREQUAL "v80")
                # Not Set in VS2005 is /arch:IA32
            elseif (${CMAKE_VS_PLATFORM_TOOLSET} STREQUAL "v90")
                add_definitions(/arch:SSE)
            else()
                add_definitions(/arch:SSE2)
            endif()
        endif()

        set(NAPPGUI_COMPILER_TOOLSET ${CMAKE_VS_PLATFORM_TOOLSET})
    else()
        message (FATAL_ERROR "Unknown compiler")

    endif()

# Apple configuration
#------------------------------------------------------------------------------
elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")

    set(NAPPGUI_STATIC_LIB_PREFIX "lib")
    set(NAPPGUI_STATIC_LIB_SUFFIX ".a")
    set(NAPPGUI_DYNAMIC_LIB_PREFIX "lib")
    set(NAPPGUI_DYNAMIC_LIB_SUFFIX ".dylib")
    set(OSX_SYSROOT ${CMAKE_OSX_SYSROOT})
    unset(CMAKE_EXECUTABLE_FORMAT CACHE)
    unset(CMAKE_OSX_ARCHITECTURES CACHE)
    unset(CMAKE_OSX_SYSROOT CACHE)
    unset(CMAKE_OSX_DEPLOYMENT_TARGET CACHE)
    unset(CMAKE_BUILD_TYPE CACHE)
    unset(CMAKE_INSTALL_PREFIX CACHE)

    # NOT UNCOMMENT AFFECTS PROJECT CONFIG
    #unset(CMAKE_AR CACHE)
    #unset(CMAKE_CXX_FLAGS CACHE)
    #unset(CMAKE_CXX_FLAGS_DEBUG CACHE)
    #unset(CMAKE_CXX_FLAGS_MINSIZEREL CACHE)
    #unset(CMAKE_CXX_FLAGS_RELEASE CACHE)
    #unset(CMAKE_CXX_FLAGS_RELWITHDEBINFO CACHE)
    #unset(CMAKE_C_FLAGS CACHE)
    #unset(CMAKE_C_FLAGS_DEBUG CACHE)
    #unset(CMAKE_C_FLAGS_MINSIZEREL CACHE)
    #unset(CMAKE_C_FLAGS_RELEASE CACHE)
    #unset(CMAKE_C_FLAGS_RELWITHDEBINFO CACHE)
    #unset(CMAKE_EXE_LINKER_FLAGS CACHE)
    #unset(CMAKE_EXE_LINKER_FLAGS_DEBUG CACHE)
    #unset(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL CACHE)
    #unset(CMAKE_EXE_LINKER_FLAGS_RELEASE CACHE)
    #unset(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO CACHE)
    #set(CMAKE_EXE_LINKER_FLAGS "")
    #set(CMAKE_EXE_LINKER_FLAGS_DEBUG "")
    #set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "")
    #set(CMAKE_EXE_LINKER_FLAGS_RELEASE "")
    #set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "")
    #unset(CMAKE_MODULE_LINKER_FLAGS CACHE)
    #unset(CMAKE_MODULE_LINKER_FLAGS_DEBUG CACHE)
    #unset(CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL CACHE)
    #unset(CMAKE_MODULE_LINKER_FLAGS_RELEASE CACHE)
    #unset(CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO CACHE)
    #unset(CMAKE_SHARED_LINKER_FLAGS CACHE)
    #unset(CMAKE_SHARED_LINKER_FLAGS_DEBUG CACHE)
    #unset(CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL CACHE)
    #unset(CMAKE_SHARED_LINKER_FLAGS_RELEASE CACHE)
    #unset(CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO CACHE)
    #unset(CMAKE_INSTALL_NAME_TOOL CACHE)
    #unset(CMAKE_LINKER CACHE)
    #unset(CMAKE_MAKE_PROGRAM CACHE)
    #unset(CMAKE_NM CACHE)
    #unset(CMAKE_OBJCOPY CACHE)
    #unset(CMAKE_OBJDUMP CACHE)
    #unset(CMAKE_RANLIB CACHE)
    #unset(CMAKE_SKIP_INSTALL_RPATH CACHE)
    #unset(CMAKE_SKIP_RPATH CACHE)
    #unset(CMAKE_STRIP CACHE)
    #unset(CMAKE_VERBOSE_MAKEFILE CACHE)
    #unset(CMAKE_USE_RELATIVE_PATHS CACHE)

    set(CMAKE_OSX_SYSROOT ${OSX_SYSROOT})

    # Xcode version, base SDK and deployment target
    checkXcodeVersion()

    osxSDKName(${BASE_OSX_SDK} OSX_SDK_NAME)
    message(STATUS "- Xcode: ${XCODE_VERSION} SDK: ${BASE_OSX_SDK}-${OSX_SDK_NAME}")

    # Deployment target
    set(CMAKE_OSX_DEPLOYMENT_TARGET ${CMAKE_DEPLOYMENT_TARGET})
    osxSDKName(${CMAKE_OSX_DEPLOYMENT_TARGET} OSX_SDK_NAME)
    set(NAPPGUI_COMPILER_TOOLSET sdk${CMAKE_OSX_DEPLOYMENT_TARGET})
    string(REPLACE "." "_" NAPPGUI_COMPILER_TOOLSET ${NAPPGUI_COMPILER_TOOLSET})
    message(STATUS "- Deployment Target: ${CMAKE_OSX_DEPLOYMENT_TARGET}-${OSX_SDK_NAME}")

    if (CMAKE_CXX_FLAGS STREQUAL "/EHsc")
        string(REGEX REPLACE "/EHsc" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    endif()

    # Set Global Properties (for root Xcode solution)
    list(LENGTH IDE_PROPERTIES NUM_PROPS)
	math(EXPR PROP_TOTAL "${NUM_PROPS} - 1")
    foreach(PROP_INDEX RANGE 0 ${PROP_TOTAL} 2)
        math(EXPR PROP_NEXT "${PROP_INDEX} + 1")
        list(GET IDE_PROPERTIES ${PROP_INDEX} LOOP_PROPERTY)
        list(GET IDE_PROPERTIES ${PROP_NEXT} LOOP_VALUE)
        set(CMAKE_${LOOP_PROPERTY} ${LOOP_VALUE})
        #message(CMAKE_${LOOP_PROPERTY} ${LOOP_VALUE})
    endforeach()
    set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf")

    # Build architecture
    set(CMAKE_OSX_ARCHITECTURES ${CMAKE_ARCHITECTURE})
    if (${CMAKE_OSX_ARCHITECTURES} STREQUAL "i386")
        set(NAPPGUI_ARCH x86)
    elseif (${CMAKE_OSX_ARCHITECTURES} STREQUAL "x86_64")
        set(NAPPGUI_ARCH x64)
    elseif (${CMAKE_OSX_ARCHITECTURES} STREQUAL "arm64")
        set(NAPPGUI_ARCH arm)
    endif()
    message(STATUS "- Build architecture: ${CMAKE_OSX_ARCHITECTURES}")

    # Host architecture
    set(HOST_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR})

    if (${HOST_ARCH} STREQUAL "i386")
        set(NAPPGUI_HOST x86)
    elseif (${HOST_ARCH} STREQUAL "x86_64")
        set(NAPPGUI_HOST x64)
    elseif (${HOST_ARCH} STREQUAL "arm64")
        set(NAPPGUI_HOST arm64)
    else()
        message("- Unknown host architecture")
    endif()
    message(STATUS "- Host architecture: ${HOST_ARCH}")

    # Package tool
	# set(CMAKE_PACKAGE FALSE CACHE BOOL "Pack executables On/Off")
    # set(CMAKE_PACKAGE_PATH "" CACHE PATH "Path to generated packages")
    # set(CMAKE_PACKAGE_GEN "DragNDrop" CACHE STRING "Package generator utility")
    # set_property(CACHE CMAKE_PACKAGE_GEN PROPERTY STRINGS "DragNDrop;TGZ")

    # Libraries
    set(COCOA_LIB ${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/Cocoa.framework)
    string(COMPARE GREATER_EQUAL ${CMAKE_OSX_DEPLOYMENT_TARGET} "12.0" USE_UTTYPE)
    if (USE_UTTYPE)
        set(COCOA_LIB ${COCOA_LIB};${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/UniformTypeIdentifiers.framework)
    endif()

    # NRC executable permissions
    set(NRC_FILE ${CMAKE_PRJ_PATH}/script/osx/${NAPPGUI_HOST}/nrc)
    file(TO_NATIVE_PATH \"${NRC_FILE}\" NRC_FILE)
    execute_process(COMMAND "chmod" "+x" "${NRC_FILE}")

# Linux configuration
#------------------------------------------------------------------------------
elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")

    set(NAPPGUI_STATIC_LIB_PREFIX "lib")
    set(NAPPGUI_STATIC_LIB_SUFFIX ".a")
    set(NAPPGUI_DYNAMIC_LIB_PREFIX "lib")
    set(NAPPGUI_DYNAMIC_LIB_SUFFIX ".so")

    find_program(LSB_RELEASE lsb_release)
    execute_process(COMMAND ${LSB_RELEASE} -is OUTPUT_VARIABLE LSB_RELEASE_ID_SHORT OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(COMMAND ${LSB_RELEASE} -rs OUTPUT_VARIABLE LSB_RELEASE_VERSION_SHORT OUTPUT_STRIP_TRAILING_WHITESPACE)

    unset(LSB_RELEASE CACHE)
    unset(CMAKE_BUILD_TYPE CACHE)
    unset(CMAKE_ECLIPSE_EXECUTABLE CACHE)
    unset(CMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES CACHE)
    unset(CMAKE_ECLIPSE_MAKE_ARGUMENTS CACHE)
    unset(CMAKE_ECLIPSE_VERSION CACHE)
    unset(CMAKE_INSTALL_PREFIX CACHE)
    set(CMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES FALSE)

    # GCC Version
    checkGCCVersion()
    message(STATUS "- Linux Platform: ${LSB_RELEASE_ID_SHORT} ${LSB_RELEASE_VERSION_SHORT}")
    message(STATUS "- GCC compiler: ${CMAKE_CXX_COMPILER_VERSION}")

    # Warnings
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -pedantic -fPIE -Wno-long-long -Wno-overlength-strings -Wno-comment")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -fPIE")

    if(${CMAKE_VERSION} VERSION_LESS "3.1.0" OR ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS "5.0.0")
    	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu90")
    endif()

    # Host architecture
    set(HOST_ARCH ${CMAKE_HOST_SYSTEM_PROCESSOR})

    if (${HOST_ARCH} STREQUAL "i386" OR ${HOST_ARCH} STREQUAL "i486" OR ${HOST_ARCH} STREQUAL "i586" OR ${HOST_ARCH} STREQUAL "i686")
        set(NAPPGUI_HOST x86)
        set(CMAKE_ARCHITECTURE "i386" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS i386)

    elseif (${HOST_ARCH} STREQUAL "x86_64")
        set(NAPPGUI_HOST x64)
        set(CMAKE_ARCHITECTURE "x64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS i386 x64)

    elseif (${HOST_ARCH} STREQUAL "aarch64")
        set(NAPPGUI_HOST arm64)
        set(CMAKE_ARCHITECTURE "arm64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS arm64)

    elseif (${HOST_ARCH} STREQUAL "armv7")
        set(NAPPGUI_HOST arm)
        set(CMAKE_ARCHITECTURE "arm" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS arm)

    else()
        message(FATAL_ERROR "- Unknown host architecture")

    endif()

    # Architecture
    if (CMAKE_ARCHITECTURE STREQUAL "i386")
        set(NAPPGUI_ARCH x86)
        set(IDE_PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")

    elseif (CMAKE_ARCHITECTURE STREQUAL "x64")
        set(NAPPGUI_ARCH x64)
        set(IDE_PROPERTIES COMPILE_FLAGS "-m64" LINK_FLAGS "-m64")

    elseif (CMAKE_ARCHITECTURE STREQUAL "aarch64")
        set(NAPPGUI_ARCH arm64)
        set(IDE_PROPERTIES COMPILE_FLAGS " " LINK_FLAGS " ")

    elseif (CMAKE_ARCHITECTURE STREQUAL "armv7")
        set(NAPPGUI_ARCH arm)
        set(IDE_PROPERTIES COMPILE_FLAGS "-march=armv7-a")

    else()
        message(FATAL_ERROR "Unknown processor architecture '${CMAKE_ARCHITECTURE}'")

    endif()

    message(STATUS "- Build architecture: ${CMAKE_ARCHITECTURE}")
    message(STATUS "- Host architecture: ${HOST_ARCH}")

    # Build configurations
    set(CMAKE_BUILD_CONFIG "Debug" CACHE STRING "Build configuration")
    set_property(CACHE CMAKE_BUILD_CONFIG PROPERTY STRINGS "Debug;Release;ReleaseWithAssert")
    set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_CONFIG})
    message(STATUS "- Build Config: ${CMAKE_BUILD_TYPE}")

    # Package tool
	# set(CMAKE_PACKAGE FALSE CACHE BOOL "Pack executables On/Off")
    # set(CMAKE_PACKAGE_PATH "" CACHE PATH "Path to generated packages")
    # set(CMAKE_PACKAGE_GEN "TGZ" CACHE STRING "Package generator utility")
    # set_property(CACHE CMAKE_PACKAGE_GEN PROPERTY STRINGS "TGZ")

    # ToolKit
    set(CMAKE_TOOLKIT "GTK3" CACHE STRING "User interface Toolkit")
    set_property(CACHE CMAKE_TOOLKIT PROPERTY STRINGS "GTK3")

    # GTK3 Toolkit
    if (${CMAKE_TOOLKIT} STREQUAL "None")
        message(STATUS "- Toolkit: None (command line projects only).")

    elseif (${CMAKE_TOOLKIT} STREQUAL "GTK3")
        message(STATUS "- Toolkit: Gtk+3")
        set(NAPPGUI_COMPILER_TOOLSET ${GCC_VERSION}_gtk3)

    else()
        message(FATAL_ERROR "Unknown toolkit ${CMAKE_TOOLKIT}")

    endif()

    # NRC executable permissions
    set(NRC_FILE ${CMAKE_PRJ_PATH}/script/linux/${NAPPGUI_HOST}/nrc)
    file(TO_NATIVE_PATH \"${NRC_FILE}\" NRC_FILE)
    execute_process(COMMAND "chmod" "+x" "${NRC_FILE}")

else()
    message(FATAL_ERROR "Unknown Platform (${CMAKE_SYSTEM_NAME})")

endif()
