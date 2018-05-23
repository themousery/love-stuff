rd /s /q "../love-stuff/.Projects/Etiam"
xcopy /e /s /y /i "../Etiam" "../love-stuff/.Projects/Etiam"
cd "../love-stuff/.Projects/Etiam"
rd /s /q .git
del run.ahk
del README.md
del build.bat
cd ..
call build.bat Etiam
cd C:\Users\Moose\Desktop\love-stuff\ZIPs\Etiam
set datestr=%date:~4%.%time:~,5%
butler push Etiam_win64.zip themousery/etiam-secret:windows-64bit --userversion %datestr%
butler push Etiam_win32.zip themousery/etiam-secret:windows-32bit --userversion %datestr%
butler push Etiam_mac.zip themousery/etiam-secret:osx --userversion %datestr%
