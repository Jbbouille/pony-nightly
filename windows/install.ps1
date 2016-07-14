cd C:\
$premakeInstalled = Test-Path C:\premake5.exe
$llvmInstalled = Test-Path C:\LLVM-3.8.0
$libsInstalled = Test-Path C:\ponyc-windows-libs

if(-Not $premakeInstalled)
{
  wget https://github.com/premake/premake-core/releases/download/v5.0.0-alpha9/premake-5.0.0-alpha9-windows.zip -OutFile C:\premake5.zip
  7z x C:\premake5.zip
  del C:\premake5.zip
}

if(-Not $llvmInstalled)
{
  wget "https://github.com/ponylang/ponyc-windows-llvm/releases/download/LLVM-Release-VS2015/LLVM-3.8.0-Release-VS2015.7z" -OutFile C:\LLVM.7z
  7z x C:\LLVM.7z
  del C:\LLVM.7z
}

if(-Not $libsInstalled) 
{
  md C:\ponyc-windows-libs
  cd C:\ponyc-windows-libs
  md lib
  svn co svn://vcs.exim.org/pcre2/code/tags/pcre2-10.21 pcre2
  md pcre2.build
  cd pcre2.build
  cmake ..\pcre2 -G "Visual Studio 14 2015 Win64"
  msbuild PCRE2.sln /t:pcre2-8 /p:Configuration=Release
  copy Release\pcre2-8.lib ..\lib
  cd ..
  wget http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.1.4-windows.zip -OutFile libressl-2.1.4-windows.zip
  unzip -o libressl-2.1.4-windows.zip
  copy libressl-2.1.4-windows\x64\libssl-32.* lib
  copy libressl-2.1.4-windows\x64\libcrypto-32.* lib
}

$env:LIB = "C:\ponyc-windows-libs\lib;" + $env:LIB
$env:path += ";C:\ponyc-windows-libs\lib;C:\LLVM-${env:llvm}\bin"