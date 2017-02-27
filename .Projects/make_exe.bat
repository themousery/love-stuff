@echo off
if exist "..\EXEs\%~n1" (
  rd /s /q "..\EXEs\%~n1"
)
if exist "..\ZIPs\%~n1.zip" (
  del "..\ZIPs\%~n1.zip"
)
md "..\EXEs\%~n1"
zip -r -j "%~n1.love" "%1"
copy /b "love.exe"+"%~n1.love" "..\EXEs\%~n1\%~n1.exe"
del "%~n1.love"
if exist "%~n1\Resources.rc" (
  resourcehacker -open "%~n1\Resources.rc" -save "%~n1\Resources.res" -action compile -log NUL
  resourcehacker -addoverwrite "..\EXEs\%~n1\%~n1.exe", "..\EXEs\%~n1\%~n1.exe", "%~n1\Resources.res",,,
  del "%~n1\Resources.res"
)
if exist "%~n1\icon.ico" (
  set icon="%~n1\icon.ico"
) else (
  set icon="icon.ico"
)
resourcehacker -open "..\EXEs\%~n1\%~n1.exe" -save "..\EXEs\%~n1\%~n1.exe" -action addoverwrite -res %icon% -mask ICONGROUP, MAINICON,
copy "DLLs.zip" "..\EXEs\%~n1"
cd "..\EXEs\%~n1"
unzip "DLLs.zip"
del "DLLs.zip"
cd "..\..\.Projects"
zip -r -j "..\ZIPs\%~n1.zip" "..\EXEs\%~n1"