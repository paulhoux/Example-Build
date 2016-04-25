@echo off
echo Formatting source files...

cd application

cd include
forfiles /s /m *.h /c "cmd /c clang-format -i -style=file @path"
forfiles /s /m *.cpp /c "cmd /c clang-format -i -style=file @path"
cd ..

cd src
forfiles /s /m *.h /c "cmd /c clang-format -i -style=file @path"
forfiles /s /m *.cpp /c "cmd /c clang-format -i -style=file @path"
cd..

cd..