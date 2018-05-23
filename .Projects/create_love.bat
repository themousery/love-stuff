@echo off
if [%1] == [] goto nope
echo **ZIPPING FOLDER INTO .LOVE FILE**
7z a "%~n1.zip" ".\%~n1\*" -r
move "%~n1.zip" "..\LOVEs\%~n1.love"
goto end
:nope
echo **NO FOLDER PROVIDED**
pause
:end