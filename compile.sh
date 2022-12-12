cmake -S . -B build -GNinja -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Debug
cd build
ninja
cd ..
