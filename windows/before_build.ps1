rmdir /s /q C:\projects\ponyc
git clone -q --depth=10 --branch=master https://github.com/ponylang/ponyc.git C:\projects\ponyc
cd C:\projects\ponyc
C:\premake5.exe --with-tests --to=work/vs2015 vs2015