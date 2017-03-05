@echo off
if exist "..\EXEs\%~n1" (
  rd /s /q "..\EXEs\%~n1"
)
if exist "..\ZIPs\%~n1.zip" (
  del "..\ZIPs\%~n1.zip"
)
md "..\EXEs\%~n1"
echo **ZIPPING FOLDER INTO .LOVE FILE**
7z a "%~n1.zip" ".\%~n1\*" -r
move "%~n1.zip" "%~n1.love"
echo **CREATING .EXE FILE**
taskkill /F /IM 7z.exe /T
copy /b "love.exe"+"%~n1.love" "..\EXEs\%~n1\%~n1.exe"
del "%~n1.love"
if exist "%~n1\versioninfo.res" (
  echo **ADDING VERSIONINFO TO .EXE FILE**
  resourcehacker -addoverwrite "..\EXEs\%~n1\%~n1.exe", "..\EXEs\%~n1\%~n1.exe", "%~n1\versioninfo.res",,,
) else (
  echo **NO VERSIONINFO.RES FILE PROVIDED, USING DEFAULT**
)
if exist "%~n1\icon.ico" (
  set icon="%~n1\icon.ico"
) else (
  set icon="icon.ico"
  echo **NO ICON FILE PROVIDED, USING DEFAULT**
)
echo **ADDING ICON TO .EXE FILE**
resourcehacker -open "..\EXEs\%~n1\%~n1.exe" -save "..\EXEs\%~n1\%~n1.exe" -action addoverwrite -res %icon% -mask ICONGROUP,1,1033
echo **ADDING DLLS TO  EXE DIRECTORY**
copy "DLLs.zip" "..\EXEs\%~n1"
cd "..\EXEs\%~n1"
7z e "DLLs.zip"
del "DLLs.zip"
cd "..\..\.Projects"
echo **ZIPPING INTO ..\ZIPs**
7z a "..\ZIPs\%~n1.zip" "..\EXEs\%~n1" -r