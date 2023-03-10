# CMake Xcode Warnings config
# This file is part of NAppGUI-SDK project
# See README.txt and LICENSE.txt

# MacOS GCC Configuration
#------------------------------------------------------------------------------
macro(configureMacOSGcc)
    set(IDE_PROPERTIES
        # GCC Code generation
        XCODE_ATTRIBUTE_GCC_FAST_OBJC_DISPATCH                      "YES"
        XCODE_ATTRIBUTE_GCC_AUTO_VECTORIZATION                      "YES"
        XCODE_ATTRIBUTE_GCC_OBJC_CALL_CXX_CDTORS                    "YES"
        XCODE_ATTRIBUTE_GCC_ENABLE_SSE3_EXTENSIONS                  "YES"
        XCODE_ATTRIBUTE_GCC_ENABLE_SSE41_EXTENSIONS                 "YES"
        XCODE_ATTRIBUTE_GCC_ENABLE_SSE42_EXTENSIONS                 "YES"
        XCODE_ATTRIBUTE_GCC_ENABLE_SUPPLEMENTAL_SSE3_INSTRUCTIONS   "YES"
        XCODE_ATTRIBUTE_GCC_MODEL_TUNING "None"

        # GCC Language
        XCODE_ATTRIBUTE_GCC_CHAR_IS_UNSIGNED_CHAR           "YES"
        XCODE_ATTRIBUTE_GCC_ENABLE_CPP_EXCEPTIONS           "NO"
        XCODE_ATTRIBUTE_GCC_ENABLE_CPP_RTTI                 "NO"
        XCODE_ATTRIBUTE_GCC_ENABLE_EXCEPTIONS               "NO"
        XCODE_ATTRIBUTE_GCC_ENABLE_OBJC_EXCEPTIONS          "NO"

        # GCC Warnings
        XCODE_ATTRIBUTE_GCC_WARN_CHECK_SWITCH_STATEMENTS            "YES"
        XCODE_ATTRIBUTE_GCC_WARN_FOUR_CHARACTER_CONSTANTS           "YES"

        # Library control singletons use global destructors
        # Avoid the Warning
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_GLOBAL_CONSTRUCTORS          "NO"

        XCODE_ATTRIBUTE_GCC_WARN_SHADOW                             "YES"
        XCODE_ATTRIBUTE_GCC_WARN_64_TO_32_BIT_CONVERSION            "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ALLOW_INCOMPLETE_PROTOCOL          "YES"
        XCODE_ATTRIBUTE_GCC_WARN_INITIALIZER_NOT_FULLY_BRACKETED    "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_RETURN_TYPE                  "YES"
        XCODE_ATTRIBUTE_GCC_WARN_MISSING_PARENTHESES                "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_FIELD_INITIALIZERS   "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_PROTOTYPES           "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_NEWLINE              "NO"
        XCODE_ATTRIBUTE_GCC_WARN_MULTIPLE_DEFINITION_TYPES_FOR_SELECTOR "NO"
        XCODE_ATTRIBUTE_GCC_WARN_NON_VIRTUAL_DESTRUCTOR             "YES"
        XCODE_ATTRIBUTE_GCC_WARN_HIDDEN_VIRTUAL_FUNCTIONS           "YES"
        XCODE_ATTRIBUTE_GCC_WARN_PEDANTIC                           "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_POINTER_SIGNEDNESS           "YES"
        XCODE_ATTRIBUTE_GCC_WARN_PROTOTYPE_CONVERSION               "NO"
        XCODE_ATTRIBUTE_GCC_WARN_SIGN_COMPARE                       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_STRICT_SELECTOR_MATCH              "NO"
        XCODE_ATTRIBUTE_GCC_TREAT_IMPLICIT_FUNCTION_DECLARATIONS_AS_ERRORS "YES"
        XCODE_ATTRIBUTE_GCC_TREAT_NONCONFORMANT_CODE_ERRORS_AS_WARNINGS "NO"
        XCODE_ATTRIBUTE_GCC_TREAT_WARNINGS_AS_ERRORS                "NO"
        XCODE_ATTRIBUTE_GCC_WARN_TYPECHECK_CALLS_TO_PRINTF          "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNDECLARED_SELECTOR                "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNINITIALIZED_AUTOS                "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNKNOWN_PRAGMAS                    "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_FUNCTION                    "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_LABEL                       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_PARAMETER                   "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_VALUE                       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_VARIABLE                    "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS         "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_INVALID_OFFSETOF_MACRO       "YES"
	    # Avoid warnings when C90 is used
        XCODE_ATTRIBUTE_WARNING_CFLAGS                              "-Wno-long-long -Wno-overlength-strings")

    # C/C++ Compiler Flags
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -D_DEBUG -Wno-uninitialized")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG -Wno-uninitialized")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wno-strict-aliasing")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wno-strict-aliasing")
    set(CMAKE_C_FLAGS_RELEASEWITHASSERT "${CMAKE_C_FLAGS_RELEASEWITHASSERT} -Wno-strict-aliasing")
    set(CMAKE_CXX_FLAGS_RELEASEWITHASSERT "${CMAKE_CXX_FLAGS_RELEASEWITHASSERT} -Wno-strict-aliasing")
endmacro()

# MacOS Clang Configuration
#------------------------------------------------------------------------------
macro(configureMacOSClang)
    set(IDE_PROPERTIES

        # Code generation
        XCODE_ATTRIBUTE_GCC_NO_COMMON_BLOCKS                    "YES"

        # Preprocessing
        XCODE_ATTRIBUTE_ENABLE_STRICT_OBJC_MSGSEND              "YES"

        # Architectures
        XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH                        "YES"

        # Warning policies
        XCODE_ATTRIBUTE_GCC_WARN_PEDANTIC                       "YES"

        # Warning All Languages
        XCODE_ATTRIBUTE_CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING  "YES"
        XCODE_ATTRIBUTE_GCC_WARN_CHECK_SWITCH_STATEMENTS        "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS     "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_DOCUMENTATION_COMMENTS       "NO"
        XCODE_ATTRIBUTE_CLANG_WARN_EMPTY_BODY                   "YES"
        XCODE_ATTRIBUTE_GCC_WARN_FOUR_CHARACTER_CONSTANTS       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_SHADOW                         "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_BOOL_CONVERSION              "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_CONSTANT_CONVERSION          "YES"
        XCODE_ATTRIBUTE_GCC_WARN_64_TO_32_BIT_CONVERSION        "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_ENUM_CONVERSION              "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_FLOAT_CONVERSION             "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_INT_CONVERSION               "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_NON_LITERAL_NULL_CONVERSION  "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_IMPLICIT_SIGN_CONVERSION     "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_INFINITE_RECURSION           "YES"
        XCODE_ATTRIBUTE_GCC_WARN_INITIALIZER_NOT_FULLY_BRACKETED "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_RETURN_TYPE              "YES"
        XCODE_ATTRIBUTE_GCC_WARN_MISSING_PARENTHESES            "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_FIELD_INITIALIZERS "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_PROTOTYPES       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_MISSING_NEWLINE          "NO"
        XCODE_ATTRIBUTE_CLANG_WARN_ASSIGN_ENUM                  "YES"
        XCODE_ATTRIBUTE_GCC_WARN_ABOUT_POINTER_SIGNEDNESS       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_SIGN_COMPARE                   "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_STRICT_PROTOTYPES            "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_COMMA                        "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_SUSPICIOUS_IMPLICIT_CONVERSION "YES"
        XCODE_ATTRIBUTE_GCC_TREAT_INCOMPATIBLE_POINTER_TYPE_WARNINGS_AS_ERRORS "NO"
        XCODE_ATTRIBUTE_GCC_TREAT_IMPLICIT_FUNCTION_DECLARATIONS_AS_ERRORS "YES"
        XCODE_ATTRIBUTE_GCC_WARN_TYPECHECK_CALLS_TO_PRINTF      "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_UNGUARDED_AVAILABILITY       "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNINITIALIZED_AUTOS            "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNKNOWN_PRAGMAS                "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_UNREACHABLE_CODE             "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_FUNCTION                "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_LABEL                   "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_PARAMETER               "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_VALUE                   "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNUSED_VARIABLE                "YES"

        # Warning C++
        XCODE_ATTRIBUTE_CLANG_WARN_RANGE_LOOP_ANALYSIS          "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_SUSPICIOUS_MOVE              "YES"

        # Warning Objective-C
        XCODE_ATTRIBUTE_CLANG_WARN__DUPLICATE_METHOD_MATCH      "YES"
        XCODE_ATTRIBUTE_GCC_WARN_UNDECLARED_SELECTOR            "YES")


    # Avoid warnings when C90 is used
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wno-long-long -Wno-overlength-strings")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wno-long-long -Wno-overlength-strings")
    set(CMAKE_C_FLAGS_RELEASEWITHASSERT "${CMAKE_C_FLAGS_RELEASEWITHASSERT} -Wno-long-long -Wno-overlength-strings")

    # Avoid Linker warnings in user distributions
    # (Debug symbols DWARF)
    if (RELEASE_DISTRIBUTION)
        SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -Xlinker -w")
    endif()

    # C/C++ Compiler Flags
    if(${XCODE_VERSION} VERSION_GREATER "7.99.99")

        set(IDE_PROPERTIES ${IDE_PROPERTIES}
            XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_WEAK          "YES")

        set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wno-undefined-var-template")
        set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wno-undefined-var-template")
        set(CMAKE_C_FLAGS_RELEASEWITHASSERT "${CMAKE_C_FLAGS_RELEASEWITHASSERT}")
        set(CMAKE_CXX_FLAGS_RELEASEWITHASSERT "${CMAKE_CXX_FLAGS_RELEASEWITHASSERT} -Wno-undefined-var-template")
    endif()

endmacro()
