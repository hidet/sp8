#----------------------------------------------------------------------------
# Setup the project
cmake_minimum_required(VERSION 2.6 FATAL_ERROR)

#########################

set(name sp8)
set(useROOT true)
set(CMAKE_MODULE_PATH "/Users/tatsuno/cern/GEANT4/geant4.10.05-install/lib/Geant4-10.5.1/Modules")

#########################

set(mymain ${name}.cc)
set(myexe  g4_${name})
set(myproj ${name})

project(${myproj})


#----------------------------------------------------------------------------
# Find Geant4 package, activating all available UI and Vis drivers by default
# You can set WITH_GEANT4_UIVIS to OFF via the command line or ccmake/cmake-gui
# to build a batch mode only executable
#
option(WITH_GEANT4_UIVIS "Build example with Geant4 UI and Vis drivers" ON)
if(WITH_GEANT4_UIVIS)
  find_package(Geant4 REQUIRED ui_all vis_all)
  include(${Geant4_USE_FILE})
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
else()
  find_package(Geant4 REQUIRED)
  include(${Geant4_USE_FILE})
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
endif()

#----------------------------------------------------------------------------
# Find ROOT variables if the variable G4ANALYSIS_USE_ROOT is set
list(APPEND CMAKE_PREFIX_PATH $ENV{ROOTSYS})
find_package(ROOT REQUIRED)
if(useROOT)
	EXECUTE_PROCESS(COMMAND root-config --cflags OUTPUT_VARIABLE ROOT_CXX_FLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ROOT_CXX_FLAGS}")
endif(useROOT) 

include_directories(${CMAKE_CURRENT_SOURCE_DIR}  ${ROOT_INCLUDE_DIRS} ${Geant4_INCLUDE_DIRS})

#----------------------------------------------------------------------------
# Locate sources and headers for this project
# NB: headers are included so they will show up in IDEs
#
file(GLOB sources ${PROJECT_SOURCE_DIR}/src/*.cc)
file(GLOB headers ${PROJECT_SOURCE_DIR}/include/*.hh)

#----------------------------------------------------------------------------
# Add the executable, and link it to the Geant4 libraries
#
add_executable(${myexe} ${mymain} ${sources} ${headers})
if(useROOT)
	EXECUTE_PROCESS(COMMAND root-config --libs OUTPUT_VARIABLE ROOT_LD_FLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
	set(CMAKE_EXE_LINKER_FLAGS ${ROOT_LD_FLAGS})
endif(useROOT)
target_link_libraries(${myexe} ${Geant4_LIBRARIES} ${ROOT_LIBRARIES})


#----------------------------------------------------------------------------
# For internal Geant4 use - but has no effect if you build this example standalone
#
add_custom_target(${myproj} DEPENDS ${myexe})

#----------------------------------------------------------------------------
# Install the executable to 'bin' directory under CMAKE_INSTALL_PREFIX
#
install(TARGETS ${myexe} DESTINATION bin)
