# CMake Xcode Version Checker
# This file is part of NAppGUI-SDK project
# See README.txt and LICENSE.txt


# Get macOS version from system
#------------------------------------------------------------------------------
function(osVersion _ret)
    execute_process (
        COMMAND bash -c "sw_vers -productVersion"
        OUTPUT_VARIABLE version
    )
    set(${_ret} ${version} PARENT_SCOPE)
endfunction()

# Get macOS name from SDK
#------------------------------------------------------------------------------
function(osxSDKName sdkVersion _ret)
    if (${sdkVersion} STREQUAL "13.1")
        set(${_ret} "Ventura" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "13.0")
        set(${_ret} "Ventura" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "12.4")
        set(${_ret} "Monterey" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "12.3")
        set(${_ret} "Monterey" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "12.2")
        set(${_ret} "Monterey" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "12.0")
        set(${_ret} "Monterey" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.5")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.4")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.3")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.2")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.1")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "11.0")
        set(${_ret} "Big Sur" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.15")
        set(${_ret} "Catalina" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.14")
        set(${_ret} "Mojave" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.13")
        set(${_ret} "High Sierra" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.12")
        set(${_ret} "Sierra" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.11")
        set(${_ret} "El Capitan" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.10")
        set(${_ret} "Yosemite" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.9")
        set(${_ret} "Mavericks" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.8")
        set(${_ret} "Mountian Lion" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.7")
        set(${_ret} "Lion" PARENT_SCOPE)
    elseif (${sdkVersion} STREQUAL "10.6")
        set(${_ret} "Snow Leopard" PARENT_SCOPE)
    else()
        set(${_ret} "Unknown macOS version" PARENT_SCOPE)
    endif()
endfunction()

#------------------------------------------------------------------------------
macro(checkClangCompiler)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
        message(STATUS "- Clang compiler (${CMAKE_CXX_COMPILER_VERSION})")
        configureMacOSClang()
    else()
        message(FATAL_ERROR "- Unknown compiler")
    endif()
endmacro()

# Check for valid Xcode version
#------------------------------------------------------------------------------
macro(checkXcodeVersion)

    if (${XCODE_VERSION} VERSION_LESS "3.2.6")
        message(FATAL_ERROR "Xcode 3.2.6 is the minimun supported version.")
    endif()

    if (NOT ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
        message(FATAL_ERROR "Unknown Apple CMAKE_SYSTEM_NAME.")
    endif()

    # Xcode 14
    if(XCODE_VERSION VERSION_GREATER 13.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 13.0)
        set(CMAKE_DEPLOYMENT_TARGET "13.0" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "13.1;13.0;12.4;12.3;12.2;12.0;11.5;11.4;11.3;11.2;11.1;11.0;10.15;10.14;10.13")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;arm64")

    # Xcode 13
    elseif(XCODE_VERSION VERSION_GREATER 12.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 12.3)
        set(CMAKE_DEPLOYMENT_TARGET "12.3" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "12.3;12.2;12.0;11.5;11.4;11.3;11.2;11.1;11.0;10.15;10.14;10.13")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;arm64")

    # Xcode 12
    elseif(XCODE_VERSION VERSION_GREATER 11.99)
        checkClangCompiler()
        osVersion(OS_VERSION)

        # Catalina can use Xcode 12 up to 12.4
        if(OS_VERSION VERSION_LESS 11.0 AND XCODE_VERSION VERSION_LESS 12.4)
            set(BASE_OSX_SDK 10.15)
            set(CMAKE_DEPLOYMENT_TARGET "10.15" CACHE STRING "Minimun macOS version required")
            set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.15;10.14;10.13;10.12;10.11;10.10;10.9")
            set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
            set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64")
        else()
            set(BASE_OSX_SDK 11.0)
            set(CMAKE_DEPLOYMENT_TARGET "11.0" CACHE STRING "Minimun macOS version required")
            set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "11.5;11.4;11.3;11.2;11.1;11.0;10.15;10.14;10.13;10.12;10.11;10.10;10.9")
            set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
            set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;arm64")
        endif()

    # Xcode 11
    elseif(XCODE_VERSION VERSION_GREATER 10.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.15)
        set(CMAKE_DEPLOYMENT_TARGET "10.15" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.15;10.14;10.13;10.12;10.11;10.10;10.9")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64")

    # Xcode 10
    elseif(XCODE_VERSION VERSION_GREATER 9.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.14)
        set(CMAKE_DEPLOYMENT_TARGET "10.14" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.14;10.13;10.12;10.11;10.10;10.9")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64")

    # Xcode 9
    elseif(XCODE_VERSION VERSION_GREATER 8.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.13)
        set(CMAKE_DEPLOYMENT_TARGET "10.13" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.13;10.12;10.11;10.10;10.9")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 8
    elseif(XCODE_VERSION VERSION_GREATER 7.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.12)
        set(CMAKE_DEPLOYMENT_TARGET "10.12" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.12;10.11;10.10;10.9")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 7
    elseif(XCODE_VERSION VERSION_GREATER 6.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.11)
        set(CMAKE_DEPLOYMENT_TARGET "10.11" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.11;10.10;10.9;10.8;10.7;10.6")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 6.4
    elseif(XCODE_VERSION VERSION_GREATER 6.3.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.10)
        set(CMAKE_DEPLOYMENT_TARGET "10.10" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.10;10.9;10.8;10.7;10.6")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 6.2
    elseif(XCODE_VERSION VERSION_GREATER 5.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.9)
        set(CMAKE_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.9;10.8;10.7;10.6")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 5
    elseif(XCODE_VERSION VERSION_GREATER 4.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.8)
        set(CMAKE_DEPLOYMENT_TARGET "10.8" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.8;10.7;10.6")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 4
    elseif(XCODE_VERSION VERSION_GREATER 3.99)
        checkClangCompiler()
        set(BASE_OSX_SDK 10.7)
        set(CMAKE_DEPLOYMENT_TARGET "10.7" CACHE STRING "Minimun macOS version required")
        set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.7;10.6")
        set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
        set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")

    # Xcode 3
    else()
        if (CMAKE_COMPILER_IS_GNUCC)
            message(STATUS "- GCC compiler (${CMAKE_CXX_COMPILER_VERSION})")
            configureMacOSGcc()
            set(BASE_OSX_SDK 10.6)
            set(CMAKE_DEPLOYMENT_TARGET "10.6" CACHE STRING "Minimun macOS version required")
            set_property(CACHE CMAKE_DEPLOYMENT_TARGET PROPERTY STRINGS "10.6")
            set(CMAKE_ARCHITECTURE "x86_64" CACHE STRING "Processor architecture")
            set_property(CACHE CMAKE_ARCHITECTURE PROPERTY STRINGS "x86_64;i386")
        else()
            message(FATAL_ERROR "- Unknown compiler")
        endif()

    endif()

endmacro()
