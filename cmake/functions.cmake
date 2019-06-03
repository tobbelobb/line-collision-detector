function(add_test)
  set(_OPTIONS_ARGS)
  set(_ONE_VALUE_ARGS)
  set(_MULTI_VALUE_ARGS
      SRC
      INCLUDE
      DEPENDS)

  cmake_parse_arguments(_ADD_TEST
                        "${_OPTIONS_ARGS}"
                        "${_ONE_VALUE_ARGS}"
                        "${_MULTI_VALUE_ARGS}"
                        ${ARGN})

  # Mandatory
  if(_ADD_TEST_SRC)
    message(STATUS "inside SRC=${_ADD_TEST_SRC}")
  else()
    message(FATAL_ERROR "add_test: 'SRC' argument required.")
  endif()

  # Mandatory
  if(_ADD_TEST_INCLUDE)
    message(STATUS "inside INCLUDE=${_ADD_TEST_INCLUDE}")
  else()
    message(FATAL_ERROR "add_test: 'INCLUDE' argument required.")
  endif()

  # Optional
  if(_ADD_TEST_DEPENDS)
    message(STATUS "inside DEPENDS=${_ADD_TEST_DEPENDS}")
  endif()

  add_executable(${ARGV0}
                 ${_ADD_TEST_SRC})
  target_include_directories(${ARGV0}
                             PRIVATE ${_ADD_TEST_INCLUDE})
  target_link_libraries(${ARGV0}
                        PRIVATE gtest
                                ${_ADD_TEST_DEPENDS})
endfunction()
