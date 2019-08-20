###Modify CMakeLists.txt

set(name sp8)

set(useROOT true)

set(CMAKE_MODULE_PATH "/Users/tatsuno/cern/GEANT4/geant4.10.05-install/lib/Geant4-10.5.1/Modules")

### How to use

cd build

cmake ..

make

./g4_sp8 mac/

The .mac files in mac folder contain important parameters

You can specify,

 target material

 target density

 beam particle

 beam energy

 beam momentum

 beam direction

 beam position

 output file name

etc...
