OutFile "ponyc-installer.exe"

InstallDir $PROGRAMFILES\ponyc-nightly

Section
SetOutPath $INSTDIR
File test.txt
WriteUninstaller $INSTDIR\uninstaller.exe
SectionEnd

Section "Uninstall"
Delete $INSTDIR\uninstaller.exe
Delete $INSTDIR\test.txt
SectionEnd