cmake_minimum_required(VERSION 3.16)

set(CMAKE_C_STANDARD 90)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(cplug VERSION 1.0)

# Build TCC
execute_process(
	COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc/configure
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc
)
execute_process(
	COMMAND make all
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc/
)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc/tcc
	DESTINATION ${CMAKE_BINARY_DIR}/tcc
)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc/libtcc1.a
	DESTINATION ${CMAKE_BINARY_DIR}/tcc
)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/plugin_api/base
	DESTINATION ${CMAKE_BINARY_DIR}/tcc
)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/src/test.c
	DESTINATION ${CMAKE_BINARY_DIR}/tcc
)

include_directories(
	${CMAKE_CURRENT_SOURCE_DIR}/plugin_api
	${CMAKE_CURRENT_SOURCE_DIR}/include
	${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc
)

link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/tinycc)

add_executable(cplug src/cplug.c)

target_link_libraries(cplug tcc m)
