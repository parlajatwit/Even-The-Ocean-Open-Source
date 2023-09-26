#!/usr/bin/env bash

even=$(pwd)

# install haxe and neko
cd /opt/
sudo curl -sL https://github.com/HaxeFoundation/neko/releases/download/v2-1-0/neko-2.1.0-linux64.tar.gz | sudo tar -xz
sudo curl -sL https://github.com/HaxeFoundation/haxe/releases/download/3.4.7/haxe-3.4.7-linux64.tar.gz | sudo tar -xz
sudo mv haxe_20180221160843_bb7b827/ haxe_3.4.7
echo "export NEKOPATH=/opt/neko-2.1.0-linux64/" >> ~/.bashrc
echo "export HAXE_STD_PATH=/opt/haxe_3.4.7/std" >> ~/.bashrc
echo 'export PATH=/opt/haxe_3.4.7/:/opt/neko-2.1.0-linux64/:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/neko-2.1.0-linux64/:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# install libaries
cd "$even"
./installHaxeLibraries.sh
lib=$(cat ~/.haxelib)

# build hxcpp
cd "$lib/hxcpp/3,4,188/project"
neko build.n linux
## fix dynamic error throwing
cp "$even/hxcpp/Linux/CFFI.cpp" ../src/hx/

# apply hantani flixel changes
cd "$even/../txt"
cp -TR flixel "$lib/flixel/4,0,0"
cp addons/FlxTilemapExt.hx "$lib/flixel-addons/2,0,0/flixel/addons/tile"
