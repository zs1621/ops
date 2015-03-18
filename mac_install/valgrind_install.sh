git clone https://github.com/fredericgermain/valgrind/ -b homebrew
cd valgrind
# Because he placed VEX as a git submodule, we have to make sure we clone it too
git submodule init
git submodule update
# With VEX submodule now available, we can compile valgrind
./autogen.sh
./configure
make
sudo make install
