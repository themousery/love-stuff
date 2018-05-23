@echo off
if [%1] == [] goto nofolder
if not exist %1\main.lua goto nolove
if exist "..\EXEs\%~n1" rd /s /q "..\EXEs\%~n1"
if exist "..\EXEs\%~n1_win32" rd /s /q "..\EXEs\%~n1_win32"
if exist "..\APPs\%~n1.app" rd /s /q "..\APPs\%~n1.app"
if exist "..\ZIPs\%~n1" rd /s /q "..\ZIPs\%~n1"
if exist "..\LOVEs\%~n1.love" del "..\LOVEs\%~n1.love"
md "..\EXEs\%~n1"
md "..\EXEs\%~n1_win32"
echo **ZIPPING FOLDER INTO .LOVE FILE**
7z a "%~n1.zip" ".\%~n1\*" -r
move "%~n1.zip" "..\LOVEs\%~n1.love"
echo **CREATING .EXE FILE**
copy /b "love.exe"+"..\LOVEs\%~n1.love" "..\EXEs\%~n1\%~n1.exe"
copy /b "..\.utils\love_win32.exe"+"..\LOVEs\%~n1.love" "..\EXEs\%~n1_win32\%~n1.exe"
if exist "%~n1\versioninfo.res" (
  echo **ADDING VERSIONINFO TO .EXE FILE**
  resourcehacker -addoverwrite "..\EXEs\%~n1\%~n1.exe", "..\EXEs\%~n1\%~n1.exe", "%~n1\versioninfo.res",,,
) else (
  echo **NO VERSIONINFO.RES FILE PROVIDED, USING DEFAULT**
)
if exist "%~n1\icon.ico" (
  set icon="%~n1\icon.ico"
) else (
  set icon="..\.utils\icon.ico"
  echo **NO ICON FILE PROVIDED, USING DEFAULT**
)
echo **ADDING ICON TO .EXE FILE**
resourcehacker -open "..\EXEs\%~n1\%~n1.exe" -save "..\EXEs\%~n1\%~n1.exe" -action addoverwrite -res %icon% -mask ICONGROUP,1,1033
echo **ADDING DLLS TO EXE DIRECTORY**
copy "..\.utils\DLLs.zip" "..\EXEs\%~n1"
copy "..\.utils\DLLs_win32.zip" "..\EXEs\%~n1_win32"
cd "..\EXEs\%~n1"
7z e "DLLs.zip"
del "DLLs.zip"
cd "..\%~n1_win32"
7z e "DLLs_win32.zip"
del "DLLs_win32.zip"
echo **CREATING .APP FILE**
cd "..\..\APPs"
xcopy /e /s /y /i "..\.utils\love.app" "%~n1.app"
xml ed --inplace -u //string[.='org.love2d.love'] -v com.themousery.%~n1 %~n1.app/Contents/info.plist
xml ed --inplace -u //string[.='bundlename'] -v %~n1 %~n1.app/Contents/info.plist
xml ed --inplace -d //key[.='UTExportedTypeDeclarations'] %~n1.app/contents/info.plist
xml ed --inplace -d //key[.='UTTypeConformsTo']/../.. %~n1.app/contents/info.plist
copy "..\LOVEs\%~n1.love" "%~n1.app/contents/resources"
cd "..\.Projects"
echo **ZIPPING INTO ..\ZIPs**
md "..\ZIPs\%~n1"
7z a "..\ZIPs\%~n1\%~n1_win64.zip" "..\EXEs\%~n1" -r
7z a "..\ZIPs\%~n1\%~n1_win32.zip" "..\EXEs\%~n1_win32" -r
7z a "..\ZIPs\%~n1\%~n1_mac.zip" "..\APPs\%~n1.app\"
goto end
:nofolder
echo No folder provided.
pause
goto end
:nolove
echo The folder/file provided does not contain a main.lua, and is not Love2d compatible.
pause
:end