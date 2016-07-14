ls C:\projects\ponyc\build\
C:\projects\ponyc\build\%CONFIGURATION%\testc.exe
C:\projects\ponyc\build\%CONFIGURATION%\testrt.exe
CALL "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64\\vcvars64.bat"
C:\projects\ponyc\build\%CONFIGURATION%\ponyc.exe -V 3 -o C:\projects\ponyc\ -d -s packages/stdlib
stdlib.exe
del stdlib.exe